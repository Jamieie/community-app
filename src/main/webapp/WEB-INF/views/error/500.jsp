<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../includes/header.jsp"%>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/error.css">
</head>
<body>
    <%@include file="../includes/navbar.jsp"%>

    <div class="error-container error-500">
        <div class="error-content">
            <svg class="error-icon" viewBox="0 0 24 24" fill="currentColor">
                <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 15h2v2h-2zm0-2h2V7h-2z"/>
            </svg>
            
            <div class="error-code">500</div>
            
            <h1 class="error-title">서버 내부 오류</h1>
            
            <p class="error-message">
                서버에서 요청을 처리하는 중에 오류가 발생했습니다.<br>
                잠시 후 다시 시도해주시거나 관리자에게 문의해주세요.
            </p>
            
            <div class="error-actions">
                <a href="/" class="btn btn-primary">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z"/>
                    </svg>
                    홈으로 이동
                </a>
                <button onclick="location.reload()" class="btn btn-secondary">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M17.65 6.35C16.2 4.9 14.21 4 12 4c-4.42 0-7.99 3.58-7.99 8s3.57 8 7.99 8c3.73 0 6.84-2.55 7.73-6h-2.08c-.82 2.33-3.04 4-5.65 4-3.31 0-6-2.69-6-6s2.69-6 6-6c1.66 0 3.14.69 4.22 1.78L13 11h7V4l-2.35 2.35z"/>
                    </svg>
                    새로고침
                </button>
                <button onclick="history.back()" class="btn btn-secondary">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z"/>
                    </svg>
                    이전 페이지
                </button>
            </div>

            <c:if test="${not empty exception}">
                <div class="error-details">
                    <h4>오류 정보:</h4>
                    <p><strong>메시지:</strong> ${exception.message}</p>
                    <p><strong>시간:</strong> <%= new java.util.Date() %></p>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>