# 👥 Community App

> Spring Legacy 기반 게시판 웹 서비스

다수의 사용자가 게시글과 댓글로 소통할 수 있는 커뮤니티 웹 애플리케이션입니다. 기획부터 배포까지 완전한 개발 사이클을 경험할 목적으로 수행하였습니다.

🔗 배포주소 https://community-app.store

## 🛠️ 기술 스택

---

### Backend
- **Language**: Java 21
- **Framework**: Spring 6.x, Spring Security, Spring MVC
- **Build Tool**: Gradle
- **ORM**: MyBatis
- **View**: JSP, JavaScript

### Database
- **Production**: MariaDB

### Infrastructure & DevOps
- **Cloud**: Google Cloud Platform (VM Instance)
- **Web Server**: Nginx (Reverse Proxy)
- **Application Server**: Apache Tomcat 10.x
- **CI/CD**: GitHub Actions

## 🏗️ 프로젝트 구조

---

```
src/main/java/org/example/communityapp/
├── controller/              # MVC 컨트롤러
│   └── Advice/             # 전역 예외 처리
├── service/                # 비즈니스 로직
├── mappers/                # MyBatis 매퍼 인터페이스
├── domain/                 # VO, DTO 객체
├── security/               # Spring Security 설정
│   └── handler/            # 커스텀 핸들러
├── Exception/              # 커스텀 예외 클래스
└── common/enums/          # 공통 열거형

src/main/resources/
├── mappers/mariadb/       # MyBatis XML 매퍼
└── mybatis-config.xml     # MyBatis 설정

src/main/webapp/
├── WEB-INF/
│   ├── spring/           # Spring 설정 파일
│   │   ├── root-context.xml         # 데이터베이스, MyBatis, 서비스
│   │   ├── security-context.xml     # Spring Security 설정
│   │   └── servlet-context.xml      # Spring MVC 웹 설정
│   ├── views/            # JSP 뷰 페이지
│   └── web.xml
└── resources/css/        # 스타일시트
```

## 🚀 설치 및 실행

---

### 사전 요구사항
- Java 21
- Gradle 8.x
- MariaDB 10.x (또는 PostgreSQL)

### 로컬 개발 환경 설정

1. **프로젝트 클론**
   ```bash
   git clone https://github.com/your-username/community-app.git
   cd community-app
   ```

2. **데이터베이스 설정**
   - MariaDB 설치 및 데이터베이스 생성
   - 환경 변수 설정
   ```bash
   DB_URL=jdbc:mariadb://localhost:3306/communityappdb
   DB_USERNAME=your-username
   DB_PASSWORD=your-password
   ```

3. **애플리케이션 빌드 및 실행**
   ```bash
   ./gradlew clean build
   ./gradlew bootRun
   ```

4. **브라우저에서 접속**
   ```
   http://localhost:8080
   ```
   
## ✨ 주요 기능

---

### 🔐 인증 및 보안
- 쿠키/세션 기반 로그인 구현
- Spring Security를 통한 세션 관리
- CSRF 보호 및 세션 고정 공격 방어

### 📝 게시글 관리
- 게시글 작성, 수정, 삭제 (CRUD)
- 페이지네이션을 통한 게시글 목록 조회
- 제목/내용 기반 게시글 검색

### 💬 댓글 시스템
- 댓글 작성, 수정, 삭제 (CRUD)
- 더보기 버튼으로 커서 기반 페이지네이션

## 🎯 추가 예정 기능

---

- [ ] 관리자 페이지
- [ ] 게시글 좋아요 기능
- [ ] 이미지 업로드 기능
- [ ] OAuth 소셜 로그인