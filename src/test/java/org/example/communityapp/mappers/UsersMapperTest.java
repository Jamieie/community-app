package org.example.communityapp.mappers;

import lombok.extern.slf4j.Slf4j;
import org.example.communityapp.common.enums.RoleType;
import org.example.communityapp.domain.UserVO;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;

@Slf4j
@ExtendWith(SpringExtension.class)
@ContextConfiguration("classpath:spring/test-root-context.xml")
class UsersMapperTest {

    @Autowired(required = false)
    UsersMapper usersMapper;

    private String email;
    private String nickname;

    private UserVO getUserVO() {
        return UserVO.builder()
                .userId(UUID.randomUUID().toString())
                .email(email)
                .nickname(nickname)
                .password("password")
                .role(RoleType.USER)
                .isDeleted(false)
                .build();
    }

    @Test
    void insertUser() {
        email = "test@email.com";
        nickname = "nickname";
        UserVO userVO = getUserVO();
        int count = usersMapper.insertUser(userVO);
        assertEquals(1, count);
    }

    @Test
    void findUserByEmail() {
        email = "test@email.com1";
        nickname = "nickname1";
        UserVO userVO = getUserVO();
        usersMapper.insertUser(userVO);
        UserVO byEmail = usersMapper.findByEmail(email).get();
        assertNotNull(byEmail);
    }

    @Test
    void findUserByNickname() {
        email = "test@email.com2";
        nickname = "nickname2";
        UserVO userVO = getUserVO();
        usersMapper.insertUser(userVO);
        UserVO byNickname = usersMapper.findByNickname(nickname).get();
        assertNotNull(byNickname);
    }
}