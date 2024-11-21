<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.RhineLab.model.MemberDTO" %>
<%
   MemberDTO member = (MemberDTO)request.getAttribute("member");
%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>회원 정보 수정</title>
   <style>
       body {
           background-color: black;
           color: white;
           font-family: Arial, sans-serif;
           margin: 0;
           padding: 20px;
           display: flex;
           justify-content: center;
           align-items: center;
           min-height: 100vh;
       }
       
       .edit-container {
           background-color: #1a1a1a;
           border-radius: 8px;
           padding: 30px;
           width: 400px;
       }
       
       .title {
           text-align: center;
           font-size: 24px;
           margin-bottom: 30px;
           color: white;
       }
       
       .form-group {
           margin-bottom: 20px;
       }
       
       .form-label {
           display: block;
           color: #007bff;
           margin-bottom: 8px;
           font-size: 14px;
       }
       
       .form-input {
           width: 100%;
           padding: 8px;
           border: 1px solid #333;
           border-radius: 4px;
           background-color: #333;
           color: white;
           box-sizing: border-box;
       }
       
       .form-select {
           width: 100%;
           padding: 8px;
           border: 1px solid #333;
           border-radius: 4px;
           background-color: #333;
           color: white;
       }
       
       .button-group {
           margin-top: 20px;
           text-align: center;
       }
       
       .submit-btn {
           padding: 10px 20px;
           background-color: #007bff;
           color: white;
           border: none;
           border-radius: 4px;
           cursor: pointer;
           margin-right: 10px;
       }
       
       .submit-btn:hover {
           background-color: #0056b3;
       }
       
       .cancel-btn {
           padding: 10px 20px;
           background-color: #6c757d;
           color: white;
           text-decoration: none;
           border-radius: 4px;
       }
       
       .cancel-btn:hover {
           background-color: #5a6268;
       }
   </style>
</head>
<body>
   <div class="edit-container">
       <h2 class="title">회원 정보 수정</h2>
       <form action="editMember.do" method="post" onsubmit="return validateForm()">
           <input type="hidden" name="id" value="<%= member.getId() %>">
           
           <div class="form-group">
               <label class="form-label">사용자명</label>
               <input type="text" name="name" class="form-input" value="<%= member.getName() %>" required>
           </div>
           
           <div class="form-group">
               <label class="form-label">이메일</label>
               <input type="email" name="email" class="form-input" value="<%= member.getEmail() %>" required>
           </div>
           
           <div class="form-group">
               <label class="form-label">권한</label>
               <select name="role" class="form-select">
                   <option value="USER" <%= "USER".equals(member.getRole()) ? "selected" : "" %>>일반사용자</option>
                   <option value="ADMIN" <%= "ADMIN".equals(member.getRole()) ? "selected" : "" %>>관리자</option>
               </select>
           </div>
           
           <div class="form-group">
               <label class="form-label">새 비밀번호</label>
               <input type="password" name="password" class="form-input" placeholder="변경 시에만 입력">
           </div>
           
           <div class="button-group">
               <button type="submit" class="submit-btn">저장</button>
               <a href="userManage.do" class="cancel-btn">취소</a>
           </div>
       </form>
   </div>

   <script>
   function validateForm() {
       var password = document.getElementsByName("password")[0].value;
       
       if(password !== '' && password.length < 4) {
           alert("비밀번호는 4자 이상이어야 합니다.");
           return false;
       }
       
       return confirm("회원 정보를 수정하시겠습니까?");
   }
   </script>
</body>
</html>