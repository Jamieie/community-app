package org.example.communityapp.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

@Data
public class PostVO {
    private Long postId;
    private String title;
    private String content;
    private String writer;
    private Long viewCount;
    private Boolean isDeleted;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
