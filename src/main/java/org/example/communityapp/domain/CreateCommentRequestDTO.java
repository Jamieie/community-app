package org.example.communityapp.domain;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class CreateCommentRequestDTO {
    private Long patientId;
    @NotBlank
    private String content;
}
