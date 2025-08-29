package org.example.communityapp.mappers;

import org.apache.ibatis.annotations.Mapper;
import org.example.communityapp.domain.Criteria;
import org.example.communityapp.domain.PostVO;
import org.example.communityapp.domain.PostListDTO;

import java.util.List;

@Mapper
public interface PostMapper {

    List<PostListDTO> getPage(Criteria criteria);

    int getTotal(Criteria criteria);

    int insertPost(PostVO post);
}
