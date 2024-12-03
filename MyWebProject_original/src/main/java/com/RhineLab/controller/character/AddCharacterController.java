package com.RhineLab.controller.character;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.RhineLab.model.CharacterDAO;
import com.RhineLab.model.CharacterDTO;

@WebServlet("/addCharacter")
public class AddCharacterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("message", request.getParameter("message"));
        request.setAttribute("messageType", request.getParameter("messageType"));

        request.getRequestDispatcher("/admin/AddCharacterView.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            String name = request.getParameter("name");
            int rarity = Integer.parseInt(request.getParameter("rarity"));
            String jobClass = request.getParameter("jobClass");
            String position = request.getParameter("position");
            String[] traits = request.getParameterValues("traits");

            List<String> allTags = new ArrayList<>();
            allTags.add(jobClass);
            allTags.add(position);
            if (traits != null) {
                allTags.addAll(java.util.Arrays.asList(traits));
            }

            // 새로운 CharacterDTO 생성자 사용 (id는 0으로 설정, DB에서 자동 생성됨)
            CharacterDTO newCharacter = new CharacterDTO(0, name, rarity, allTags);
            CharacterDAO characterDAO = new CharacterDAO();
            int result = characterDAO.createCharacter(newCharacter);

            if (result > 0) {
                String redirectUrl = request.getContextPath() + "/addCharacter?message=" 
                        + URLEncoder.encode("캐릭터가 성공적으로 추가되었습니다.", "UTF-8") 
                        + "&messageType=success";
                response.sendRedirect(redirectUrl);
            } else {
                String redirectUrl = request.getContextPath() + "/addCharacter?message=" 
                        + URLEncoder.encode("캐릭터 추가 중 오류가 발생했습니다.", "UTF-8") 
                        + "&messageType=error";
                response.sendRedirect(redirectUrl);
            }
        } catch (NumberFormatException e) {
            String redirectUrl = request.getContextPath() + "/addCharacter?message=" 
                    + URLEncoder.encode("잘못된 레어도 값입니다.", "UTF-8") 
                    + "&messageType=error";
            response.sendRedirect(redirectUrl);
        } catch (Exception e) {
            String redirectUrl = request.getContextPath() + "/addCharacter?message=" 
                    + URLEncoder.encode("시스템 오류가 발생했습니다.", "UTF-8") 
                    + "&messageType=error";
            response.sendRedirect(redirectUrl);
        }
    }
}