package org.example.communityapp.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.example.communityapp.domain.SignupRequestDTO;
import org.example.communityapp.service.AuthService;
import org.example.communityapp.service.AuthServiceImpl;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/auth")
@Log4j2
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @GetMapping("/login")
    public String login() {
        log.info("==========login===========");
        return "/auth/login";
    }

    @GetMapping("/signup")
    public String signup() {
        log.info("==========signup GET===========");
        return "/auth/signup";
    }

    @PostMapping("/signup")
    public String signup(@Valid @ModelAttribute SignupRequestDTO signupRequestDTO,
                         BindingResult bindingResult,
                         RedirectAttributes rttr) {
        log.info("==========signup POST===========");

        // 사용자 입력값이 유효하지 않을 경우
        if (bindingResult.hasErrors()) {
            rttr.addFlashAttribute("error", "입력값을 확인해주세요.");
            return "redirect:auth/signup";
        }

        authService.signup(signupRequestDTO);
        rttr.addFlashAttribute("success", "회원가입이 완료되었습니다. 로그인해주세요.");
        return "redirect:/auth/login";
    }
}
