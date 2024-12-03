package com.RhineLab.controller.character;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.RhineLab.model.CharacterDAO;
import com.RhineLab.model.CharacterDTO;

@WebServlet("/manageCharacters")
public class ManageCharacterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String search = request.getParameter("search");
        String rarityFilter = request.getParameter("rarity");

        CharacterDAO characterDAO = new CharacterDAO();
        List<CharacterDTO> characters = characterDAO.getCharactersBySearchAndRarity(search, rarityFilter);

        request.setAttribute("characters", characters);
        request.setAttribute("search", search);
        request.setAttribute("rarity", rarityFilter);

        request.getRequestDispatcher("/admin/ManageCharacterView.jsp").forward(request, response);
    }
}