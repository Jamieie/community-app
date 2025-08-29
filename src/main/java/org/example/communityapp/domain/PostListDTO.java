package org.example.communityapp.domain;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class PostListDTO {
    private Long postId;
    private String title;
    private String content;
    private String userId;
    private String nickname;
    private Long viewCount;
    private Long commentCount;
    private Long likeCount;
    private LocalDateTime createdAt;
}
