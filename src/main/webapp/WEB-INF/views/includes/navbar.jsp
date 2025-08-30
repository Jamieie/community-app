<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

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