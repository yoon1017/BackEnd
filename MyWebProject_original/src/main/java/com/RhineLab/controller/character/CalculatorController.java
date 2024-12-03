package com.RhineLab.controller.character;

import java.io.IOException;
import java.util.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import com.RhineLab.model.CharacterDAO;
import com.RhineLab.model.CharacterDTO;

@WebServlet("/calculator.do")
public class CalculatorController extends HttpServlet {
    private CharacterDAO characterDAO;
    
    public void init() {
        characterDAO = new CharacterDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String selectedTags = request.getParameter("selectedTags");
        String[] tagArray = selectedTags != null ? selectedTags.split(",") : new String[0];
        
        Map<String, List<CharacterDTO>> results = new LinkedHashMap<>();
        generateTagCombinations(Arrays.asList(tagArray), results);
        
        request.setAttribute("selectedTags", tagArray);
        request.setAttribute("results", results);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("calculatorResult.jsp");
        dispatcher.forward(request, response);
    }
    
    private void generateTagCombinations(List<String> tags, Map<String, List<CharacterDTO>> results) {
        for(int r = 1; r <= tags.size(); r++) {
            List<List<String>> combinations = new ArrayList<>();
            generateCombinationsHelper(tags, r, 0, new ArrayList<>(), combinations);
            
            for(List<String> combination : combinations) {
                List<CharacterDTO> matchingChars = characterDAO.getCharactersByTags(combination);
                if(!matchingChars.isEmpty()) {
                    results.put(String.join(",", combination), matchingChars);
                }
            }
        }
    }
    
    private void generateCombinationsHelper(List<String> tags, int r, int start, 
                                          List<String> current, List<List<String>> result) {
        if(current.size() == r) {
            result.add(new ArrayList<>(current));
            return;
        }
        
        for(int i = start; i < tags.size(); i++) {
            current.add(tags.get(i));
            generateCombinationsHelper(tags, r, i + 1, current, result);
            current.remove(current.size() - 1);
        }
    }
}