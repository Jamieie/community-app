package org.example.communityapp.controller.Advice;

import lombok.extern.log4j.Log4j2;
import org.example.communityapp.Exception.*;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;
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

    @ExceptionHandler({SignupFailedException.class, PostCreationFailedException.class,
            PostModificationFailedException.class, PostRemoveFailedException.class})
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public String FailedException(Exception e, RedirectAttributes rttr) {
        log.error("================= " + e);
        rttr.addFlashAttribute("error", e.getMessage());
        return "/error/500";
    }

    @ExceptionHandler({ResourceNotFoundException.class, NotResourceOwnerException.class})
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public String ResourceNotFoundException(Exception e, RedirectAttributes rttr) {
        log.error("================= " + e);
        rttr.addFlashAttribute("error", e.getMessage());
        return "/error/404";
    }

    @ExceptionHandler(NoHandlerFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public String handleNotFound(NoHandlerFoundException e, Model model) {
        log.error("================= " + e);
        model.addAttribute("path", e.getRequestURL());
        return "/error/404";
    }

    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public String exception(Exception e, RedirectAttributes rttr) {
        log.error("================= " + e);
        rttr.addFlashAttribute("error", e.getMessage());
        return "/error/500";
    }
}
