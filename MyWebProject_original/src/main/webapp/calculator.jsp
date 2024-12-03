<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String currentPage = request.getRequestURI();
    String pageName = currentPage.substring(currentPage.lastIndexOf("/") + 1);
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공개모집 계산기</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            background-color: black;
            color: white;
            min-height: 100vh;
            padding: 1rem;
            font-family: Arial, sans-serif;
        }
        
        .container {
            max-width: 768px;
            margin: 0 auto;
        }
        
        .header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .logo {
            width: 150px;
            height: 150px;
            object-fit: contain;
            margin-bottom: 1rem;
        }
        
        .date {
            color: #9ca3af;
            font-size: 0.875rem;
        }
        
        .card {
            background-color: #111827;
            border: 1px solid #1f2937;
            border-radius: 0.5rem;
            padding: 1.5rem;
        }
        
        .input-guide {
            color: #9ca3af;
            margin-bottom: 1rem;
        }
        
        .tag-count {
            color: #9ca3af;
            margin-bottom: 1rem;
            font-size: 0.875rem;
        }
        
        .tag-group {
            margin-bottom: 1rem;
        }
        
        .tag {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            margin: 0 0.5rem 0.5rem 0;
            border-radius: 9999px;
            font-size: 0.875rem;
            background-color: #1f2937;
            color: #d1d5db;
            cursor: pointer;
            border: none;
            transition: all 0.2s;
        }
        
        .tag:hover {
            background-color: #374151;
        }
        
        .tag.selected {
            background-color: #2563eb;
            color: white;
        }
        
        .tag.disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        
        .button-group {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
        }
        
        .button {
            flex: 1;
            padding: 0.5rem;
            background-color: #1f2937;
            color: white;
            border: none;
            border-radius: 0.25rem;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        
        .button:hover {
            background-color: #374151;
        }
    </style>
    <script>
        const MAX_TAGS = 5;
        let selectedCount = 0;
        
        function toggleTag(element) {
            const isSelected = element.classList.contains('selected');
            
            if (isSelected) {
                element.classList.remove('selected');
                selectedCount--;
            } else {
                if (selectedCount >= MAX_TAGS) {
                    alert('최대 5개의 태그만 선택할 수 있습니다.');
                    return;
                }
                element.classList.add('selected');
                selectedCount++;
            }
            
            updateSelectedTags();
            updateTagDisplay();
            updateTagStates();
        }
        
        function updateSelectedTags() {
            const selectedTags = document.querySelectorAll('.tag.selected');
            const selectedValues = Array.from(selectedTags).map(tag => tag.getAttribute('data-value'));
            document.getElementById('selectedTags').value = selectedValues.join(',');
        }
        
        function updateTagDisplay() {
            const selectedTags = document.querySelectorAll('.tag.selected');
            const tagNames = Array.from(selectedTags).map(tag => tag.getAttribute('data-value'));
            
            if (tagNames.length > 0) {
                document.getElementById('tagCount').textContent = 
                    `선택된 태그: ${tagNames.join(', ')}`;
            } else {
                document.getElementById('tagCount').textContent = '선택된 태그: 없음';
            }
        }
        
        function updateTagStates() {
            const allTags = document.querySelectorAll('.tag:not(.selected)');
            if (selectedCount >= MAX_TAGS) {
                allTags.forEach(tag => tag.classList.add('disabled'));
            } else {
                allTags.forEach(tag => tag.classList.remove('disabled'));
            }
        }
        
        function resetTags() {
            const selectedTags = document.querySelectorAll('.tag.selected');
            selectedTags.forEach(tag => tag.classList.remove('selected'));
            selectedCount = 0;
            updateSelectedTags();
            updateTagDisplay();
            updateTagStates();
        }
    </script>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="container">
        <div class="header">
            <img src="images/logo.png" alt="Logo" class="logo">
            <h1>공개모집 계산기</h1>
            <p class="date">KR | 2024.10.31</p>
        </div>
        
        <form id="tagForm" action="calculator.do" method="post">
            <input type="hidden" id="selectedTags" name="selectedTags" value="">
            
            <div class="card">
                <div class="input-guide">
                    태그를 선택해주세요 (최대 5개)
                </div>
                
                <div id="tagCount" class="tag-count">선택된 태그: 없음</div>
                
                <div class="tag-group">
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="신입">신입</button>
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="특별채용">특별채용</button>
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="고급특별채용">고급특별채용</button>
                </div>
                
                <div class="tag-group">
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="근거리">근거리</button>
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="원거리">원거리</button>
                </div>
                
                <div class="tag-group">
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="가드">가드</button>
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="디펜더">디펜더</button>
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="메딕">메딕</button>
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="뱅가드">뱅가드</button>
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="서포터">서포터</button>
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="스나이퍼">스나이퍼</button>
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="스페셜리스트">스페셜리스트</button>
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="캐스터">캐스터</button>
                </div>
                
                <div class="tag-group">
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="감속">감속</button>
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="강제이동">강제이동</button>
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="누커">누커</button>
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="디버프">디버프</button>
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="딜러">딜러</button>
                </div>
                
                <div class="tag-group">
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="로봇">로봇</button>
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="방어형">방어형</button>
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="범위공격">범위공격</button>
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="생존형">생존형</button>
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="소환">소환</button>
                </div>
                
                <div class="tag-group">
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="제어형">제어형</button>
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="지원">지원</button>
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="코스트+">코스트+</button>
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="쾌속부활">쾌속부활</button>
                    <button type="button" class="tag" onclick="toggleTag(this)" data-value="힐링">힐링</button>
                </div>
                
                <div class="button-group">
                    <button type="button" class="button" onclick="resetTags()">태그 초기화</button>
                    <button type="submit" class="button">검색</button>
                </div>
            </div>
        </form>
    </div>
</body>
</html>