package org.example.communityapp.service;

import org.example.communityapp.domain.*;

import java.util.List;

public interface CommentService {
    // 댓글 조회 (페이지 단위)
    List<CommentDetailDTO> getCommentsPage(CommentCursorRequest commentCursorRequest,
                                           Long postId);

    // 게시글에 추가로 댓글이 더 있는지 확인
    Boolean hasNext(Long postId, String cursor);

    // 댓글 등록
    CommentDetailDTO register(CreateCommentRequestDTO createCommentRequestDTO,
                                     Long postId, String userId);

    CommentDetailDTO modify(Long postId, ModifyCommentRequestDTO modifyCommentRequestDTO,
                            Long commentId, String userId);

    void remove(Long commentId, String userId);
}
