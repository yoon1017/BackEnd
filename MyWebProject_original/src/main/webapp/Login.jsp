<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: Arial, sans-serif;
        }
        
        .container {
            width: 100%;
            max-width: 400px;
            padding: 2rem;
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
        
        .card {
            background-color: #111827;
            border: 1px solid #1f2937;
            border-radius: 0.5rem;
            padding: 2rem;
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
        
        .help-text {
            margin-top: 1rem;
            text-align: center;
            font-size: 0.875rem;
            color: #9ca3af;
        }
        
        .help-text a {
            color: #60a5fa;
            text-decoration: none;
            margin-left: 0.5rem;
        }
        
        .help-text a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <img src="images/logo.png" alt="Logo" class="logo">
            <h1>로그인</h1>
        </div>
        
        <div class="card">
            <form action="login.do" method="get">
                <div class="form-group">
                    <label class="form-label" for="id">아이디</label>
                    <input type="text" id="id" name="id" class="form-input" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="password">비밀번호</label>
                    <input type="password" id="password" name="password" class="form-input" required>
                </div>
                
                <button type="submit" class="submit-button">로그인</button>
                
                <div class="help-text">
                    계정이 없으신가요?
                    <a href="Register.jsp">회원가입</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>