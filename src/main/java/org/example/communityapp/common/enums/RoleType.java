package org.example.communityapp.common.enums;

public enum RoleType {
    ADMIN("ROLE_ADMIN", "관리자"),
    USER("ROLE_USER", "회원");

    private final String roleWithPrefix;
    private final String roleKr;

    RoleType(String roleWithPrefix, String roleKr) {
        this.roleWithPrefix = roleWithPrefix;
        this.roleKr = roleKr;
    }

    public String getRoleWithPrefix() {
        return roleWithPrefix;
    }

    public String getRoleKr() {
        return roleKr;
    }
}
