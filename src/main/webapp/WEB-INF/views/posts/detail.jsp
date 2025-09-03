<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../includes/header.jsp"%>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/posts.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/detail.css">
    
    <!-- CSRF Token for AJAX requests -->
    <sec:csrfMetaTags/>
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
                
                <!-- Comment Input Section -->
                <c:if test="${not empty pageContext.request.userPrincipal}">
                    <div class="comment-input-section">
                        <div class="comment-form">
                            <textarea id="commentContent" placeholder="댓글을 입력하세요..." maxlength="500" rows="3"></textarea>
                            <div class="comment-form-actions">
                                <span class="char-count">0/500</span>
                                <button type="button" id="submitComment" class="btn btn-primary">댓글 등록</button>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${empty pageContext.request.userPrincipal}">
                    <div class="comment-login-prompt">
                        <p>댓글을 작성하려면 <a href="/auth/login">로그인</a>이 필요합니다.</p>
                    </div>
                </c:if>

                <!-- Comments Container -->
                <div class="comments-container">
                    <!-- 기존 댓글 영역 -->
                    <div id="existingCommentsSection">
                        <div id="commentsList" class="comments-list">
                            <!-- 서버에서 로드된 댓글들 -->
                        </div>
                        <div id="loadMoreSection" class="load-more-section" style="display: none;">
                            <div class="separator">
                                <span>이전 댓글이 더 있습니다</span>
                            </div>
                            <button type="button" id="loadMoreComments" class="btn btn-secondary">더보기</button>
                        </div>
                    </div>
                    
                    <!-- 새 댓글과 기존 댓글 구분선 -->
                    <div id="newCommentsSeparator" class="new-comments-separator" style="display: none;">
                        <span>새로 작성한 댓글</span>
                    </div>
                    
                    <!-- 새로 작성한 댓글 영역 -->
                    <div id="newCommentsList" class="comments-list">
                        <!-- 새로 작성한 댓글들 -->
                    </div>
                    
                    <div id="noCommentsMessage" class="no-comments" style="display: none;">
                        <p>아직 댓글이 없습니다. 첫 번째 댓글을 작성해보세요!</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 게시글 삭제 확인 모달 -->
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

    <!-- 댓글 삭제 확인 모달 -->
    <div id="deleteCommentModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>댓글 삭제</h3>
                <button type="button" class="modal-close" onclick="closeDeleteCommentModal()">&times;</button>
            </div>
            <div class="modal-body">
                <p>정말로 이 댓글을 삭제하시겠습니까?</p>
                <p class="modal-warning">삭제된 댓글은 복구할 수 없습니다.</p>
            </div>
            <div class="modal-actions">
                <button type="button" class="btn btn-secondary" onclick="closeDeleteCommentModal()">취소</button>
                <button type="button" class="btn btn-danger" onclick="executeCommentDelete()">삭제</button>
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

        // 댓글 삭제 모달 함수들
        let commentToDelete = null;
        
        function confirmDeleteComment(commentId) {
            commentToDelete = commentId;
            document.getElementById('deleteCommentModal').style.display = 'block';
        }

        function closeDeleteCommentModal() {
            document.getElementById('deleteCommentModal').style.display = 'none';
            commentToDelete = null;
        }

        function executeCommentDelete() {
            if (commentToDelete) {
                actualDeleteComment(commentToDelete);
                closeDeleteCommentModal();
            }
        }

        // 모달 외부 클릭 시 닫기
        window.onclick = function(event) {
            const deleteModal = document.getElementById('deleteModal');
            const deleteCommentModal = document.getElementById('deleteCommentModal');
            if (event.target === deleteModal) {
                closeDeleteModal();
            }
            if (event.target === deleteCommentModal) {
                closeDeleteCommentModal();
            }
        }

        // Comments functionality
        let currentCursor = null;
        let hasMore = false;
        const postId = ${post.postId};
        
        // CSRF Token 설정
        const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
        const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
        
        // Character count for comment textarea
        const commentContent = document.getElementById('commentContent');
        const charCount = document.querySelector('.char-count');
        
        if (commentContent) {
            commentContent.addEventListener('input', function() {
                const length = this.value.length;
                charCount.textContent = length + '/500';
            });
        }

        // Load initial comments on page load
        document.addEventListener('DOMContentLoaded', function() {
            loadComments();
        });

        // Submit comment
        const submitBtn = document.getElementById('submitComment');
        if (submitBtn) {
            submitBtn.addEventListener('click', function() {
                submitComment();
            });
        }

        // Load more comments
        const loadMoreBtn = document.getElementById('loadMoreComments');
        if (loadMoreBtn) {
            loadMoreBtn.addEventListener('click', function() {
                loadMoreComments();
            });
        }

        // Load comments function
        function loadComments(cursor = null) {
            let url = '/api/posts/' + postId + '/comments?limit=10';
            if (cursor) {
                url += '&after=' + encodeURIComponent(cursor);
            }

            fetch(url, {
                method: 'GET'
            })
            .then(response => response.json())
            .then(data => {
                if (cursor === null) {
                    // Initial load
                    displayComments(data.comments, false);
                } else {
                    // Load more
                    displayComments(data.comments, true);
                }
                currentCursor = data.cursor;
                hasMore = data.hasNext;
                updateLoadMoreButton();
            })
            .catch(error => {
                console.error('댓글 로드 실패:', error);
            });
        }

        // Load more comments
        function loadMoreComments() {
            if (hasMore && currentCursor) {
                loadComments(currentCursor);
            }
        }

        // Display comments (for existing comments from server)
        function displayComments(comments, append = false) {
            const commentsList = document.getElementById('commentsList');
            const noCommentsMessage = document.getElementById('noCommentsMessage');
            
            if (!append) {
                commentsList.innerHTML = '';
            }
            
            if (comments && comments.length > 0) {
                noCommentsMessage.style.display = 'none';
                
                comments.forEach(comment => {
                    const commentElement = createCommentElement(comment);
                    commentsList.appendChild(commentElement);
                });
            } else if (!append) {
                // Check if there are new comments before showing no comments message
                const newCommentsList = document.getElementById('newCommentsList');
                if (newCommentsList.children.length === 0) {
                    noCommentsMessage.style.display = 'block';
                }
            }
        }

        // Create comment element
        function createCommentElement(comment) {
            const commentDiv = document.createElement('div');
            commentDiv.className = 'comment-item';
            commentDiv.setAttribute('data-comment-id', comment.commentId);
            
            const currentUserId = '${pageContext.request.userPrincipal.principal.userId}';
            const isOwner = currentUserId && currentUserId === comment.userId;
            
            commentDiv.innerHTML = `
                <div class="comment-header">
                    <div class="comment-author">
                        <svg class="stat-icon" viewBox="0 0 24 24">
                            <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>
                        </svg>
                        <span>` + comment.nickname + `</span>
                    </div>
                    <div class="comment-meta">
                        <span class="comment-date">` + formatCommentDate(comment.createdAt) + `</span>
                        ` + (isOwner ? `
                            <div class="comment-actions">
                                <button type="button" class="btn-text" onclick="editComment(` + comment.commentId + `)">수정</button>
                                <button type="button" class="btn-text btn-danger" onclick="confirmDeleteComment(` + comment.commentId + `)">삭제</button>
                            </div>
                        ` : '') + `
                    </div>
                </div>
                <div class="comment-content">
                    <div class="comment-text">` + comment.content.replace(/\n/g, '<br>') + `</div>
                    <div class="comment-edit-form" style="display: none;">
                        <textarea class="edit-textarea" maxlength="500">` + comment.content + `</textarea>
                        <div class="edit-actions">
                            <button type="button" class="btn btn-primary btn-sm" onclick="saveCommentEdit(` + comment.commentId + `)">저장</button>
                            <button type="button" class="btn btn-secondary btn-sm" onclick="cancelCommentEdit(` + comment.commentId + `)">취소</button>
                        </div>
                    </div>
                </div>
            `;
            
            return commentDiv;
        }

        // Submit new comment
        function submitComment() {
            const content = commentContent.value.trim();
            if (!content) {
                return;
            }

            const requestBody = {
                content: content
            };

            const headers = {
                'Content-Type': 'application/json'
            };
            headers[csrfHeader] = csrfToken;

            fetch('/api/posts/' + postId + '/comments', {
                method: 'POST',
                headers: headers,
                body: JSON.stringify(requestBody)
            })
            .then(response => response.json())
            .then(comment => {
                // Add new comment to separate new comments area
                const newCommentsList = document.getElementById('newCommentsList');
                const newCommentsSeparator = document.getElementById('newCommentsSeparator');
                const noCommentsMessage = document.getElementById('noCommentsMessage');
                
                noCommentsMessage.style.display = 'none';
                
                // Show separator if this is the first new comment
                if (newCommentsList.children.length === 0) {
                    newCommentsSeparator.style.display = 'block';
                }
                
                const newCommentElement = createCommentElement(comment);
                newCommentsList.appendChild(newCommentElement);
                
                // Clear input
                commentContent.value = '';
                charCount.textContent = '0/500';
                
                // Update comment count
                const commentCountSpan = document.querySelector('.comment-count');
                const currentCount = parseInt(commentCountSpan.textContent);
                commentCountSpan.textContent = currentCount + 1;
            })
            .catch(error => {
                console.error('댓글 등록 실패:', error);
            });
        }

        // Edit comment
        function editComment(commentId) {
            const commentItem = document.querySelector('[data-comment-id="' + commentId + '"]');
            const commentText = commentItem.querySelector('.comment-text');
            const editForm = commentItem.querySelector('.comment-edit-form');
            
            commentText.style.display = 'none';
            editForm.style.display = 'block';
        }

        // Cancel comment edit
        function cancelCommentEdit(commentId) {
            const commentItem = document.querySelector('[data-comment-id="' + commentId + '"]');
            const commentText = commentItem.querySelector('.comment-text');'[data-comment-id="' + commentId + '"]'
            const editForm = commentItem.querySelector('.comment-edit-form');
            
            commentText.style.display = 'block';
            editForm.style.display = 'none';
        }

        // Save comment edit
        function saveCommentEdit(commentId) {
            const commentItem = document.querySelector('[data-comment-id="' + commentId + '"]');
            const editTextarea = commentItem.querySelector('.edit-textarea');
            const content = editTextarea.value.trim();
            
            if (!content) {
                return;
            }

            const requestBody = {
                content: content
            };

            const headers = {
                'Content-Type': 'application/json'
            };
            headers[csrfHeader] = csrfToken;

            fetch('/api/posts/' + postId + '/comments/' + commentId, {
                method: 'PUT',
                headers: headers,
                body: JSON.stringify(requestBody)
            })
            .then(response => response.json())
            .then(updatedComment => {
                // Update comment content
                const commentText = commentItem.querySelector('.comment-text');
                commentText.innerHTML = updatedComment.content.replace(/\n/g, '<br>');
                
                cancelCommentEdit(commentId);
            })
            .catch(error => {
                console.error('댓글 수정 실패:', error);
            });
        }

        // Actual delete comment function
        function actualDeleteComment(commentId) {
            const headers = {};
            headers[csrfHeader] = csrfToken;
            
            fetch('/api/posts/' + postId + '/comments/' + commentId, {
                method: 'DELETE',
                headers: headers
            })
            .then(response => {
                if (response.ok) {
                    // Remove comment from DOM
                    const commentItem = document.querySelector('[data-comment-id="' + commentId + '"]');
                    
                    if (commentItem) {
                        commentItem.remove();
                        
                        // Update comment count
                        const commentCountSpan = document.querySelector('.comment-count');
                        if (commentCountSpan) {
                            const currentCount = parseInt(commentCountSpan.textContent);
                            commentCountSpan.textContent = Math.max(0, currentCount - 1);
                        }
                        
                        // Check if we need to hide new comments separator
                        const newCommentsList = document.getElementById('newCommentsList');
                        const newCommentsSeparator = document.getElementById('newCommentsSeparator');
                        if (newCommentsList && newCommentsList.children.length === 0) {
                            newCommentsSeparator.style.display = 'none';
                        }
                        
                        // Show no comments message if no comments left anywhere
                        const existingCommentsList = document.getElementById('commentsList');
                        if (existingCommentsList.children.length === 0 && newCommentsList.children.length === 0) {
                            document.getElementById('noCommentsMessage').style.display = 'block';
                        }
                    }
                }
            })
            .catch(error => {
                console.error('댓글 삭제 실패:', error);
            });
        }

        // Update load more button visibility
        function updateLoadMoreButton() {
            const loadMoreSection = document.getElementById('loadMoreSection');
            loadMoreSection.style.display = hasMore ? 'block' : 'none';
        }

        // Format comment date
        function formatCommentDate(dateString) {
            const date = new Date(dateString);
            const now = new Date();
            const diffMs = now - date;
            const diffMins = Math.floor(diffMs / 60000);
            const diffHours = Math.floor(diffMs / 3600000);
            const diffDays = Math.floor(diffMs / 86400000);
            
            if (diffMins < 1) return '방금 전';
            if (diffMins < 60) return diffMins + '분 전';
            if (diffHours < 24) return diffHours + '시간 전';
            if (diffDays < 7) return diffDays + '일 전';
            
            return date.toLocaleDateString('ko-KR');
        }
    </script>

</body>
</html>