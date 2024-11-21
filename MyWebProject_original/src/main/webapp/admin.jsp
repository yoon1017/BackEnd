<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MINASE - 관리자 페이지</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <!-- 헤더 포함 -->
    <jsp:include page="header.jsp" />

    <main class="content">
        <h1 class="title">관리자 페이지</h1>

        <div class="admin-container">
            <div class="admin-section">
                <h2>회원 관리</h2>
                <div class="admin-grid">
                    <a href="userManage.do" class="admin-item">
                        <i class="fas fa-users"></i>
                        <span>회원 목록/관리</span>
                    </a>
                </div>
            </div>

            <div class="admin-section">
                <h2>콘텐츠 관리</h2>
                <div class="admin-grid">
                    <a href="admin/noticeManage.do" class="admin-item">
                        <i class="fas fa-bullhorn"></i>
                        <span>공지사항 관리</span>
                    </a>
                    <a href="admin/communityManage.do" class="admin-item">
                        <i class="fas fa-comments"></i>
                        <span>커뮤니티 관리</span>
                    </a>
                </div>
            </div>

            <div class="admin-section">
                <h2>데이터 관리</h2>
                <div class="admin-grid">
                    <a href="admin/characterList.do" class="admin-item">
                        <i class="fas fa-database"></i>
                        <span>캐릭터 목록/삭제</span>
                    </a>
                    <a href="admin/characterAdd.do" class="admin-item">
                        <i class="fas fa-calculator"></i>
                        <span>캐릭터 추가</span>
                    </a>
                </div>
            </div>

            <div class="admin-section">
                <h2>시스템 관리</h2>
                <div class="admin-grid">
                    <a href="admin/statistics.do" class="admin-item">
                        <i class="fas fa-chart-bar"></i>
                        <span>사용 통계</span>
                    </a>
                    <a href="admin/logs.do" class="admin-item">
                        <i class="fas fa-history"></i>
                        <span>로그 확인</span>
                    </a>
                </div>
            </div>
        </div>
    </main>

    <style>
        .admin-container {
            display: flex;
            flex-direction: column;
            gap: 2rem;
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .admin-section {
            background: #111;
            border-radius: 8px;
            padding: 1.5rem;
            border: 1px solid #333;
        }

        .admin-section h2 {
            color: #007bff;
            margin-bottom: 1rem;
            font-size: 1.2rem;
        }

        .admin-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .admin-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 1.5rem;
            background: #1a1a1a;
            border-radius: 6px;
            text-decoration: none;
            color: white;
            transition: all 0.3s ease;
            gap: 0.5rem;
        }

        .admin-item:hover {
            background: #222;
            transform: translateY(-2px);
        }

        .admin-item i {
            font-size: 1.5rem;
            color: #007bff;
        }

        .admin-item span {
            font-size: 0.9rem;
        }

        .title {
            color: white;
            text-align: center;
            margin: 2rem 0;
            font-size: 2rem;
        }

        @media (max-width: 768px) {
            .admin-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</body>
</html>