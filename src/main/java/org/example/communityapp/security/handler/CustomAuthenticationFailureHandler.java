package org.example.communityapp.security.handler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import java.io.IOException;

@Log4j2
public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {
    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
        log.info("=====================CustomLoginFailureHandler===================");
        log.info("Authentication failed: {}", exception.getMessage());

        String errorMessage;
        if (exception.getMessage().contains("Bad credentials")) {
            errorMessage = "이메일 또는 비밀번호가 올바르지 않습니다.";
        } else if (exception.getMessage().contains("User account is disabled")) {
            errorMessage = "사용 중지된 계정입니다.";
        } else {
            errorMessage = "로그인에 실패했습니다. 다시 시도해주세요.";
        }

        // 세션에 에러 메시지 저장
        request.getSession().setAttribute("error", errorMessage);
        response.sendRedirect("/auth/login");
    }
}
