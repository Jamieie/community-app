<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../includes/header.jsp"%>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/error.css">
</head>
<body>
    <%@include file="../includes/navbar.jsp"%>

    <div class="error-container error-404">
        <div class="error-content">
            <svg class="error-icon" viewBox="0 0 24 24" fill="currentColor">
                <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/>
            </svg>
            
            <div class="error-code">404</div>
            
            <h1 class="error-title">페이지를 찾을 수 없습니다</h1>
            
            <p class="error-message">
                요청하신 페이지가 존재하지 않거나 이동되었을 수 있습니다.<br>
                URL을 다시 확인해주시거나 아래 버튼을 통해 다른 페이지로 이동해주세요.
            </p>
            
            <div class="error-actions">
                <a href="/" class="btn btn-primary">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z"/>
                    </svg>
                    홈으로 이동
                </a>
                <a href="/posts" class="btn btn-secondary">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-5 14H7v-2h7v2zm3-4H7v-2h10v2zm0-4H7V7h10v2z"/>
                    </svg>
                    게시판 보기
                </a>
                <button onclick="history.back()" class="btn btn-secondary">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z"/>
                    </svg>
                    이전 페이지
                </button>
            </div>
        </div>
    </div>
</body>
</html>