package com.RhineLab.model;

import java.sql.*;
import com.RhineLab.model.MemberDTO;
import com.RhineLab.util.JDBCUtil;

public class MemberDAO {
    // 로그인 체크
    public MemberDTO loginCheck(String id, String password) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        MemberDTO member = null;
        
        try {
            conn = JDBCUtil.getConnection();
            String strQuery = "SELECT * FROM users WHERE id = ? AND password = ?";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, id);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                member = new MemberDTO();
                member.setId(rs.getString("id"));
                member.setPassword(rs.getString("password"));
                member.setName(rs.getString("name"));
                member.setRole(rs.getString("role"));
                member.setEmail(rs.getString("email"));
                member.setCreatedAt(rs.getTimestamp("created_at"));
                member.setLastLogin(rs.getTimestamp("last_login"));
                
                // 로그인 시간 업데이트
                updateLastLogin(id);
            }
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
            JDBCUtil.close(rs, pstmt, conn);
        }
        return member;
    }
    
    // 회원가입
    public boolean memberInsert(MemberDTO member) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean flag = false;
        
        try {
            conn = JDBCUtil.getConnection();
            String strQuery = "INSERT INTO users (id, password, name, role, email) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, member.getId());
            pstmt.setString(2, member.getPassword());
            pstmt.setString(3, member.getName());
            pstmt.setString(4, member.getRole());
            pstmt.setString(5, member.getEmail());
            
            int count = pstmt.executeUpdate();
            if(count == 1) flag = true;
            
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
            JDBCUtil.close(pstmt, conn);
        }
        return flag;
    }
    
    // 회원정보 수정
    public boolean updateMember(MemberDTO member) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = JDBCUtil.getConnection();
            String strQuery = "UPDATE users SET password=?, name=?, email=? WHERE id=?";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, member.getPassword());
            pstmt.setString(2, member.getName());
            pstmt.setString(3, member.getEmail());
            pstmt.setString(4, member.getId());
            
            success = pstmt.executeUpdate() > 0;
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
            JDBCUtil.close(pstmt, conn);
        }
        return success;
    }
    
    // 최근 로그인 시간 업데이트
    private void updateLastLogin(String id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = JDBCUtil.getConnection();
            String strQuery = "UPDATE users SET last_login = CURRENT_TIMESTAMP WHERE id = ?";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, id);
            pstmt.executeUpdate();
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
            JDBCUtil.close(pstmt, conn);
        }
    }
}