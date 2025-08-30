package org.example.communityapp.mappers;

import lombok.extern.slf4j.Slf4j;
import org.example.communityapp.common.enums.RoleType;
import org.example.communityapp.domain.*;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;

@Slf4j
@ExtendWith(SpringExtension.class)
@ContextConfiguration("classpath:spring/test-root-context.xml")
class PostMapperTest {

    @Autowired(required = false)
    private PostMapper postMapper;

    @Autowired(required = false)
    private UsersMapper usersMapper;

    @Test
    void getPage() {
        String userId = UUID.randomUUID().toString();

        UserVO userVO = UserVO.builder()
                .userId(userId)
                .email("email")
                .nickname("nickname")
                .password("password")
                .role(RoleType.USER)
                .isDeleted(false)
                .build();
        usersMapper.insertUser(userVO);

        PostVO postVO = new PostVO();
        postVO.setTitle("title");
        postVO.setContent("content");
        postVO.setWriter(userId);
        postVO.setViewCount(0L);
        postVO.setIsDeleted(false);

        for (int i = 0; i < 20; i++) {
            postMapper.insertPost(postVO);
        }

        Criteria criteria = new Criteria();
        List<PostListDTO> page = postMapper.getPage(criteria);
        assertEquals(10, page.size());
    }

    @Test
    void getTotal() {
        PostVO postVO = new PostVO();
        postVO.setTitle("title");
        postVO.setContent("content");
        postVO.setWriter("writer");
        postVO.setViewCount(0L);
        postVO.setIsDeleted(false);

        for (int i = 0; i < 20; i++) {
            postMapper.insertPost(postVO);
        }

        Criteria criteria = new Criteria();
        int total = postMapper.getTotal(criteria);
        assertEquals(20, total);
    }
}