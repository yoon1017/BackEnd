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
@WebServlet("/register.do")
public class RegisterController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String id = request.getParameter("id");
        String pw = request.getParameter("password");
        String name = request.getParameter("name");
        String role = request.getParameter("role");

        MemberDTO mDto = new MemberDTO();
        mDto.setId(id);
        mDto.setPassword(pw);
        mDto.setName(name);
        mDto.setRole(role);        
        
        MemberDAO mDao = new MemberDAO();    
        boolean insertCheck = mDao.memberInsert(mDto);

        if(insertCheck) {
            request.setAttribute("joinResult", insertCheck);
            HttpSession session = request.getSession();
            session.setAttribute("idKey", id);
            RequestDispatcher dispatcher = request.getRequestDispatcher("Main.jsp");
            dispatcher.forward(request, response);
        } else {
            request.setAttribute("joinResult", 0);
            RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp");
            dispatcher.forward(request, response);
        }
    }
}
