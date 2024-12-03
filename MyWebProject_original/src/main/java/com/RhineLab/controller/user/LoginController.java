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

@WebServlet("/login.do")
public class LoginController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id");
        String pw = request.getParameter("password");

        MemberDAO mDao = new MemberDAO();        
        MemberDTO member = mDao.loginCheck(id, pw);  // loginCheck 메소드 수정 필요

        if(member != null) {  // 로그인 성공
            HttpSession session = request.getSession();
            session.setAttribute("idKey", id);
            session.setAttribute("isLoggedIn", true);
            session.setAttribute("userRole", member.getRole());  // 권한 정보 저장
            request.setAttribute("loginResult", true);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("Main.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("Login.jsp");
        }
    }
}