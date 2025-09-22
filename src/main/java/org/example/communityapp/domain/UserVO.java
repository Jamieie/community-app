package org.example.communityapp.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.example.communityapp.common.enums.RoleType;

import java.time.Instant;

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
    private Instant createdAt;
    private Instant updatedAt;
}
