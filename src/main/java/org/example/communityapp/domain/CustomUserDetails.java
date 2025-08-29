package org.example.communityapp.domain;

import lombok.Getter;
import lombok.ToString;
import org.example.communityapp.common.enums.RoleType;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.List;

@Getter
@ToString(exclude = "password")
public class CustomUserDetails implements UserDetails {
    private final String userId;
    private final String email;
    private final String password;
    private final String nickname;
    private final RoleType role;
    private final Boolean isDeleted;

    public CustomUserDetails(UserVO user) {
        this.userId = user.getUserId();
        this.email = user.getEmail();
        this.password = user.getPassword();
        this.nickname = user.getNickname();
        this.role = user.getRole();
        this.isDeleted = user.getIsDeleted();
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority(role.getRoleWithPrefix()));
    }

    @Override
    public String getUsername() {
        return this.email;
    }

    @Override
    public String getPassword() { return this.password; }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return !isDeleted;
    }
}
