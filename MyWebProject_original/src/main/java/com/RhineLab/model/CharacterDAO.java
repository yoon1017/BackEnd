package com.RhineLab.model;

import java.sql.*;
import java.util.*;
import com.RhineLab.util.JDBCUtil_character;

public class CharacterDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public int createCharacter(CharacterDTO character) {
        int result = 0;
        try {
            conn = JDBCUtil_character.getConnection();
            conn.setAutoCommit(false);

            String insertCharacter = "INSERT INTO characters (name, rarity) VALUES (?, ?)";
            pstmt = conn.prepareStatement(insertCharacter, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, character.getName());
            pstmt.setInt(2, character.getRarity());
            
            result = pstmt.executeUpdate();
            
            rs = pstmt.getGeneratedKeys();
            int characterId = 0;
            if(rs.next()) {
                characterId = rs.getInt(1);
            }

            String insertTag = "INSERT INTO character_tags (character_id, tag_id) " +
                             "SELECT ?, id FROM tags WHERE name = ?";
            pstmt = conn.prepareStatement(insertTag);
            
            for(String tag : character.getTags()) {
                pstmt.setInt(1, characterId);
                pstmt.setString(2, tag);
                pstmt.executeUpdate();
            }
            
            conn.commit();
        } catch(Exception e) {
            try {
                if(conn != null) conn.rollback();
            } catch(SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            JDBCUtil_character.close(rs, pstmt, conn);
        }
        return result;
    }

    public List<CharacterDTO> getCharactersByTags(List<String> tags) {
        List<CharacterDTO> characters = new ArrayList<>();
        try {
            conn = JDBCUtil_character.getConnection();
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT c.id, c.name, c.rarity, c.created_at, GROUP_CONCAT(t.name) as tags ");
            sql.append("FROM characters c ");
            sql.append("JOIN character_tags ct ON c.id = ct.character_id ");
            sql.append("JOIN tags t ON ct.tag_id = t.id ");
            sql.append("GROUP BY c.id, c.name, c.rarity, c.created_at ");
            sql.append("HAVING COUNT(CASE WHEN t.name IN (");
            
            for(int i = 0; i < tags.size(); i++) {
                if(i > 0) sql.append(",");
                sql.append("?");
            }
            sql.append(") THEN 1 END) = ? ");
            sql.append("ORDER BY c.rarity DESC, c.name ASC");

            pstmt = conn.prepareStatement(sql.toString());
            
            int paramIndex = 1;
            for(String tag : tags) {
                pstmt.setString(paramIndex++, tag);
            }
            pstmt.setInt(paramIndex, tags.size());

            rs = pstmt.executeQuery();
            while(rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                int rarity = rs.getInt("rarity");
                Timestamp createdAt = rs.getTimestamp("created_at");
                List<String> charTags = Arrays.asList(rs.getString("tags").split(","));
                characters.add(new CharacterDTO(id, name, rarity, charTags, createdAt));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil_character.close(rs, pstmt, conn);
        }
        return characters;
    }

    public List<String> getAllTags() {
        List<String> tags = new ArrayList<>();
        try {
            conn = JDBCUtil_character.getConnection();
            String sql = "SELECT name FROM tags ORDER BY name";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                tags.add(rs.getString("name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil_character.close(rs, pstmt, conn);
        }
        return tags;
    }

    public List<CharacterDTO> getCharactersBySearchAndRarity(String search, String rarity) {
        List<CharacterDTO> characters = new ArrayList<>();
        try {
            conn = JDBCUtil_character.getConnection();
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT c.id, c.name, c.rarity, c.created_at, GROUP_CONCAT(t.name) as tags ");
            sql.append("FROM characters c ");
            sql.append("LEFT JOIN character_tags ct ON c.id = ct.character_id ");
            sql.append("LEFT JOIN tags t ON ct.tag_id = t.id ");
            sql.append("WHERE c.name LIKE ? ");
            if (rarity != null && !rarity.trim().isEmpty()) {
                sql.append("AND c.rarity = ? ");
            }
            sql.append("GROUP BY c.id, c.name, c.rarity, c.created_at ");
            sql.append("ORDER BY c.rarity DESC, c.name");

            pstmt = conn.prepareStatement(sql.toString());
            pstmt.setString(1, "%" + (search != null ? search : "") + "%");
            if (rarity != null && !rarity.trim().isEmpty()) {
                pstmt.setInt(2, Integer.parseInt(rarity));
            }

            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                int rarityValue = rs.getInt("rarity");
                Timestamp createdAt = rs.getTimestamp("created_at");
                String tagsStr = rs.getString("tags");
                List<String> tagsList = tagsStr != null ? Arrays.asList(tagsStr.split(",")) : new ArrayList<>();
                characters.add(new CharacterDTO(id, name, rarityValue, tagsList, createdAt));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil_character.close(rs, pstmt, conn);
        }
        return characters;
    }

    public int deleteCharacter(int characterId) {
        int result = 0;
        try {
            conn = JDBCUtil_character.getConnection();
            conn.setAutoCommit(false);

            System.out.println("Deleting character with ID: " + characterId); // 디버깅용

            // 1. character_tags 테이블에서 관련 데이터 삭제
            String deleteTagsSQL = "DELETE FROM character_tags WHERE character_id = ?";
            pstmt = conn.prepareStatement(deleteTagsSQL);
            pstmt.setInt(1, characterId);
            int tagsDeleted = pstmt.executeUpdate();
            System.out.println("Tags deleted: " + tagsDeleted); // 디버깅용

            // 2. characters 테이블에서 캐릭터 삭제
            String deleteCharSQL = "DELETE FROM characters WHERE id = ?";
            pstmt = conn.prepareStatement(deleteCharSQL);
            pstmt.setInt(1, characterId);
            result = pstmt.executeUpdate();
            System.out.println("Character deleted: " + result); // 디버깅용

            if (result > 0) {
                conn.commit();
                System.out.println("Transaction committed"); // 디버깅용
            } else {
                conn.rollback();
                System.out.println("Transaction rolled back"); // 디버깅용
            }
        } catch (SQLException e) {
            System.out.println("SQL Exception: " + e.getMessage()); // 디버깅용
            try {
                if (conn != null) {
                    conn.rollback();
                    System.out.println("Transaction rolled back due to exception"); // 디버깅용
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            JDBCUtil_character.close(pstmt, conn);
        }
        return result;
    }

    public CharacterDTO getCharacterById(int characterId) {
        CharacterDTO character = null;
        try {
            conn = JDBCUtil_character.getConnection();
            String sql = "SELECT c.id, c.name, c.rarity, c.created_at, GROUP_CONCAT(t.name) as tags " +
                        "FROM characters c " +
                        "LEFT JOIN character_tags ct ON c.id = ct.character_id " +
                        "LEFT JOIN tags t ON ct.tag_id = t.id " +
                        "WHERE c.id = ? " +
                        "GROUP BY c.id, c.name, c.rarity, c.created_at";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, characterId);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                String name = rs.getString("name");
                int rarity = rs.getInt("rarity");
                Timestamp createdAt = rs.getTimestamp("created_at");
                String tagsStr = rs.getString("tags");
                List<String> tagsList = tagsStr != null ? Arrays.asList(tagsStr.split(",")) : new ArrayList<>();
                
                character = new CharacterDTO(characterId, name, rarity, tagsList, createdAt);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil_character.close(rs, pstmt, conn);
        }
        return character;
    }
}