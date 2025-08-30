<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../includes/header.jsp"%>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/posts.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/register.css">
</head>
<body>
    <%@include file="../includes/navbar.jsp"%>

    <div class="register-container">
        <!-- Page Header -->
        <div class="register-header">
            <h1 class="register-title">새 게시글 작성</h1>
            <p class="register-subtitle">커뮤니티에 새로운 이야기를 공유해보세요</p>
        </div>

        <!-- Register Form -->
        <form class="register-form" method="post" action="/posts/register">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            
            <div class="form-group">
                <label for="title" class="form-label">
                    제목 <span class="required">*</span>
                </label>
                <input 
                    type="text" 
                    id="title" 
                    name="title" 
                    class="form-input" 
                    placeholder="게시글 제목을 입력하세요"
                    required
                    maxlength="100"
                />
            </div>

            <div class="form-group">
                <label for="content" class="form-label">
                    내용 <span class="required">*</span>
                </label>
                <textarea 
                    id="content" 
                    name="content" 
                    class="form-input form-textarea" 
                    placeholder="게시글 내용을 입력하세요&#10;&#10;• 다른 사용자에게 도움이 되는 내용을 작성해주세요&#10;• 욕설이나 비방은 삼가해주세요&#10;• 저작권을 침해하지 않도록 주의해주세요"
                    required
                    maxlength="10000"
                ></textarea>
                <div class="character-count">
                    <span id="currentCount">0</span> / 10,000자
                </div>
            </div>

            <div class="form-actions">
                <a href="/posts" class="btn btn-secondary">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z"/>
                    </svg>
                    취소
                </a>
                <button type="submit" class="btn btn-primary">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M17 3H5c-1.1 0-2 .9-2 2v14c1.1 0 2 .9 2 2h14c1.1 0 2-.9 2-2V7l-4-4zm-5 16c-1.66 0-3-1.34-3-3s1.34-3 3-3 3 1.34 3 3-1.34 3-3 3zm3-10H5V5h10v4z"/>
                    </svg>
                    게시글 등록
                </button>
            </div>
        </form>
    </div>

    <script>
        // 글자 수 카운터
        document.addEventListener('DOMContentLoaded', function() {
            const contentTextarea = document.getElementById('content');
            const currentCount = document.getElementById('currentCount');
            const maxLength = 10000;

            function updateCharCount() {
                const length = contentTextarea.value.length;
                currentCount.textContent = length;
                
                if (length > maxLength * 0.9) {
                    currentCount.style.color = '#dc2626';
                } else if (length > maxLength * 0.8) {
                    currentCount.style.color = '#f59e0b';
                } else {
                    currentCount.style.color = '#6b7280';
                }
            }

            contentTextarea.addEventListener('input', updateCharCount);
            updateCharCount(); // 초기 카운트 설정
        });

        // 폼 제출 전 검증
        document.querySelector('.register-form').addEventListener('submit', function(e) {
            const title = document.getElementById('title').value.trim();
            const content = document.getElementById('content').value.trim();

            if (!title) {
                alert('제목을 입력해주세요.');
                e.preventDefault();
                document.getElementById('title').focus();
                return;
            }

            if (!content) {
                alert('내용을 입력해주세요.');
                e.preventDefault();
                document.getElementById('content').focus();
                return;
            }

            if (title.length > 100) {
                alert('제목은 100자 이내로 입력해주세요.');
                e.preventDefault();
                document.getElementById('title').focus();
                return;
            }

            if (content.length > 10000) {
                alert('내용은 10,000자 이내로 입력해주세요.');
                e.preventDefault();
                document.getElementById('content').focus();
                return;
            }

            // 제출 버튼 비활성화 (중복 제출 방지)
            const submitBtn = e.target.querySelector('button[type="submit"]');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor"><path d="M12,4V2A10,10 0 0,0 2,12H4A8,8 0 0,1 12,4Z"/></svg>등록 중...';
        });

        // 페이지 떠날 때 확인 (내용이 있을 경우)
        let isSubmitting = false;
        
        document.querySelector('.register-form').addEventListener('submit', function() {
            isSubmitting = true;
        });

        window.addEventListener('beforeunload', function(e) {
            if (isSubmitting) return;
            
            const title = document.getElementById('title').value.trim();
            const content = document.getElementById('content').value.trim();
            
            if (title || content) {
                e.preventDefault();
                e.returnValue = '작성 중인 내용이 있습니다. 정말 페이지를 떠나시겠습니까?';
                return e.returnValue;
            }
        });
    </script>
</body>
</html>