package com.RhineLab.controller.admin;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



@WebServlet("/admin.do")
public class AdminController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // 세션 체크
        HttpSession session = request.getSession();
        Boolean isLoggedIn = (Boolean)session.getAttribute("isLoggedIn");
        String userRole = (String)session.getAttribute("userRole");
        
        // 관리자 권한 체크
        if(isLoggedIn == null || !isLoggedIn || !"ADMIN".equals(userRole)) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        // admin.jsp로 포워딩
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin.jsp");
        dispatcher.forward(request, response);
    }
}
