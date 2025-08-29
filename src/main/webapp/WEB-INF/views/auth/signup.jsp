<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="../includes/header.jsp"%>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/signup.css">
</head>
<body>
<div class="signup-container">
    <div class="signup-header">
        <h1>Community App</h1>
        <p>새 계정을 만들어 시작하세요</p>
    </div>

    <c:if test="${not empty error}">
        <div class="error-message">
                ${error}
        </div>
    </c:if>
    
    <!-- 클라이언트 사이드 에러 메시지 -->
    <div id="clientErrorMessage" class="error-message" style="display: none;"></div>

    <form action="/auth/signup" method="post" id="signupForm">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <div class="form-group">
            <label for="name">이름</label>
            <input type="text" id="name" name="name" required
                   placeholder="이름을 입력하세요"
                   value="${param.name}"
                   maxlength="100">
            <c:if test="${not empty fieldErrors.name}">
                <div class="field-error">${fieldErrors.name}</div>
            </c:if>
        </div>

        <div class="form-group">
            <label for="email">이메일</label>
            <input type="email" id="email" name="email" required
                   placeholder="이메일을 입력하세요"
                   value="${param.email}">
            <c:if test="${not empty fieldErrors.email}">
                <div class="field-error">${fieldErrors.email}</div>
            </c:if>
        </div>

        <div class="form-group">
            <label for="password">비밀번호</label>
            <input type="password" id="password" name="password" required
                   placeholder="비밀번호를 입력하세요"
                   minlength="8">
            <div class="password-requirements">
                8자 이상, 영문, 숫자, 특수문자 포함
            </div>
            <c:if test="${not empty fieldErrors.password}">
                <div class="field-error">${fieldErrors.password}</div>
            </c:if>
        </div>

        <div class="form-group">
            <label for="confirmPassword">비밀번호 확인</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required
                   placeholder="비밀번호를 다시 입력하세요"
                   minlength="8">
            <c:if test="${not empty fieldErrors.confirmPassword}">
                <div class="field-error">${fieldErrors.confirmPassword}</div>
            </c:if>
        </div>

        <button type="submit" class="signup-btn">계정 만들기</button>
    </form>

    <div class="login-link">
        이미 계정이 있으신가요? <a href="/auth/login">로그인</a>
    </div>
</div>

<script>
    function showErrorMessage(message) {
        const errorDiv = document.getElementById('clientErrorMessage');
        errorDiv.textContent = message;
        errorDiv.style.display = 'block';
        
        // 자동으로 숨기기 (5초 후)
        setTimeout(function() {
            errorDiv.style.display = 'none';
        }, 5000);
    }

    document.getElementById('signupForm').addEventListener('submit', function(e) {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (password !== confirmPassword) {
            e.preventDefault();
            showErrorMessage('비밀번호가 일치하지 않습니다.');
            return false;
        }

        const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
        if (!passwordRegex.test(password)) {
            e.preventDefault();
            showErrorMessage('비밀번호는 8자 이상이며, 영문, 숫자, 특수문자를 포함해야 합니다.');
            return false;
        }
    });

    document.getElementById('confirmPassword').addEventListener('input', function() {
        const password = document.getElementById('password').value;
        const confirmPassword = this.value;

        if (password && confirmPassword && password !== confirmPassword) {
            this.classList.add('error');
        } else {
            this.classList.remove('error');
        }
    });
</script>
</body>
</html>
