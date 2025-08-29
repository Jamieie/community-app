package org.example.communityapp.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.example.communityapp.common.enums.RoleType;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserVO {
    private String userId;
    private String email;
    private String nickname;
    private String password;
    private RoleType role;
    private Boolean isDeleted;
    private String note;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
