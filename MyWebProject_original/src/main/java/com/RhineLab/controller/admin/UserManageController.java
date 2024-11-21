package com.RhineLab.controller.admin;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.RhineLab.model.AdminDAO;
import com.RhineLab.model.MemberDTO;

@WebServlet("/userManage.do")  // 경로 수정
public class UserManageController extends HttpServlet {
   private AdminDAO adminDAO;
   
   public void init() {
       adminDAO = new AdminDAO();
   }
   
   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response) 
           throws ServletException, IOException {
       request.setCharacterEncoding("UTF-8");
       
       // 디버깅용 출력
       System.out.println("doGet 메소드 실행");
       
       List<MemberDTO> memberList = adminDAO.getAllMembers();
       
       // 디버깅용 출력
       System.out.println("memberList size: " + memberList.size());
       
       request.setAttribute("memberList", memberList);
       
       // JSP로 포워딩
       RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/userManage.jsp");
       dispatcher.forward(request, response);
   }
   
   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response) 
           throws ServletException, IOException {
       request.setCharacterEncoding("UTF-8");
       String action = request.getParameter("action");
       
       if("delete".equals(action)) {
           String id = request.getParameter("id");
           adminDAO.deleteMember(id);
           response.sendRedirect("userManage.do");
       }
       else if("update".equals(action)) {
           String id = request.getParameter("id");
           String password = request.getParameter("password");
           String name = request.getParameter("name");
           String role = request.getParameter("role");

           MemberDTO member = new MemberDTO();
           member.setId(id);
           if(password != null && !password.trim().isEmpty()) {
               member.setPassword(password);
           }
           member.setName(name);
           member.setRole(role);

           adminDAO.updateMember(member);
           response.sendRedirect("userManage.do");
       }
   }
   
   protected void showEditForm(HttpServletRequest request, HttpServletResponse response) 
           throws ServletException, IOException {
       String id = request.getParameter("id");
       MemberDTO member = adminDAO.getMemberById(id);
       
       if(member != null) {
           request.setAttribute("member", member);
           RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/editMember.jsp");
           dispatcher.forward(request, response);
       } else {
           response.sendRedirect("userManage.do");
       }
   }
}