package com.RhineLab.controller.user;

import java.io.IOException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.RhineLab.model.MemberDTO;
import com.RhineLab.model.MemberDAO;

@WebServlet("/userInfo.do")
public class UserInfoController extends HttpServlet {
    private MemberDAO memberDAO;
    
    public void init() {
        memberDAO = new MemberDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("idKey");
        
        // 로그인 체크
        if(userId == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        // 회원 정보 조회
        MemberDTO member = memberDAO.getMemberById(userId);
        request.setAttribute("member", member);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/userInfo.jsp");
        dispatcher.forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("idKey");
        
        // 로그인 체크
        if(userId == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        
        MemberDTO member = new MemberDTO();
        member.setId(userId);
        member.setName(name);
        member.setEmail(email);
        if(password != null && !password.trim().isEmpty()) {
            member.setPassword(password);
        }
        
        boolean success = memberDAO.updateMember(member);
        
        if(success) {
            response.sendRedirect("userInfo.do?success=true");
        } else {
            response.sendRedirect("userInfo.do?success=false");
        }
    }
}