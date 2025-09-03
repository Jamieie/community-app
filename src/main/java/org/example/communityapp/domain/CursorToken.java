package org.example.communityapp.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.example.communityapp.Exception.InvalidCommentCursorException;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;

@Data
@AllArgsConstructor
public class CursorToken {

    private LocalDateTime afterCreatedAt;
    private Long afterCommentId;

    public CursorToken(String cursor) {
        if (cursor == null) {
            afterCreatedAt = null;
            afterCommentId = null;
            return;
        }

        LocalDateTime parsedDate;
        Long parsedId;

        // cursor 파싱하여 값 초기화
        String[] cursorStrArr = cursor.trim().split("_", 2);
        try {
            parsedDate = LocalDateTime.parse(cursorStrArr[0]);
            parsedId = Long.parseLong(cursorStrArr[1]);
        } catch (DateTimeParseException | NumberFormatException e) {
            throw new InvalidCommentCursorException("커서 형식이 올바르지 않습니다. (날짜_댓글ID)");
        }

        if (parsedId <= 0) {
            throw new InvalidCommentCursorException("커서의 댓글ID는 양수여야 합니다.");
        }

        this.afterCreatedAt = parsedDate;
        this.afterCommentId = parsedId;
    }
}
