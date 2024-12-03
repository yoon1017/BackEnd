<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AkaLive</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #1a1a1a;
            color: #ffffff;
            font-family: 'Segoe UI', Arial, sans-serif;
            line-height: 1.6;
        }

        .header {
            background-color: #000000;
            padding: 1rem;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 100;
            border-bottom: 1px solid #333;
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            color: #ff6b00;
            font-size: 1.5rem;
            font-weight: bold;
            text-decoration: none;
        }

        .nav-menu {
            display: flex;
            gap: 1rem;
            list-style: none;
        }

        .nav-menu a {
            color: #ffffff;
            text-decoration: none;
            padding: 0.5rem 1rem;
            transition: color 0.3s;
        }

        .nav-menu a:hover {
            color: #ff6b00;
        }

        .main-container {
            max-width: 1200px;
            margin: 80px auto 0;
            padding: 1rem;
            display: grid;
            grid-template-columns: 200px 1fr;
            gap: 2rem;
        }

        .sidebar {
            background-color: #242424;
            border-radius: 8px;
            padding: 1rem;
            height: fit-content;
        }

        .category-list {
            list-style: none;
        }

        .category-list li {
            margin-bottom: 0.5rem;
        }

        .category-list a {
            color: #ffffff;
            text-decoration: none;
            display: block;
            padding: 0.5rem;
            border-radius: 4px;
            transition: all 0.3s;
        }

        .category-list a:hover {
            background-color: #ff6b00;
        }

        .content {
            background-color: #242424;
            border-radius: 8px;
            padding: 1rem;
        }

        .board-list {
            list-style: none;
        }

        .board-item {
            background-color: #2d2d2d;
            border-radius: 4px;
            padding: 1rem;
            margin-bottom: 1rem;
            transition: transform 0.3s;
            cursor: pointer;
        }

        .board-item:hover {
            transform: translateX(5px);
        }

        .board-title {
            font-size: 1.1rem;
            margin-bottom: 0.5rem;
            color: #ff6b00;
        }

        .board-info {
            font-size: 0.9rem;
            color: #999;
            display: flex;
            justify-content: space-between;
        }

        .write-button {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            background-color: #ff6b00;
            color: white;
            border: none;
            padding: 1rem;
            border-radius: 50%;
            width: 60px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 2px 10px rgba(255, 107, 0, 0.3);
        }

        .write-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(255, 107, 0, 0.4);
        }

        .search-bar {
            background-color: #2d2d2d;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
        }

        .search-input {
            width: 100%;
            padding: 0.5rem;
            background-color: #1a1a1a;
            border: 1px solid #333;
            border-radius: 4px;
            color: white;
        }

        .search-input:focus {
            outline: none;
            border-color: #ff6b00;
        }

        .tag {
            display: inline-block;
            padding: 0.2rem 0.5rem;
            background-color: #333;
            color: #ff6b00;
            border-radius: 4px;
            font-size: 0.8rem;
            margin-right: 0.5rem;
        }

        .views-count {
            background-color: #333;
            padding: 0.2rem 0.5rem;
            border-radius: 4px;
            font-size: 0.8rem;
        }

        .likes-count {
            color: #ff6b00;
            margin-left: 1rem;
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="header-content">
            <a href="#" class="logo">AkaLive</a>
            <nav>
                <ul class="nav-menu">
                    <li><a href="#">홈</a></li>
                    <li><a href="#">인기</a></li>
                    <li><a href="#">최신</a></li>
                    <li><a href="#">로그인</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <main class="main-container">
        <aside class="sidebar">
            <ul class="category-list">
                <li><a href="#">전체</a></li>
                <li><a href="#">공지사항</a></li>
                <li><a href="#">자유게시판</a></li>
                <li><a href="#">유머</a></li>
                <li><a href="#">정보</a></li>
                <li><a href="#">질문</a></li>
                <li><a href="#">팁</a></li>
            </ul>
        </aside>

        <div class="content">
            <div class="search-bar">
                <input type="text" class="search-input" placeholder="검색어를 입력하세요...">
            </div>

            <ul class="board-list">
                <% for(int i = 0; i < 10; i++) { %>
                <li class="board-item">
                    <div class="board-title">게시글 제목 예시입니다</div>
                    <div class="board-info">
                        <div>
                            <span class="tag">자유</span>
                            <span>작성자</span>
                            <span>방금 전</span>
                        </div>
                        <div>
                            <span class="views-count">조회 123</span>
                            <span class="likes-count">추천 45</span>
                        </div>
                    </div>
                </li>
                <% } %>
            </ul>
        </div>
    </main>

    <button class="write-button">
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <line x1="12" y1="5" x2="12" y2="19"></line>
            <line x1="5" y1="12" x2="19" y2="12"></line>
        </svg>
    </button>
</body>
</html>