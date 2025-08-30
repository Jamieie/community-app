package org.example.communityapp.domain;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class ModifyPostRequestDTO {
    @NotBlank
    private String title;
    @NotBlank
    private String content;
}
