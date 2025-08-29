-- H2 테스트 데이터베이스 스키마
CREATE TABLE IF NOT EXISTS users (
    user_id VARCHAR(50) PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    nickname VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'USER',
    is_deleted TINYINT NOT NULL DEFAULT 0,
    note TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 인덱스 생성
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_nickname ON users(nickname);
CREATE INDEX IF NOT EXISTS idx_users_is_deleted ON users(is_deleted);

-- post
CREATE TABLE IF NOT EXISTS post (
    post_id     BIGINT      NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title       VARCHAR(255) NOT NULL,
    content     TEXT        NOT NULL,
    writer      VARCHAR(36) NOT NULL,
    view_count  BIGINT      NOT NULL DEFAULT 0,
    is_deleted  TINYINT  NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- comment
CREATE TABLE IF NOT EXISTS comment (
    comment_id  BIGINT      NOT NULL AUTO_INCREMENT PRIMARY KEY,
    post_id     BIGINT      NOT NULL,
    writer      VARCHAR(36) NOT NULL,
    content     TEXT        NOT NULL,
    parent_id   BIGINT      NULL,
    is_deleted  TINYINT  NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS likes (
    post_id  BIGINT      NOT NULL,
    user_id  VARCHAR(36) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (post_id, user_id)
);