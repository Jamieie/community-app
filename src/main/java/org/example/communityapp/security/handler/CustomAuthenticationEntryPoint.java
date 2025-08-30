package org.example.communityapp.security.handler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import java.io.IOException;

@Slf4j
public class CustomAuthenticationEntryPoint implements AuthenticationEntryPoint {
    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) throws IOException, ServletException {
        log.info("===============CustomAuthenticationEntryPoint=================");
        log.info("====request url: " + request.getRequestURL().toString());
        log.info("====request method: " + request.getMethod());

        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.sendRedirect("/auth/login");
    }
}
