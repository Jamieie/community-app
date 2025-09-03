package org.example.communityapp.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.communityapp.Exception.CommentCreationFailedException;
import org.example.communityapp.Exception.CommentModificationFailedException;
import org.example.communityapp.Exception.CommentRemoveFailedException;
import org.example.communityapp.Exception.ResourceNotFoundException;
import org.example.communityapp.domain.*;
import org.example.communityapp.mappers.CommentMapper;
import org.example.communityapp.mappers.PostMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class CommentServiceImpl implements CommentService {

    private final CommentMapper commentMapper;
    private final PostMapper postMapper;

    // 댓글 조회 (페이지 단위)
    @Override
    public List<CommentDetailDTO> getCommentsPage(CommentCursorRequest commentCursorRequest,
                                                  Long postId) {
        // post가 존재하는지 확인 후 없으면 예외 발생
        if(!postMapper.ifExists(postId)) {
            throw new ResourceNotFoundException("게시글", postId);
        }

        // CursorToken 객체 생성하여 댓글 목록 조회
        CursorToken cursorToken = new CursorToken(commentCursorRequest.getAfter());
        return commentMapper.getCommentsPage(postId, cursorToken, commentCursorRequest.getLimit());
    }

    // 게시글에 추가로 댓글이 더 있는지 확인
    @Override
    public Boolean hasNext(Long postId, String cursor) {
        CursorToken cursorToken = new CursorToken(cursor.trim());
        return commentMapper.hasNext(postId, cursorToken);
    }

    // 댓글 등록
    @Override
    public CommentDetailDTO register(CreateCommentRequestDTO createCommentRequestDTO,
                                            Long postId, String userId) {
        // post가 존재하는지 확인 후 없으면 예외 발생
        if(!postMapper.ifExists(postId)) {
            throw new ResourceNotFoundException("게시글", postId);
        }

        // 댓글 등록 후 댓글의 id 상세 내용 조회해서 결과 반환
        CommentVO commentVO = new CommentVO(postId, userId,
                createCommentRequestDTO.getContent(),
                createCommentRequestDTO.getPatientId());
        if(commentMapper.insertComment(commentVO) != 1) {
            throw new CommentCreationFailedException("댓글 등록에 실패했습니다.");
        }

        Long commentId = commentVO.getCommentId();
        return commentMapper.selectCommentDetailById(commentId).orElseThrow(
                () -> new ResourceNotFoundException("댓글", commentId));
    }

    @Override
    public CommentDetailDTO modify(Long postId, ModifyCommentRequestDTO modifyCommentRequestDTO,
                                   Long commentId, String userId) {
        // post가 존재하는지 확인 후 없으면 예외 발생
        if(!postMapper.ifExists(postId)) {
            throw new ResourceNotFoundException("게시글", postId);
        }

        CommentVO commentVO = CommentVO.builder()
                .commentId(commentId)
                .writer(userId)
                .content(modifyCommentRequestDTO.getContent())
                .build();

        if (commentMapper.updateComment(commentVO) != 1) {
            throw new CommentModificationFailedException("댓글 수정에 실패했습니다.");
        }

        return commentMapper.selectCommentDetailById(commentId).orElseThrow(
                () -> new ResourceNotFoundException("댓글", commentId));
    }

    @Override
    public void remove(Long commentId, String userId) {
        int count = commentMapper.deleteCommentByIdAndUserId(commentId, userId);
        if(count != 1) {
            throw new CommentRemoveFailedException("댓글 삭제에 실패했습니다.");
        }
    }

}
