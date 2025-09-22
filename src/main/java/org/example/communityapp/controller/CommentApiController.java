package org.example.communityapp.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.communityapp.domain.*;
import org.example.communityapp.service.CommentService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.User;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/posts/{postId:\\d+}/comments")
@RequiredArgsConstructor
@Slf4j
public class CommentApiController {

    private final CommentService commentService;

    @GetMapping
    public ResponseEntity<?> getComments(@PathVariable("postId") Long postId,
                                         @ModelAttribute @Valid CommentCursorRequest commentCursorRequest) {

        List<CommentDetailDTO> comments = commentService.getCommentsPage(commentCursorRequest, postId);  // 댓글 목록 조회
        String cursor = null;
        Boolean hasNext = false;

        if (comments != null && !comments.isEmpty()) {      // 댓글이 존재하면 커서값 추출 및 다음 댓글 존재 여부 확인
            cursor = comments.getLast().getCursor();
            hasNext = commentService.hasNext(postId, cursor);
        }


        return ResponseEntity.status(HttpStatus.OK)
                .body(new CommentPageResponse(comments, cursor, hasNext));
    }

    @PostMapping
    public ResponseEntity<?> register(@PathVariable("postId") Long postId,
                                      @RequestBody @Valid CreateCommentRequestDTO createCommentRequestDTO,
                                      @AuthenticationPrincipal CustomUserDetails user) {

        String userId = user.getUserId();
        CommentDetailDTO commentDetailDTO = commentService.register(createCommentRequestDTO, postId, userId);
        return ResponseEntity.status(HttpStatus.CREATED).body(commentDetailDTO);
    }

    @PutMapping("/{commentId:\\d+}")
    public ResponseEntity<?> modify(@PathVariable("postId") Long postId,
                                    @PathVariable("commentId") Long commentId,
                                    @RequestBody @Valid ModifyCommentRequestDTO modifyCommentRequestDTO,
                                    @AuthenticationPrincipal CustomUserDetails user) {

        String userId = user.getUserId();
        CommentDetailDTO commentDetailDTO = commentService.modify(postId, modifyCommentRequestDTO, commentId, userId);
        return ResponseEntity.status(HttpStatus.OK).body(commentDetailDTO);
    }

    @DeleteMapping("/{commentId:\\d+}")
    public ResponseEntity<?> remove(@PathVariable("postId") Long postId,
                                    @PathVariable("commentId") Long commentId,
                                    @AuthenticationPrincipal CustomUserDetails user) {

        String userId = user.getUserId();
        commentService.remove(commentId, userId);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }
}
