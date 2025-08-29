package org.example.communityapp.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.communityapp.Exception.DuplicateUserInfoException;
import org.example.communityapp.Exception.SignupFailedException;
import org.example.communityapp.Exception.SignupValidationException;
import org.example.communityapp.common.enums.RoleType;
import org.example.communityapp.domain.SignupRequestDTO;
import org.example.communityapp.domain.UserVO;
import org.example.communityapp.mappers.UsersMapper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class AuthServiceImpl implements AuthService {

    private final UsersMapper usersMapper;
    private final PasswordEncoder passwordEncoder;

    @Override
    public void signup(SignupRequestDTO signupRequestDTO) {
        // 사용자 입력값 유효성 확인
        if (!signupRequestDTO.equalsPasswords()) {  // 두 개의 비밀번호 일치여부 확인
            throw new SignupValidationException("확인 비밀번호가 일치하지 않습니다.");
        }
        usersMapper.findByEmail(signupRequestDTO.getEmail()).ifPresent(user -> {  // 이메일 중복 확인
            throw new DuplicateUserInfoException("사용 중인 이메일입니다.");
        });
        usersMapper.findByNickname(signupRequestDTO.getName()).ifPresent(user -> {  // 닉네임 중복 확인
            throw new DuplicateUserInfoException("사용 중인 닉네임입니다.");
        });

        // user 정보 저장
        UserVO userVO = new UserVO();
        userVO.setUserId(UUID.randomUUID().toString());
        userVO.setEmail(signupRequestDTO.getEmail());
        userVO.setPassword(passwordEncoder.encode(signupRequestDTO.getPassword()));
        userVO.setNickname(signupRequestDTO.getName());
        userVO.setRole(RoleType.USER);
        userVO.setIsDeleted(false);
        int count = usersMapper.insertUser(userVO);
        if (count != 1) {
            throw new SignupFailedException("회원가입에 실패했습니다.");
        }
    }
}
