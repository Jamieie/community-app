<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../includes/header.jsp"%>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/posts.css">
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="navbar-container">
            <a href="/" class="navbar-brand">Community App</a>
            <div class="navbar-menu">
                <c:choose>
                    <c:when test="${not empty pageContext.request.userPrincipal}">
                        <form action="/auth/logout" method="post" style="display: inline;">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <button type="submit" class="btn btn-primary">로그아웃</button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <a href="/auth/signup" class="btn">회원가입</a>
                        <a href="/auth/login" class="btn btn-primary">로그인</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </nav>

    <!-- Main Container -->
    <div class="main-container">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">게시판</h1>
            <p class="page-subtitle">커뮤니티의 다양한 이야기를 만나보세요</p>
        </div>

        <!-- Search Section -->
        <div class="search-section">
            <form class="search-form" method="get" action="/posts">
                <div class="search-group">
                    <label>검색 유형</label>
                    <div class="search-types">
                        <label><input type="checkbox" name="types" value="T" <c:if test="${fn:contains(param.types, 'T')}">checked</c:if>> 제목</label>
                        <label><input type="checkbox" name="types" value="C" <c:if test="${fn:contains(param.types, 'C')}">checked</c:if>> 내용</label>
                        <label><input type="checkbox" name="types" value="W" <c:if test="${fn:contains(param.types, 'W')}">checked</c:if>> 작성자</label>
                    </div>
                    <input type="text" class="search-input" name="keyword" placeholder="검색어를 입력하세요" value="${param.keyword}">
                </div>
                <button type="submit" class="search-btn">
                    <svg class="stat-icon" viewBox="0 0 24 24">
                        <path d="M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"/>
                    </svg>
                    검색
                </button>
            </form>
        </div>

        <!-- Posts Table -->
        <div class="posts-table">
            <!-- Table Header -->
            <div class="table-header">
                <div>제목</div>
                <div>작성자</div>
                <div>작성일</div>
            </div>

            <!-- Posts List -->
            <c:choose>
                <c:when test="${empty posts}">
                    <div class="empty-state">
                        <svg class="empty-icon" viewBox="0 0 24 24">
                            <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-5 14H7v-2h7v2zm3-4H7v-2h10v2zm0-4H7V7h10v2z"/>
                        </svg>
                        <div class="empty-title">게시글이 없습니다</div>
                        <div class="empty-message">첫 번째 게시글을 작성해보세요!</div>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${posts}" var="post">
                        <div class="post-item">
                            <div class="post-main">
                                <a href="/posts/${post.postId}" class="post-title">${post.title}</a>
                                <div class="post-stats">
                                    <div class="stat-item">
                                        <svg class="stat-icon" viewBox="0 0 24 24">
                                            <path d="M12 4.5C7 4.5 2.73 7.61 1 12c1.73 4.39 6 7.5 11 7.5s9.27-3.11 11-7.5c-1.73-4.39-6-7.5-11-7.5zM12 17c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5zm0-8c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3z"/>
                                        </svg>
                                        <span>${post.viewCount}</span>
                                    </div>
                                    <div class="stat-item">
                                        <svg class="stat-icon" viewBox="0 0 24 24">
                                            <path d="M20 2H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h14l4 4V4c0-1.1-.9-2-2-2zm-2 12H6v-2h12v2zm0-3H6V9h12v2zm0-3H6V6h12v2z"/>
                                        </svg>
                                        <span>${post.commentCount}</span>
                                    </div>
                                    <div class="stat-item">
                                        <svg class="stat-icon" viewBox="0 0 24 24">
                                            <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
                                        </svg>
                                        <span>${post.likeCount}</span>
                                    </div>
                                </div>
                            </div>
                            <div class="post-author">${post.nickname}</div>
                            <div class="post-date">
                                <c:set var="createdAt" value="${post.createdAt}" />
                                ${fn:substring(createdAt, 0, 10)}
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Pagination -->
        <div class="pagination-container">
            <div class="pagination">
                <c:if test="${pageMaker.prev}">
                    <a href="?pageNum=${pageMaker.startPage-1}&amount=${pageMaker.cri.amount}&keyword=${param.keyword}&types=${param.types}">
                        <svg class="stat-icon" viewBox="0 0 24 24">
                            <path d="M15.41 7.41L14 6l-6 6 6 6 1.41-1.41L10.83 12z"/>
                        </svg>
                    </a>
                </c:if>
                
                <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="num">
                    <c:choose>
                        <c:when test="${pageMaker.cri.pageNum == num}">
                            <span class="current">${num}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="?pageNum=${num}&amount=${pageMaker.cri.amount}&keyword=${param.keyword}&types=${param.types}">${num}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                
                <c:if test="${pageMaker.next}">
                    <a href="?pageNum=${pageMaker.endPage+1}&amount=${pageMaker.cri.amount}&keyword=${param.keyword}&types=${param.types}">
                        <svg class="stat-icon" viewBox="0 0 24 24">
                            <path d="M10 6L8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6z"/>
                        </svg>
                    </a>
                </c:if>
            </div>
        </div>
    </div>

    <script>
        // Search form enhancement
        document.addEventListener('DOMContentLoaded', function() {
            const searchForm = document.querySelector('.search-form');
            const typeCheckboxes = searchForm.querySelectorAll('input[name="types"]');
            
            // Ensure at least one type is selected when searching
            searchForm.addEventListener('submit', function(e) {
                const checkedTypes = Array.from(typeCheckboxes).some(cb => cb.checked);
                const keyword = searchForm.querySelector('input[name="keyword"]').value.trim();
                
                if (keyword && !checkedTypes) {
                    e.preventDefault();
                    alert('검색 유형을 하나 이상 선택해주세요.');
                    return false;
                }
            });
        });
    </script>
</body>
</html>
