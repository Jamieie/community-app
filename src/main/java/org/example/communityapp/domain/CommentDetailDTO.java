package org.example.communityapp.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;

@Data
public class CommentDetailDTO {
    private Long commentId;
    private Long postId;
    private String userId;
    private String nickname;
    private String content;
    private Long patientId;
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ssX", timezone = "UTC")
    private Instant createdAt;

    @JsonIgnore
    public String getCursor() {
        return createdAt.toString() + "_" + commentId.toString();
    }
}
