package org.example.communityapp.service;

import org.example.communityapp.domain.SignupRequestDTO;

public interface AuthService {
    void signup(SignupRequestDTO signupRequestDTO);
}
