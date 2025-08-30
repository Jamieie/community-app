<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@include file="../includes/header.jsp"%>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/posts.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/detail.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/modify.css">
</head>
<body>
    <%@include file="../includes/navbar.jsp"%>

    <!-- Main Container -->
    <div class="main-container">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">게시글 수정</h1>
            <div class="breadcrumb">
                <a href="/posts">게시판</a> > <a href="/posts/${post.postId}">게시글 상세</a> > 수정
            </div>
        </div>

        <!-- Post Form Container -->
        <div class="post-form-container">
            <form action="/posts/${post.postId}/modify" method="post" class="post-form">
                <!-- Form Header -->
                <div class="form-header">
                    <h2>게시글 수정</h2>
                    <p class="form-description">게시글 내용을 수정해주세요.</p>
                </div>

                <!-- Form Fields -->
                <div class="form-group">
                    <label for="title" class="form-label required">제목</label>
                    <input 
                        type="text" 
                        id="title" 
                        name="title" 
                        value="${post.title}"
                        class="form-control" 
                        placeholder="게시글 제목을 입력해주세요" 
                        required 
                        maxlength="200"
                    >
                    <div class="form-help">최대 200자까지 입력 가능합니다.</div>
                </div>

                <div class="form-group">
                    <label for="content" class="form-label required">내용</label>
                    <textarea 
                        id="content" 
                        name="content" 
                        class="form-control content-textarea" 
                        placeholder="게시글 내용을 입력해주세요" 
                        required 
                        rows="15"
                    >${post.content}</textarea>
                    <div class="form-help">게시글 내용을 상세히 작성해주세요.</div>
                </div>

                <!-- Form Actions -->
                <div class="form-actions">
                    <div class="action-group">
                        <a href="/posts/${post.postId}" class="btn btn-secondary">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                                <path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z"/>
                            </svg>
                            취소
                        </a>
                    </div>
                    <div class="action-group">
                        <button type="submit" class="btn btn-primary">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                                <path d="M9 16.2L4.8 12l-1.4 1.4L9 19 21 7l-1.4-1.4L9 16.2z"/>
                            </svg>
                            수정 완료
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script>
        // 폼 유효성 검사
        document.querySelector('.post-form').addEventListener('submit', function(e) {
            const title = document.getElementById('title').value.trim();
            const content = document.getElementById('content').value.trim();
            
            if (!title) {
                e.preventDefault();
                alert('제목을 입력해주세요.');
                document.getElementById('title').focus();
                return;
            }
            
            if (!content) {
                e.preventDefault();
                alert('내용을 입력해주세요.');
                document.getElementById('content').focus();
                return;
            }
            
            if (title.length > 200) {
                e.preventDefault();
                alert('제목은 200자 이내로 입력해주세요.');
                document.getElementById('title').focus();
                return;
            }
        });

        // 텍스트 에어리어 자동 높이 조절
        const textarea = document.getElementById('content');
        textarea.addEventListener('input', function() {
            this.style.height = 'auto';
            this.style.height = (this.scrollHeight) + 'px';
        });
    </script>

</body>
</html>