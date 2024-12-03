<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.RhineLab.model.MemberDTO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 관리</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #111;
            color: #fff;
        }

        .admin-container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: #1f2937;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.3);
            padding: 30px;
        }

        .title {
            color: #fff;
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 20px;
        }

        .search-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .search-input {
            flex: 1;
            padding: 12px 16px;
            border-radius: 6px;
            border: 1px solid #374151;
            background-color: #1f2937;
            color: #fff;
            font-size: 16px;
        }

        .main-btn {
            padding: 12px 24px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            font-size: 16px;
            transition: background-color 0.2s;
        }

        .main-btn:hover {
            background-color: #45a049;
        }

        .main-btn i {
            margin-right: 8px;
        }

        .member-table {
            width: 100%;
            border-collapse: collapse;
            background-color: #1f2937;
            border-radius: 6px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.3);
        }

        .member-table th, .member-table td {
            padding: 16px;
            text-align: left;
            border-bottom: 1px solid #374151;
        }

        .member-table th {
            background-color: #111;
            color: #60a5fa;
            font-weight: 700;
        }

        .member-table tr:hover {
            background-color: #374151;
        }

        .member-actions {
            display: flex;
            gap: 8px;
        }

        .member-actions .edit-btn, .member-actions .delete-btn {
            padding: 8px 16px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .member-actions .edit-btn {
            background-color: #2563eb;
            color: #fff;
        }

        .member-actions .delete-btn {
            background-color: #dc2626;
            color: #fff;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
        }

        .status-admin {
            background-color: rgba(37, 99, 235, 0.1);
            color: #60a5fa;
            border: 1px solid rgba(37, 99, 235, 0.2);
        }

        .status-user {
            background-color: rgba(16, 185, 129, 0.1);
            color: #34d399;
            border: 1px solid rgba(16, 185, 129, 0.2);
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <h1 class="title">회원 관리</h1>
        <div class="search-bar">
            <input type="text" id="searchInput" class="search-input" placeholder="회원 검색..." onkeyup="searchTable()">
            <a href="Main.jsp" class="main-btn">
                <i class="fas fa-home"></i>메인으로
            </a>
        </div>
        
        <table class="member-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>이름</th>
                    <th>권한</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <%
                List<MemberDTO> memberList = (List<MemberDTO>)request.getAttribute("memberList");
                if(memberList != null) {
                    for(MemberDTO member : memberList) {
                %>
                <tr>
                    <td><%= member.getId() %></td>
                    <td><%= member.getName() %></td>
                    <td>
                        <span class="status-badge <%= "ADMIN".equals(member.getRole()) ? "status-admin" : "status-user" %>">
                            <%= member.getRole() %>
                        </span>
                    </td>
                    <td>
                        <div class="member-actions">
                            <form action="userManage.do" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="<%= member.getId() %>">
                                <button type="submit" class="delete-btn" onclick="return confirm('정말 삭제하시겠습니까?');">
                                    <i class="fas fa-trash"></i> 삭제
                                </button>
                            </form>
                            <button onclick="location.href='editMember.do?id=<%= member.getId() %>'" class="edit-btn">
                                <i class="fas fa-edit"></i> 수정
                            </button>
                        </div>
                    </td>
                </tr>
                <%
                    }
                }
                %>
            </tbody>
        </table>
    </div>

    <script>
   function searchTable() {
       var input = document.getElementById("searchInput");
       var filter = input.value.toUpperCase();
       var table = document.getElementsByClassName("member-table")[0];
       var tr = table.getElementsByTagName("tr");

       for (var i = 1; i < tr.length; i++) {  // i=1부터 시작해서 헤더 제외
           var td = tr[i].getElementsByTagName("td");
           var found = false;

           // 아이디와 이름만 검색 (td[0]는 아이디, td[1]은 이름)
           for (var j = 0; j < 2; j++) {
               var txtValue = td[j].textContent || td[j].innerText;
               if (txtValue.toUpperCase().indexOf(filter) > -1) {
                   found = true;
                   break;
               }
           }

           if (found) {
               tr[i].style.display = "";
           } else {
               tr[i].style.display = "none";
           }
       }
   }
</script>
</body>
</html>