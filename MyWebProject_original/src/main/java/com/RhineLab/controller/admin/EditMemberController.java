package com.RhineLab.controller.admin;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.RhineLab.model.AdminDAO;
import com.RhineLab.model.MemberDTO;

@WebServlet("/editMember.do")
public class EditMemberController extends HttpServlet {
    private AdminDAO adminDAO;
    
    public void init() {
        adminDAO = new AdminDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
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
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // 폼에서 전송된 데이터 받기
        String id = request.getParameter("id");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String role = request.getParameter("role");

        // MemberDTO 객체 생성 및 데이터 설정
        MemberDTO member = new MemberDTO();
        member.setId(id);
        member.setName(name);
        member.setRole(role);
        
        // 비밀번호가 입력된 경우에만 설정
        if(password != null && !password.trim().isEmpty()) {
            member.setPassword(password);
        }

        // AdminDAO의 updateMember 메서드 사용
        boolean success = adminDAO.updateMember(member);
        
        // 결과에 따른 리다이렉트
        if(success) {
            response.sendRedirect("userManage.do");
        } else {
            request.setAttribute("error", "회원 정보 수정에 실패했습니다.");
            doGet(request, response);
        }
    }
}