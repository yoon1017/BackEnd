<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String currentPage = request.getRequestURI();
    String pageName = currentPage.substring(currentPage.lastIndexOf("/") + 1);
    String contextPath = request.getContextPath();
%>

<!-- header.jsp -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: Arial, sans-serif;
        background-color: #000;
        color: white;
        min-height: 100vh;
    }

    /* 헤더 컨테이너 수정 */
    .header-container {
        background-color: #111;
        border-bottom: 1px solid #333;
        position: relative;
    }

    /* 로그아웃 버튼 스타일 */
    .logout-btn {
        position: absolute;
        right: 2rem;
        top: 50%;
        transform: translateY(-50%);
        padding: 0.5rem 1rem;
        background-color: transparent;
        color: #fff;
        border: 1px solid #007bff;
        border-radius: 4px;
        cursor: pointer;
        text-decoration: none;
        font-size: 0.9rem;
        transition: all 0.3s ease;
    }

    .logout-btn:hover {
        background-color: #007bff;
        color: white;
    }

    /* 네비게이션 스타일 */
    .nav-container {
        padding: 1rem;
        display: flex;
        justify-content: center;
        gap: 2rem;
        max-width: 1200px;
        margin: 0 auto;
    }

    .nav-item {
        display: flex;
        flex-direction: column;
        align-items: center;
        text-decoration: none;
        color: white;
        width: 80px;
    }

    .nav-icon {
        width: 40px;
        height: 40px;
        background-color: transparent;
        border: 2px solid white;
        transform: rotate(45deg);
        margin-bottom: 0.5rem;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: border-color 0.3s, color 0.3s;
    }

    .nav-icon.active {
        border-color: #007bff;
        color: #007bff;
    }

    .nav-item:hover .nav-icon {
        border-color: #007bff;
        color: #007bff;
    }

    .nav-icon i {
        transform: rotate(-45deg);
    }

    .nav-text {
        font-size: 0.9rem;
    }

    /* 콘텐츠 영역 스타일 */
    .content {
        max-width: 800px;
        margin: 3rem auto;
        padding: 2rem;
    }

    .logo {
        text-align: center;
        margin-bottom: 3rem;
    }

    .logo img {
        width: 120px;
    }

    .title {
        text-align: center;
        margin-bottom: 3rem;
        font-size: 1.5rem;
    }

    /* 그리드 스타일 */
    .grid-container {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 1rem;
        border: 1px solid #333;
        border-radius: 10px;
        padding: 1rem;
    }

    .grid-item {
        padding: 1rem;
        text-align: center;
        color: #007bff;
        text-decoration: none;
        border-bottom: 1px solid #333;
    }

    .grid-item:hover {
        background-color: rgba(0, 123, 255, 0.1);
    }

    .grid-item.full-width {
        grid-column: 1 / -1;
    }

    .grid-item.disabled {
        color: #666;
        pointer-events: none;
    }
</style>

<div class="header-container">
    <nav class="nav-container">
        <a href="<%=contextPath%>/Main.jsp" class="nav-item">
            <div class="nav-icon <%= pageName.equals("Main.jsp") ? "active" : "" %>">
                <i class="fas fa-users"></i>
            </div>
            <span class="nav-text">메인</span>
        </a>
        <a href="<%=contextPath%>/admin.jsp" class="nav-item">
            <div class="nav-icon <%= pageName.equals("admin.jsp") ? "active" : "" %>">
                <i class="fas fa-file-alt"></i>
            </div>
            <span class="nav-text">관리자페이지</span>
        </a>
        <a href="<%=contextPath%>/test.jsp" class="nav-item">
            <div class="nav-icon <%= pageName.equals("test.jsp") ? "active" : "" %>">
                <i class="fas fa-tools"></i>
            </div>
            <span class="nav-text">통계</span>
        </a>
        <a href="<%=contextPath%>/wave.jsp" class="nav-item">
            <div class="nav-icon <%= pageName.equals("wave.jsp") ? "active" : "" %>">
                <i class="fas fa-wave-square"></i>
            </div>
            <span class="nav-text">웨이브</span>
        </a>
        <a href="<%=contextPath%>/community.jsp" class="nav-item">
            <div class="nav-icon <%= pageName.equals("community.jsp") ? "active" : "" %>">
                <i class="fas fa-chart-line"></i>
            </div>
            <span class="nav-text">커뮤니티</span>
        </a>
    </nav>
    <a href="<%=contextPath%>/logout.do" class="logout-btn">로그아웃</a>
</div>