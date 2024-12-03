<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>캐릭터 추가</title>
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
            max-width: 800px;
            margin: 0 auto;
        }
        
        .header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .card {
            background-color: #111827;
            border: 1px solid #1f2937;
            border-radius: 0.5rem;
            padding: 1.5rem;
            margin-bottom: 1rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-label {
            display: block;
            color: #9ca3af;
            margin-bottom: 0.5rem;
            font-size: 0.875rem;
        }
        
        .form-input {
            width: 100%;
            padding: 0.75rem;
            border-radius: 0.375rem;
            border: 1px solid #374151;
            background-color: #1f2937;
            color: white;
            font-size: 1rem;
        }
        
        .form-input:focus {
            outline: none;
            border-color: #2563eb;
            box-shadow: 0 0 0 2px rgba(37, 99, 235, 0.2);
        }
        
        .checkbox-group {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            gap: 1rem;
            margin-top: 0.5rem;
        }
        
        .checkbox-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #9ca3af;
        }
        
        .submit-button {
            width: 100%;
            padding: 0.75rem;
            background-color: #2563eb;
            color: white;
            border: none;
            border-radius: 0.375rem;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        
        .submit-button:hover {
            background-color: #1d4ed8;
        }
        
        .message {
            padding: 1rem;
            border-radius: 0.375rem;
            margin-bottom: 1rem;
        }
        
        .success {
            background-color: #064e3b;
            color: #6ee7b7;
        }
        
        .error {
            background-color: #7f1d1d;
            color: #fca5a5;
        }
        
        .section-title {
            color: #9ca3af;
            margin-bottom: 1rem;
            font-size: 1.2rem;
            font-weight: bold;
        }
        .admin-button {
            padding: 0.75rem 1.5rem;
            background-color: #4b5563;
            color: white;
            border: none;
            border-radius: 0.375rem;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            text-align: center;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        
        .admin-button:hover {
            background-color: #374151;
            transform: translateY(-1px);
        }
        
        .submit-button {
            padding: 0.75rem 1.5rem;
            transition: all 0.2s;
        }
        
        .submit-button:hover {
            transform: translateY(-1px);
        }
        
        /* 버튼 공통 스타일 */
        .submit-button, .admin-button {
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        /* 버튼 활성화 효과 */
        .submit-button:active, .admin-button:active {
            transform: translateY(1px);
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
        }
        
        /* 컨테이너 스타일 수정 */
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding-bottom: 3rem; /* 하단 여백 추가 */
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>캐릭터 추가</h1>
        </div>
        
        <%
            String message = request.getParameter("message");
            String messageType = request.getParameter("messageType");
            if (message != null && !message.isEmpty()) {
        %>
        <div class="message <%= messageType %>">
            <%= message %>
        </div>
        <%
            }
        %>
        
        <div class="card">
            <form action="${pageContext.request.contextPath}/addCharacter" method="post">
                <div class="form-group">
                    <label class="form-label" for="name">캐릭터 이름</label>
                    <input type="text" id="name" name="name" class="form-input" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="rarity">레어도</label>
                    <select id="rarity" name="rarity" class="form-input" required>
                        <option value="6">6성</option>
                        <option value="5">5성</option>
                        <option value="4">4성</option>
                        <option value="3">3성</option>
                        <option value="2">2성</option>
                        <option value="1">1성</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label class="form-label">직업 태그</label>
                    <div class="checkbox-group">
                        <div class="checkbox-item">
                            <input type="radio" id="vanguard" name="jobClass" value="뱅가드" required>
                            <label for="vanguard">뱅가드</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="radio" id="guard" name="jobClass" value="가드">
                            <label for="guard">가드</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="radio" id="defender" name="jobClass" value="디펜더">
                            <label for="defender">디펜더</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="radio" id="sniper" name="jobClass" value="스나이퍼">
                            <label for="sniper">스나이퍼</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="radio" id="caster" name="jobClass" value="캐스터">
                            <label for="caster">캐스터</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="radio" id="medic" name="jobClass" value="메딕">
                            <label for="medic">메딕</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="radio" id="supporter" name="jobClass" value="서포터">
                            <label for="supporter">서포터</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="radio" id="specialist" name="jobClass" value="스페셜리스트">
                            <label for="specialist">스페셜리스트</label>
                        </div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">위치 태그</label>
                    <div class="checkbox-group">
                        <div class="checkbox-item">
                            <input type="radio" id="melee" name="position" value="근거리" required>
                            <label for="melee">근거리</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="radio" id="ranged" name="position" value="원거리">
                            <label for="ranged">원거리</label>
                        </div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">특성 태그</label>
                    <div class="checkbox-group">
                        <div class="checkbox-item">
                            <input type="checkbox" id="dps" name="traits" value="딜러">
                            <label for="dps">딜러</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="survival" name="traits" value="생존형">
                            <label for="survival">생존형</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="defense" name="traits" value="방어형">
                            <label for="defense">방어형</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="healing" name="traits" value="힐링">
                            <label for="healing">힐링</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="support" name="traits" value="지원">
                            <label for="support">지원</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="control" name="traits" value="제어형">
                            <label for="control">제어형</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="nuker" name="traits" value="누커">
                            <label for="nuker">누커</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="summon" name="traits" value="소환">
                            <label for="summon">소환</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="fastRedeploy" name="traits" value="쾌속부활">
                            <label for="fastRedeploy">쾌속부활</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="robot" name="traits" value="로봇">
                            <label for="robot">로봇</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="aoe" name="traits" value="범위공격">
                            <label for="aoe">범위공격</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="slow" name="traits" value="감속">
                            <label for="slow">감속</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="debuff" name="traits" value="디버프">
                            <label for="debuff">디버프</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="shift" name="traits" value="강제이동">
                            <label for="shift">강제이동</label>
                        </div>
                    </div>
                </div>
               
                <div class="form-group" style="margin-bottom: 0;">
                    <div style="display: flex; justify-content: center; gap: 1rem;">
                        <button type="submit" class="submit-button" style="width: auto; min-width: 200px;">캐릭터 추가</button>
                        <a href="../admin.jsp" class="admin-button">관리자 페이지로</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>