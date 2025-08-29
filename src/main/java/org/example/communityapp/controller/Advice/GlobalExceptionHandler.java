package org.example.communityapp.controller.Advice;

import lombok.extern.log4j.Log4j2;
import org.example.communityapp.Exception.DuplicateUserInfoException;
import org.example.communityapp.Exception.SignupFailedException;
import org.example.communityapp.Exception.SignupValidationException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Log4j2
@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler({DuplicateUserInfoException.class, SignupValidationException.class})
    @ResponseStatus(HttpStatus.SEE_OTHER)
    public String SignupValidationException(Exception e, RedirectAttributes rttr) {
        log.error("================== " + e);
        rttr.addFlashAttribute("error", e.getMessage());
        return "redirect:/auth/signup";
    }

    // TODO) Error page 만들어서 반환값 교체하기
    @ExceptionHandler(SignupFailedException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public String SignupFailedException(Exception e, RedirectAttributes rttr) {
        log.error("================= " + e);
        return null;
    }
}
