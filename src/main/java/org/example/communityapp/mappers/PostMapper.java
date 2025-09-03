package org.example.communityapp.mappers;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.example.communityapp.domain.*;

import java.util.List;
import java.util.Optional;

@Mapper
public interface PostMapper {

    Optional<PostVO> findById(Long id);

    List<PostListDTO> getPage(Criteria criteria);

    int getTotal(Criteria criteria);

    Optional<PostModifyForm> getModifyForm(Long postId);

    Optional<PostDetailDTO> selectPostDetailById(Long postId);

    int insertPost(PostVO post);

    int updatePost(PostVO post);

    String selectWriterByPostId(Long postId);

    int deletePostByIdAndUserId(@Param("postId") Long postId, @Param("userId") String userId);

    Boolean ifExists(Long postId);
}
