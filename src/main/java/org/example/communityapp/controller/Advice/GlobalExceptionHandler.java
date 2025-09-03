package org.example.communityapp.controller.Advice;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.example.communityapp.Exception.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Map;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler({DuplicateUserInfoException.class, SignupValidationException.class})
    @ResponseStatus(HttpStatus.SEE_OTHER)
    public String handleSignupValidationException(Exception e, RedirectAttributes rttr) {
        log.error("================== " + e);
        rttr.addFlashAttribute("error", e.getMessage());
        return "redirect:/auth/signup";
    }

    @ExceptionHandler({SignupFailedException.class, PostCreationFailedException.class,
            PostModificationFailedException.class, PostRemoveFailedException.class})
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public String handleFailedException(Exception e, Model model) {
        log.error("================= " + e);
        model.addAttribute("error", e.getMessage());
        return "/error/500";
    }

    @ExceptionHandler({ResourceNotFoundException.class, NotResourceOwnerException.class})
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public String handleResourceNotFoundException(Exception e, Model model) {
        log.error("================= " + e);
        model.addAttribute("error", e.getMessage());
        return "/error/404";
    }


    @ExceptionHandler(NoHandlerFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public Object handleNoHandlerFoundException(NoHandlerFoundException e, HttpServletRequest request, Model model) {

        log.error("================= " + e);

        String requestURI = request.getRequestURI();
        if (requestURI.startsWith("/api")) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                    Map.of("errorCode", "RESOURCE_NOT_FOUND",
                            "message", e.getMessage()));
        } else {
            model.addAttribute("error", e.getMessage());
            return "/error/404";
        }
    }

    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public String handleException(Exception e, Model model) {
        log.error("================= " + e);
        model.addAttribute("exception", e);
        return "/error/500";
    }
}
