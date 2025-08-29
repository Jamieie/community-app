package org.example.communityapp.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.example.communityapp.domain.Criteria;
import org.example.communityapp.domain.PostListDTO;
import org.example.communityapp.mappers.PostMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
@Log4j2
public class PostServiceImpl implements PostService {

    private final PostMapper postMapper;

    @Override
    public List<PostListDTO> getPage(Criteria criteria) {
        return postMapper.getPage(criteria);
    }

    @Override
    public int getTotal(Criteria criteria) {
        return postMapper.getTotal(criteria);
    }
}
