package org.example.communityapp.mappers;

import org.apache.ibatis.annotations.Mapper;
import org.example.communityapp.domain.UserVO;

import java.util.Optional;

@Mapper
public interface UsersMapper {

    int insertUser(UserVO user);
    Optional<UserVO> findByEmail(String email);
    Optional<UserVO> findByNickname(String nickname);
}
