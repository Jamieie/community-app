package org.example.communityapp.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class CommentPageResponse {
    private List<CommentDetailDTO> comments;
    private String cursor;
    private boolean hasNext;
}
