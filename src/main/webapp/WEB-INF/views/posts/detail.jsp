<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../includes/header.jsp"%>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/posts.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/detail.css">
</head>
<body>
    <%@include file="../includes/navbar.jsp"%>

    <!-- Main Container -->
    <div class="main-container">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">게시글 상세</h1>
            <div class="breadcrumb">
                <a href="/posts">게시판</a> > 상세보기
            </div>
        </div>

        <!-- Post Details Container -->
        <div class="post-details-container">
            <!-- Post Header -->
            <div class="post-header">
                <h2 class="post-title">${post.title}</h2>
                <div class="post-meta">
                    <div class="post-author">
                        <svg class="stat-icon" viewBox="0 0 24 24">
                            <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>
                        </svg>
                        <span>${post.nickname}</span>
                    </div>
                    <div class="post-date">
                        <svg class="stat-icon" viewBox="0 0 24 24">
                            <path d="M9 11H7v2h2v-2zm4 0h-2v2h2v-2zm4 0h-2v2h2v-2zm2-7h-1V2h-2v2H8V2H6v2H5c-1.1 0-1.99.9-1.99 2L3 20c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 16H5V9h14v11z"/>
                        </svg>
                        <c:set var="createdAt" value="${post.createdAt}" />
                        <span>${fn:substring(createdAt, 0, 10)} ${fn:substring(createdAt, 11, 16)}</span>
                    </div>
                </div>
                
                <!-- Post Stats -->
                <div class="post-stats">
                    <div class="stat-item">
                        <svg class="stat-icon" viewBox="0 0 24 24">
                            <path d="M12 4.5C7 4.5 2.73 7.61 1 12c1.73 4.39 6 7.5 11 7.5s9.27-3.11 11-7.5c-1.73-4.39-6-7.5-11-7.5zM12 17c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5zm0-8c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3z"/>
                        </svg>
                        <span>조회수 ${post.viewCount}</span>
                    </div>
                    <div class="stat-item">
                        <svg class="stat-icon" viewBox="0 0 24 24">
                            <path d="M20 2H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h14l4 4V4c0-1.1-.9-2-2-2zm-2 12H6v-2h12v2zm0-3H6V9h12v2zm0-3H6V6h12v2z"/>
                        </svg>
                        <span>댓글 ${post.commentCount}</span>
                    </div>
                    <div class="stat-item">
                        <svg class="stat-icon" viewBox="0 0 24 24">
                            <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
                        </svg>
                        <span>좋아요 ${post.likeCount}</span>
                    </div>
                </div>
            </div>

            <!-- Post Content -->
            <div class="post-content">
                <div class="content-body">
                    ${fn:replace(fn:escapeXml(post.content), newLineChar, "<br>")}
                </div>
            </div>

            <!-- Post Actions -->
            <div class="post-actions">
                <div class="action-group">
                    <a href="/posts" class="btn btn-secondary">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z"/>
                        </svg>
                        목록으로
                    </a>
                </div>
                
                <!-- 작성자인 경우에만 수정/삭제 버튼 표시 -->
                <c:if test="${not empty pageContext.request.userPrincipal and pageContext.request.userPrincipal.principal.userId eq post.userId}">
                    <div class="action-group">
                        <a href="/posts/${post.postId}/modify" class="btn btn-primary">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                                <path d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34c-.39-.39-1.02-.39-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z"/>
                            </svg>
                            수정
                        </a>
                        <button type="button" class="btn btn-danger" onclick="confirmDelete()">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                                <path d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z"/>
                            </svg>
                            삭제
                        </button>
                    </div>
                </c:if>
            </div>

            <!-- Comments Section -->
            <div class="comments-section">
                <div class="comments-header">
                    <h3>댓글 <span class="comment-count">${post.commentCount}</span></h3>
                </div>
                <div class="comments-container">
                    <!-- 댓글은 이후 AJAX로 로딩될 예정 -->
                    <div class="comments-placeholder">
                        <p>댓글 기능은 곧 추가될 예정입니다.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 삭제 확인 모달 -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>게시글 삭제</h3>
                <button type="button" class="modal-close" onclick="closeDeleteModal()">&times;</button>
            </div>
            <div class="modal-body">
                <p>정말로 이 게시글을 삭제하시겠습니까?</p>
                <p class="modal-warning">삭제된 게시글은 복구할 수 없습니다.</p>
            </div>
            <div class="modal-actions">
                <button type="button" class="btn btn-secondary" onclick="closeDeleteModal()">취소</button>
                <button type="button" class="btn btn-danger" onclick="executeDelete()">삭제</button>
            </div>
        </div>
    </div>

    <script>
        function confirmDelete() {
            document.getElementById('deleteModal').style.display = 'block';
        }

        function closeDeleteModal() {
            document.getElementById('deleteModal').style.display = 'none';
        }

        function executeDelete() {
            // 삭제 요청을 위한 폼 생성 및 제출
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '/posts/' + ${post.postId} + '/remove';
            
            document.body.appendChild(form);
            form.submit();
        }

        // 모달 외부 클릭 시 닫기
        window.onclick = function(event) {
            const modal = document.getElementById('deleteModal');
            if (event.target === modal) {
                closeDeleteModal();
            }
        }
    </script>

</body>
</html>