<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.RhineLab.model.MemberDTO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 정보 관리</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #111;
            color: #fff;
        }

        .user-container {
            max-width: 600px;
            margin: 0 auto;
            background-color: #1f2937;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.3);
            padding: 30px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .title {
            color: #fff;
            font-size: 24px;
            margin: 0;
        }

        .main-btn {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 6px;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            color: #9ca3af;
            margin-bottom: 8px;
        }

        .form-input {
            width: 100%;
            padding: 12px;
            border-radius: 6px;
            border: 1px solid #374151;
            background-color: #374151;
            color: #fff;
            box-sizing: border-box;
        }

        .form-input:focus {
            outline: none;
            border-color: #60a5fa;
        }

        .button-group {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            margin-top: 30px;
        }

        .submit-btn {
            padding: 12px 24px;
            background-color: #2563eb;
            color: #fff;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .success-message {
            background-color: #065f46;
            color: #fff;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
            display: none;
        }

        .error-message {
            background-color: #dc2626;
            color: #fff;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
            display: none;
        }
    </style>
</head>
<body>
    <%
        MemberDTO member = (MemberDTO)request.getAttribute("member");
        String success = request.getParameter("success");
    %>
    <div class="user-container">
        <div class="header">
            <h1 class="title">내 정보 관리</h1>
            <a href="Main.jsp" class="main-btn">
                <i class="fas fa-home"></i>메인으로
            </a>
        </div>
        
        <% if("true".equals(success)) { %>
            <div class="success-message" style="display: block;">
                정보가 성공적으로 수정되었습니다.
            </div>
        <% } else if("false".equals(success)) { %>
            <div class="error-message" style="display: block;">
                정보 수정에 실패했습니다.
            </div>
        <% } %>

        <form action="userInfo.do" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label class="form-label">아이디</label>
                <input type="text" class="form-input" value="<%= member.getId() %>" readonly>
            </div>

            <div class="form-group">
                <label class="form-label">이름</label>
                <input type="text" name="name" class="form-input" value="<%= member.getName() %>" required>
            </div>

            <div class="form-group">
                <label class="form-label">이메일</label>
                <input type="email" name="email" class="form-input" value="<%= member.getEmail() %>" required>
            </div>

            <div class="form-group">
                <label class="form-label">새 비밀번호</label>
                <input type="password" name="password" class="form-input" placeholder="변경시에만 입력">
            </div>

            <div class="form-group">
                <label class="form-label">비밀번호 확인</label>
                <input type="password" name="confirmPassword" class="form-input" placeholder="비밀번호 확인">
            </div>

            <div class="button-group">
                <button type="submit" class="submit-btn">저장</button>
            </div>
        </form>
    </div>

    <script>
    function validateForm() {
        var password = document.getElementsByName("password")[0].value;
        var confirmPassword = document.getElementsByName("confirmPassword")[0].value;

        if(password !== '') {
            if(password !== confirmPassword) {
                alert("비밀번호가 일치하지 않습니다.");
                return false;
            }
            if(password.length < 4) {
                alert("비밀번호는 4자 이상이어야 합니다.");
                return false;
            }
        }

        return confirm("정보를 수정하시겠습니까?");
    }
    </script>
</body>
</html>