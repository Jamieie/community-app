package org.example.communityapp.domain;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class CreatePostRequestDTO {
    @NotBlank
    private String title;
    @NotBlank
    private String content;
}
