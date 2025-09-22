package org.example.communityapp.domain;

import lombok.*;

import java.time.Instant;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PostVO {
    private Long postId;
    private String title;
    private String content;
    private String writer;
    private Long viewCount;
    private Boolean isDeleted;
    private Instant createdAt;
    private Instant updatedAt;

    public PostVO(String title, String content, String writer) {
        this.title = title;
        this.content = content;
        this.writer = writer;
        this.viewCount = 0L;
        this.isDeleted = false;
    }
}
