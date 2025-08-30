package org.example.communityapp.domain;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class PostModifyForm {
    private Long postId;
    private String title;
    private String content;
    private String writer;
}
