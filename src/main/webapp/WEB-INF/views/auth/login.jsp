<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="../includes/header.jsp"%>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/login.css">
</head>
<body>
<div class="login-container">
    <div class="login-header">
        <h1>Community App</h1>
    </div>

    <c:if test="${not empty error or not empty sessionScope.error}">
        <div class="error-message">
                ${not empty sessionScope.error ? sessionScope.error : error}
        </div>
    </c:if>

    <!-- 에러 메시지를 표시한 후 세션에서 제거 -->
    <c:if test="${not empty sessionScope.error}">
        <c:remove var="error" scope="session"/>
    </c:if>

    <c:if test="${not empty success}">
        <div class="success-message">
                ${success}
        </div>
    </c:if>

    <form action="/auth/login" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

        <div class="form-group">
            <label for="email">이메일</label>
            <input type="email" id="email" name="email" required
                   placeholder="이메일을 입력하세요"
                   value="${param.email}">
        </div>

        <div class="form-group">
            <label for="password">비밀번호</label>
            <input type="password" id="password" name="password" required
                   placeholder="비밀번호를 입력하세요">
        </div>

        <button type="submit" class="login-btn">로그인</button>
    </form>

    <div class="signup-link">
        아직 계정이 없으신가요? <a href="/auth/signup">회원가입</a>
    </div>
</div>
</body>
</html>
