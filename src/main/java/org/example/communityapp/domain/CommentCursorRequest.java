package org.example.communityapp.domain;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class CommentCursorRequest {

    private Integer limit = 10;  // 불러올 개수

    @Pattern(
            regexp = "^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}_\\d+$",
            message = "cursor 형식이 올바르지 않습니다."
    )
    private String after;  // "2025-08-01T12:34:56_12345" 형태

    public void setLimit(Integer limit) {
        if (limit == null || limit <= 0 || limit > 100) {
            this.limit = 10;
        } else {
            this.limit = limit;
        }
    }
}
