package com.RhineLab.controller.character;

import java.io.IOException;

import java.net.URLEncoder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.RhineLab.model.CharacterDAO;
import com.RhineLab.model.CharacterDTO;

@WebServlet("/deleteCharacter")
public class DeleteCharacterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String characterIdStr = request.getParameter("character_id");
        System.out.println("Received character_id: " + characterIdStr); // 디버깅용

        if (characterIdStr == null || characterIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + 
                "/manageCharacters?message=" + URLEncoder.encode("캐릭터 ID가 제공되지 않았습니다.", "UTF-8") + 
                "&messageType=error");
            return;
        }

        try {
            int characterId = Integer.parseInt(characterIdStr);
            CharacterDAO characterDAO = new CharacterDAO();
            
            // 삭제 전에 캐릭터가 존재하는지 확인
            CharacterDTO character = characterDAO.getCharacterById(characterId);
            if (character == null) {
                response.sendRedirect(request.getContextPath() + 
                    "/manageCharacters?message=" + URLEncoder.encode("해당 캐릭터를 찾을 수 없습니다.", "UTF-8") + 
                    "&messageType=error");
                return;
            }

            int result = characterDAO.deleteCharacter(characterId);
            System.out.println("Delete result: " + result); // 디버깅용

            if (result > 0) {
                response.sendRedirect(request.getContextPath() + 
                    "/manageCharacters?message=" + URLEncoder.encode("캐릭터가 성공적으로 삭제되었습니다.", "UTF-8") + 
                    "&messageType=success");
            } else {
                response.sendRedirect(request.getContextPath() + 
                    "/manageCharacters?message=" + URLEncoder.encode("캐릭터 삭제에 실패했습니다.", "UTF-8") + 
                    "&messageType=error");
            }
        } catch (NumberFormatException e) {
            System.out.println("Number format exception: " + e.getMessage()); // 디버깅용
            response.sendRedirect(request.getContextPath() + 
                "/manageCharacters?message=" + URLEncoder.encode("잘못된 캐릭터 ID 형식입니다.", "UTF-8") + 
                "&messageType=error");
        } catch (Exception e) {
            System.out.println("Exception occurred: " + e.getMessage()); // 디버깅용
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + 
                "/manageCharacters?message=" + URLEncoder.encode("시스템 오류가 발생했습니다.", "UTF-8") + 
                "&messageType=error");
        }
    }
}