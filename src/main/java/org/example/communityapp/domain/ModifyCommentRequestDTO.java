package org.example.communityapp.domain;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class ModifyCommentRequestDTO {
    @NotBlank
    private String content;
}
