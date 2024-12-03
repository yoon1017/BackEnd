<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="com.RhineLab.model.CharacterDTO" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>캐릭터 관리</title>
   <style>
       * {
           margin: 0;
           padding: 0;
           box-sizing: border-box;
       }
       
       body {
           background-color: #f8f8f8;
           color: #333;
           min-height: 100vh;
           padding: 2rem;
           font-family: Arial, sans-serif;
           line-height: 1.6;
       }
       
       .container {
           max-width: 1200px;
           margin: 0 auto;
           padding-bottom: 3rem;
       }
       
       .header {
           text-align: center;
           margin-bottom: 2rem;
           padding: 2rem 0;
           background: linear-gradient(180deg, rgba(37,99,235,0.1) 0%, rgba(0,0,0,0) 100%);
           border-radius: 1rem;
       }
       
       .header h1 {
           font-size: 2rem;
           color: #333;
           text-shadow: 0 0 10px rgba(37,99,235,0.5);
       }

       .message {
           padding: 1rem;
           margin: 1rem 0;
           border-radius: 0.5rem;
       }
       
       .success {
           background-color: #d1fae5;
           color: #047857;
           border: 1px solid #047857;
       }
       
       .error {
           background-color: #fee2e2;
           color: #dc2626;
           border: 1px solid #dc2626;
       }
       
       .card {
           background-color: #fff;
           border: 1px solid #e5e7eb;
           border-radius: 1rem;
           padding: 1.5rem;
           margin-bottom: 1.5rem;
           box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
       }
       
       .section-title {
           color: #4b5563;
           margin-bottom: 1.5rem;
           font-size: 1.2rem;
           font-weight: bold;
           display: flex;
           align-items: center;
           gap: 0.5rem;
       }
       
       .section-title::before {
           content: "";
           display: block;
           width: 4px;
           height: 1.2rem;
           background-color: #2563eb;
           border-radius: 2px;
       }
       
       .character-table {
           width: 100%;
           border-collapse: separate;
           border-spacing: 0;
           margin-top: 1rem;
       }
       
       .character-table th,
       .character-table td {
           padding: 1rem;
           text-align: left;
           border-bottom: 1px solid #e5e7eb;
       }
       
       .character-table th {
           color: #4b5563;
           font-weight: normal;
           background-color: #f3f4f6;
           font-size: 0.9rem;
           text-transform: uppercase;
           letter-spacing: 0.05em;
       }
       
       .character-table th:first-child {
           border-top-left-radius: 0.5rem;
       }
       
       .character-table th:last-child {
           border-top-right-radius: 0.5rem;
       }
       
       .character-table tbody tr {
           transition: background-color 0.2s;
       }
       
       .character-table tbody tr:hover {
           background-color: #f3f4f6;
       }
       
       .tag {
           display: inline-block;
           padding: 0.25rem 0.75rem;
           background-color: #e0e7ff;
           color: #4f46e5;
           border-radius: 9999px;
           font-size: 0.75rem;
           margin: 0.125rem;
           border: 1px solid #c7d2fe;
           transition: all 0.2s;
       }
       
       .tag:hover {
           background-color: #c7d2fe;
       }
       
       .rare-6 { color: #ef4444; }
       .rare-5 { color: #f59e0b; }
       .rare-4 { color: #3b82f6; }
       .rare-3, .rare-2, .rare-1 { color: #333; }
       
       .button {
           display: inline-flex;
           align-items: center;
           justify-content: center;
           padding: 0.75rem 1.5rem;
           border: none;
           border-radius: 0.5rem;
           font-size: 0.875rem;
           cursor: pointer;
           transition: all 0.2s;
           text-decoration: none;
           color: #fff;
           gap: 0.5rem;
           font-weight: 500;
           box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
       }
       
       .delete-button {
           background-color: #dc2626;
           padding: 0.5rem 1rem;
           font-size: 0.8rem;
       }
       
       .delete-button:hover {
           background-color: #b91c1c;
           transform: translateY(-1px);
       }
       
       .add-button {
           background-color: #2563eb;
       }
       
       .add-button:hover {
           background-color: #1d4ed8;
           transform: translateY(-1px);
       }
       
       .admin-button {
           background-color: #4b5563;
       }
       
       .admin-button:hover {
           background-color: #374151;
           transform: translateY(-1px);
       }
       
       .button-group {
           display: flex;
           gap: 1rem;
           justify-content: center;
           margin-bottom: 2rem;
       }
       
       .search-container {
           padding: 1rem 0;
       }
       
       .search-group {
           display: flex;
           gap: 1rem;
           align-items: center;
       }
       
       .search-input {
           flex: 1;
           padding: 0.75rem 1rem;
           border-radius: 0.5rem;
           border: 1px solid #d1d5db;
           background-color: #f3f4f6;
           color: #333;
           font-size: 1rem;
           transition: all 0.2s;
       }
       
       .search-input:focus {
           outline: none;
           border-color: #2563eb;
           box-shadow: 0 0 0 2px rgba(37, 99, 235, 0.2);
       }
       
       .search-select {
           padding: 0.75rem 1rem;
           border-radius: 0.5rem;
           border: 1px solid #d1d5db;
           background-color: #f3f4f6;
           color: #333;
           font-size: 1rem;
           transition: all 0.2s;
       }
       
       .search-select:focus {
           outline: none;
           border-color: #2563eb;
           box-shadow: 0 0 0 2px rgba(37, 99, 235, 0.2);
       }
       
       .search-button {
           padding: 0.75rem 1.5rem;
           background-color: #2563eb;
           color: #fff;
           border: none;
           border-radius: 0.5rem;
           font-size: 1rem;
           cursor: pointer;
           transition: all 0.2s;
       }
       
       .search-button:hover {
           background-color: #1d4ed8;
           transform: translateY(-1px);
       }
       
       .reset-button {
           padding: 0.75rem 1.5rem;
           background-color: #4b5563;
           color: #fff;
           border: none;
           border-radius: 0.5rem;
           font-size: 1rem;
           cursor: pointer;
           text-decoration: none;
           transition: all 0.2s;
       }
       
       .reset-button:hover {
           background-color: #374151;
           transform: translateY(-1px);
       }
   </style>
</head>
<body>
   <div class="container">
       <div class="header">
           <h1>캐릭터 관리</h1>
       </div>

       <% if (request.getParameter("message") != null) { %>
       <div class="message <%= request.getParameter("messageType") %>">
           <%= request.getParameter("message") %>
       </div>
       <% } %>

       <div class="button-group">
           <a href="${pageContext.request.contextPath}/addCharacter" class="button add-button">
               <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                   <line x1="12" y1="5" x2="12" y2="19"></line>
                   <line x1="5" y1="12" x2="19" y2="12"></line>
               </svg>
               캐릭터 추가
           </a>
           <a href="${pageContext.request.contextPath}/admin.jsp" class="button admin-button">
   			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        		<path d="M3 12h18M3 6h18M3 18h18"/>
    		</svg>
    			관리자 페이지
		</a>
       </div>

       <div class="card">
           <form action="${pageContext.request.contextPath}/manageCharacters" method="get" class="search-form">
               <div class="search-container">
                   <div class="search-group">
                       <input type="text" name="search" value="${search}" class="search-input" placeholder="캐릭터 이름으로 검색...">
                       <select name="rarity" class="search-select">
                           <option value="">모든 레어도</option>
                           <option value="6" ${rarity == "6" ? "selected" : ""}>6성</option>
                           <option value="5" ${rarity == "5" ? "selected" : ""}>5성</option>
                           <option value="4" ${rarity == "4" ? "selected" : ""}>4성</option>
                           <option value="3" ${rarity == "3" ? "selected" : ""}>3성</option>
                           <option value="2" ${rarity == "2" ? "selected" : ""}>2성</option>
                           <option value="1" ${rarity == "1" ? "selected" : ""}>1성</option>
                       </select>
                       <button type="submit" class="search-button">검색</button>
                       <% if (request.getParameter("search") != null || request.getParameter("rarity") != null) { %>
                       <a href="${pageContext.request.contextPath}/manageCharacters" class="reset-button">초기화</a>
                       <% } %>
                   </div>
               </div>
           </form>
       </div>

       <div class="card">
           <div class="section-title">캐릭터 목록</div>
           <table class="character-table">
               <thead>
                   <tr>
                       <th>이름</th>
                       <th>레어도</th>
                       <th>직업</th>
                       <th>위치</th>
                       <th>특성</th>
                       <th>관리</th>
                   </tr>
               </thead>
               <tbody>
                   <% List<CharacterDTO> characters = (List<CharacterDTO>) request.getAttribute("characters");
                   if (characters != null) {
                       for (CharacterDTO character : characters) { %>
                   <tr>
                       <td class="rare-<%= character.getRarity() %>"><%= character.getName() %></td>
                       <td>★<%= character.getRarity() %></td>
                       <td>
                           <% for (String tag : character.getTags()) {
                               if (Arrays.asList("뱅가드", "가드", "디펜더", "스나이퍼", "캐스터", "메딕", "서포터", "스페셜리스트").contains(tag)) { %>
                               <span class="tag"><%= tag %></span>
                           <% }
                           } %>
                       </td>
                       <td>
                           <% for (String tag : character.getTags()) {
                               if (Arrays.asList("근거리", "원거리").contains(tag)) { %>
                               <span class="tag"><%= tag %></span>
                           <% }
                           } %>
                       </td>
                       <td>
                           <% for (String tag : character.getTags()) {
                               if (!Arrays.asList("뱅가드", "가드", "디펜더", "스나이퍼", "캐스터", "메딕", "서포터", "스페셜리스트", "근거리", "원거리").contains(tag)) { %>
                               <span class="tag"><%= tag %></span>
                           <% }
                           } %>
                       </td>
                       <td>
                          	<form action="${pageContext.request.contextPath}/deleteCharacter" method="post" style="display: inline;"onsubmit="return confirm('정말로 <%= character.getName() %> 캐릭터를 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.');">
    							<input type="hidden" name="character_id" value="<%= character.getId() %>">
    							<button type="submit" class="button delete-button">삭제</button>
							</form>
                       </td>
                   </tr>
                   <% }
                   } %>
               </tbody>
           </table>
       </div>
   </div>
</body>
</html>