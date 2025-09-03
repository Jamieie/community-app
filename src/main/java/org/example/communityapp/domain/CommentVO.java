package org.example.communityapp.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CommentVO {
    private Long commentId;
    private Long postId;
    private String writer;
    private String content;
    private Long parentId;
    private Boolean isDeleted;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public CommentVO(Long postId, String writer, String content, Long parentId) {
        this.postId = postId;
        this.writer = writer;
        this.content = content;
        this.parentId = parentId;
        this.isDeleted = false;
    }
}
