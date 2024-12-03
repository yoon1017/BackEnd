<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>RhineLab</title>
</head>
<body>
    <!-- 해더 - 디자인 -->
    <jsp:include page="header.jsp" />

    <!-- 페이지 콘텐츠 -->
    <main class="content">
        <!-- 여기에 각 페이지의 고유한 내용을 넣으세요 -->
        <div class="logo">
            <img src="images/logo.png" alt="MINASE">
        </div>
        
        <h1 class="title">명일방주 플레이에 유용한 서비스를 제공합니다.</h1>

        <div class="grid-container">
            <a href="calculator.jsp" class="grid-item full-width">공개 모집 계산기</a>
            <a href="leveling.jsp" class="grid-item full-width">레벨링 비용</a>
            <a href="materials1.jsp" class="grid-item full-width">재료 계산 1.0</a>
        </div>
    </main>
    <jsp:include page="footer.jsp" />
</body>
</html>