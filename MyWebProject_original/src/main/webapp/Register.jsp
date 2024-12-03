<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
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
    .password-mismatch {
            color: #ef4444;
            font-size: 0.875rem;
            margin-top: 0.25rem;
            display: none;
        }
        
        .form-input.error {
            border-color: #ef4444;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <img src="images/logo.png" alt="Logo" class="logo">
            <h1>회원가입</h1>
        </div>
        
        <div class="card">
            <form action="register.do" method="get" onsubmit="return validateForm()">
                <div class="form-group">
                    <label class="form-label" for="id">아이디</label>
                    <input type="text" id="id" name="id" class="form-input" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="password">비밀번호</label>
                    <input type="password" id="password" name="password" class="form-input" required 
                           onkeyup="checkPassword()">
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="confirmPassword">비밀번호 확인</label>
                    <input type="password" id="confirmPassword" class="form-input" required 
                           onkeyup="checkPassword()">
                    <div id="passwordMismatch" class="password-mismatch">
                        비밀번호가 일치하지 않습니다.
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="name">닉네임</label>
                    <input type="text" id="name" name="name" class="form-input" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="email">이메일</label>
                    <input type="email" id="email" name="email" class="form-input" required>
                </div>
                
                <input type="hidden" name="role" value="USER">
                
                <button type="submit" class="submit-button" id="submitButton">회원가입</button>
                
                <div class="help-text">
                    이미 계정이 있으신가요?
                    <a href="Login.jsp">로그인</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        function checkPassword() {
            const password = document.getElementById('password');
            const confirmPassword = document.getElementById('confirmPassword');
            const mismatchDiv = document.getElementById('passwordMismatch');
            const submitButton = document.getElementById('submitButton');
            
            if(confirmPassword.value === '') {
                mismatchDiv.style.display = 'none';
                confirmPassword.classList.remove('error');
                return;
            }
            
            if(password.value !== confirmPassword.value) {
                mismatchDiv.style.display = 'block';
                confirmPassword.classList.add('error');
                submitButton.disabled = true;
            } else {
                mismatchDiv.style.display = 'none';
                confirmPassword.classList.remove('error');
                submitButton.disabled = false;
            }
        }
        
        function validateForm() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if(password !== confirmPassword) {
                alert('비밀번호가 일치하지 않습니다.');
                return false;
            }
            return true;
        }
    </script>
</body>
</html>