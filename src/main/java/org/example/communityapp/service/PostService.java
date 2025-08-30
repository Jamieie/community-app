package org.example.communityapp.service;

import org.example.communityapp.domain.*;

import java.util.List;

public interface PostService {
    List<PostListDTO> getPage(Criteria criteria);

    int getTotal(Criteria criteria);

    PostDetailDTO getPostDetails(Long postId);

    Long register(CreatePostRequestDTO createPostRequestDTO, String userId);

    PostModifyForm getModifyForm(Long postId, String userId);

    Long modify(ModifyPostRequestDTO modifyPostRequestDTO, Long postId, String UserId);

    void remove(Long postId, String userId);
}
