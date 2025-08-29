package org.example.communityapp.service;

import org.example.communityapp.domain.Criteria;
import org.example.communityapp.domain.PostListDTO;

import java.util.List;

public interface PostService {
    List<PostListDTO> getPage(Criteria criteria);

    int getTotal(Criteria criteria);
}
