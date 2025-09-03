package org.example.communityapp.controller.Advice;

import lombok.extern.slf4j.Slf4j;
import org.example.communityapp.Exception.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.NoHandlerFoundException;

import java.util.Map;

@Slf4j
@RestControllerAdvice(annotations = RestController.class)
public class GlobalApiExceptionHandler {

    @ExceptionHandler({ResourceNotFoundException.class, NoHandlerFoundException.class})
    public ResponseEntity<?> handleResourceNotFoundException(Exception e) {
        log.error("================= " + e);

        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                Map.of("errorCode", "RESOURCE_NOT_FOUND",
                        "message", e.getMessage()));
    }

    @ExceptionHandler({CommentCreationFailedException.class, CommentModificationFailedException.class,
            CommentRemoveFailedException.class})
    public ResponseEntity<?> handleFailedException(Exception e) {
        log.error("================= " + e);

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(
                Map.of("errorCode", "REQUEST_FAILED",
                        "message", e.getMessage()));
    }

    @ExceptionHandler(InvalidCommentCursorException.class)
    public ResponseEntity<?> handleInvalidCommentCursorException(Exception e) {
        log.error("================= " + e);

        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(
                Map.of("errorCode", "INVALID_COMMENT_CURSOR",
                        "message", e.getMessage())
        );
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<?> handleMethodArgumentNotValidException(MethodArgumentNotValidException e) {
        log.error("================= " + e);

        String errorMessage = e.getBindingResult().getFieldErrors().stream()
                .map(fieldError -> fieldError.getField() + ": " + fieldError.getDefaultMessage())
                .findFirst()
                .orElse("요청값이 올바르지 않습니다.");

        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(
                Map.of("errorCode", "INVALID_INPUT_VALUE",
                        "message", errorMessage)
        );
    }

    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<?> handleHttpMessageNotReadableException(HttpMessageNotReadableException e) {
        log.error("================= " + e);

        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(
                Map.of("errorCode", "INVALID_REQUEST_BODY",
                        "message", "요청 본문을 읽을 수 없습니다. JSON 형식을 확인해 주세요."
                ));
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<?> handleException(Exception e) {
        log.error("================= " + e);

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(
                Map.of("errorCode", "INTERNAL_SERVER_ERROR",
                        "message", e.getMessage())
        );
    }
}
