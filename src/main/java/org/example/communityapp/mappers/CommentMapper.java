package org.example.communityapp.mappers;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.example.communityapp.domain.CommentVO;
import org.example.communityapp.domain.CommentDetailDTO;
import org.example.communityapp.domain.CursorToken;

import java.util.List;
import java.util.Optional;

@Mapper
public interface CommentMapper {
    int insertComment(CommentVO comment);

    Optional<CommentDetailDTO> selectCommentDetailById(Long id);

    int updateComment(CommentVO comment);

    int deleteCommentByIdAndUserId(@Param("commentId") Long commentId, @Param("userId") String userId);

    List<CommentDetailDTO> getCommentsPage(@Param("postId") Long postId, @Param("cursor") CursorToken cursor, @Param("limit") Integer limit);

    Boolean hssNext(@Param("postId") Long postId, @Param("cursor") CursorToken cursor);
}
