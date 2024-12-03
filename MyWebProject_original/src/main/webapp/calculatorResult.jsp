<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.RhineLab.model.CharacterDTO" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>태그 계산 결과</title>
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
           max-width: 1024px;
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
       
       .section-title {
           color: #9ca3af;
           margin-bottom: 1rem;
           font-size: 1.2rem;
           font-weight: bold;
       }
       
       .tag-combination {
           display: flex;
           flex-wrap: wrap;
           gap: 0.5rem;
           margin-bottom: 1rem;
           background-color: #1a1a1a;
           padding: 0.5rem;
           border-radius: 0.5rem;
       }
       
       .tag-label {
           background-color: #2d3748;
           color: white;
           padding: 0.5rem 1rem;
           border-radius: 0.5rem;
           font-size: 0.875rem;
       }
       
       .operator-group {
           margin-bottom: 1.5rem;
           padding: 1rem;
           background-color: #1a1a1a;
           border-radius: 0.5rem;
       }
       
       .operator-list {
           display: flex;
           flex-wrap: wrap;
           gap: 0.5rem;
       }
       
       .operator-tag {
           display: inline-block;
           padding: 0.5rem 1rem;
           border-radius: 0.5rem;
           font-size: 0.875rem;
           background-color: #000000;
       }
       
       .rare-6 { color: #FF0000; border: 1px solid #FF0000; }
       .rare-5 { color: #FFA500; border: 1px solid #FFA500; }
       .rare-4 { color: #3B82F6; border: 1px solid #3B82F6; }
       .rare-3 { color: #6B7280; border: 1px solid #6B7280; }
       .rare-2 { color: #4B5563; border: 1px solid #4B5563; }
       .rare-1 { color: #374151; border: 1px solid #374151; }
       
       .button {
           display: inline-block;
           padding: 0.5rem 1rem;
           background-color: #1f2937;
           color: white;
           border: none;
           border-radius: 0.25rem;
           cursor: pointer;
           text-decoration: none;
           font-size: 0.875rem;
           transition: background-color 0.2s;
       }
       
       .button:hover {
           background-color: #374151;
       }
       
       .star-icon {
           margin-left: 0.25rem;
       }
       
       .back-button-container {
           text-align: center;
           margin-top: 2rem;
       }
   </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="container">
        <div class="header">
            <h1>태그 계산 결과</h1>
        </div>
        
        <div class="card">
            <div class="section-title">선택된 태그</div>
            <div class="tag-combination">
                <%
                String[] tags = (String[])request.getAttribute("selectedTags");
                if(tags != null) {
                    for(String tag : tags) {
                %>
                    <span class="tag-label"><%= tag %></span>
                <%
                    }
                }
                %>
            </div>
        </div>
        
        <div class="card">
            <div class="section-title">조합 결과</div>
            <%
            @SuppressWarnings("unchecked")
            Map<String, List<CharacterDTO>> results = 
                (Map<String, List<CharacterDTO>>)request.getAttribute("results");
            
            if(results != null && !results.isEmpty()) {
                for(Map.Entry<String, List<CharacterDTO>> entry : results.entrySet()) {
            %>
                <div class="operator-group">
                    <div class="tag-combination">
                        <%
                        String[] combinationTags = entry.getKey().split(",");
                        for(String tag : combinationTags) {
                        %>
                            <span class="tag-label"><%= tag %></span>
                        <%
                        }
                        %>
                    </div>
                    
                    <div class="operator-list">
                        <%
                        for(CharacterDTO character : entry.getValue()) {
                        %>
                            <span class="operator-tag rare-<%= character.getRarity() %>">
                                <%= character.getName() %>
                                <span class="star-icon">★<%= character.getRarity() %></span>
                            </span>
                        <%
                        }
                        %>
                    </div>
                </div>
            <%
                }
            } else {
            %>
                <div class="operator-group">
                    <p>일치하는 조합이 없습니다.</p>
                </div>
            <%
            }
            %>
        </div>
        
        <div class="back-button-container">
            <a href="calculator.jsp" class="button">돌아가기</a>
        </div>
    </div>
</body>
</html>