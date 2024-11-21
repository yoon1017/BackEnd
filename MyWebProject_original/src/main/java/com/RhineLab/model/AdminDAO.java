package com.RhineLab.model;

import java.sql.*;
import java.util.*;
import com.RhineLab.util.JDBCUtil;


public class AdminDAO {
   // 전체 회원 목록 조회
   public List<MemberDTO> getAllMembers() {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       List<MemberDTO> memberList = new ArrayList<>();
       
       try {
           conn = JDBCUtil.getConnection();
           String sql = "SELECT * FROM users";
           pstmt = conn.prepareStatement(sql);
           rs = pstmt.executeQuery();
           
           while(rs.next()) {
               MemberDTO member = new MemberDTO();
               member.setId(rs.getString("id"));
               member.setPassword(rs.getString("password"));
               member.setName(rs.getString("name"));
               member.setRole(rs.getString("role"));
               memberList.add(member);
           }
       } catch (Exception ex) {
           System.out.println("getAllMembers() 에러: " + ex);
           ex.printStackTrace();
       } finally {
           JDBCUtil.close(rs, pstmt, conn);
       }
       return memberList;
   }
   
   // 특정 회원 정보 조회
   public MemberDTO getMemberById(String id) {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       MemberDTO member = null;
       
       try {
           conn = JDBCUtil.getConnection();
           String sql = "SELECT * FROM users WHERE id = ?";
           pstmt = conn.prepareStatement(sql);
           pstmt.setString(1, id);
           rs = pstmt.executeQuery();
           
           if(rs.next()) {
               member = new MemberDTO();
               member.setId(rs.getString("id"));
               member.setPassword(rs.getString("password"));
               member.setName(rs.getString("name"));
               member.setRole(rs.getString("role"));
           }
       } catch (Exception ex) {
           System.out.println("getMemberById() 에러: " + ex);
       } finally {
           JDBCUtil.close(rs, pstmt, conn);
       }
       return member;
   }
   
   // 회원 정보 수정
   public boolean updateMember(MemberDTO member) {
       Connection conn = null;
       PreparedStatement pstmt = null;
       boolean result = false;
       
       try {
           conn = JDBCUtil.getConnection();
           
           // 비밀번호가 입력된 경우와 아닌 경우를 분리
           String sql;
           if(member.getPassword() != null && !member.getPassword().trim().isEmpty()) {
               sql = "UPDATE users SET id=?, password=?, name=?, role=? WHERE id=?";
           } else {
               sql = "UPDATE users SET id=?, name=?, role=? WHERE id=?";
           }
           
           pstmt = conn.prepareStatement(sql);
           
           if(member.getPassword() != null && !member.getPassword().trim().isEmpty()) {
               pstmt.setString(1, member.getId());
               pstmt.setString(2, member.getPassword());
               pstmt.setString(3, member.getName());
               pstmt.setString(4, member.getRole());
               pstmt.setString(5, member.getId());
           } else {
               pstmt.setString(1, member.getId());
               pstmt.setString(2, member.getName());
               pstmt.setString(3, member.getRole());
               pstmt.setString(4, member.getId());
           }
           
           int count = pstmt.executeUpdate();
           result = (count == 1);
           
       } catch (Exception ex) {
           System.out.println("updateMember() 에러: " + ex);
       } finally {
           JDBCUtil.close(pstmt, conn);
       }
       return result;
   }
   
   // 회원 삭제
   public boolean deleteMember(String id) {
       Connection conn = null;
       PreparedStatement pstmt = null;
       boolean result = false;
       
       try {
           conn = JDBCUtil.getConnection();
           String sql = "DELETE FROM users WHERE id=?";
           pstmt = conn.prepareStatement(sql);
           pstmt.setString(1, id);
           
           int count = pstmt.executeUpdate();
           result = (count == 1);
           
       } catch (Exception ex) {
           System.out.println("deleteMember() 에러: " + ex);
       } finally {
           JDBCUtil.close(pstmt, conn);
       }
       return result;
   }

   // 회원 수 조회
   public int getMemberCount() {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       int count = 0;
       
       try {
           conn = JDBCUtil.getConnection();
           String sql = "SELECT COUNT(*) FROM users";
           pstmt = conn.prepareStatement(sql);
           rs = pstmt.executeQuery();
           
           if(rs.next()) {
               count = rs.getInt(1);
           }
       } catch (Exception ex) {
           System.out.println("getMemberCount() 에러: " + ex);
       } finally {
           JDBCUtil.close(rs, pstmt, conn);
       }
       return count;
   }
   
   // 권한별 회원 수 조회
   public Map<String, Integer> getRoleCount() {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       Map<String, Integer> roleCount = new HashMap<>();
       
       try {
           conn = JDBCUtil.getConnection();
           String sql = "SELECT role, COUNT(*) as count FROM users GROUP BY role";
           pstmt = conn.prepareStatement(sql);
           rs = pstmt.executeQuery();
           
           while(rs.next()) {
               roleCount.put(rs.getString("role"), rs.getInt("count"));
           }
       } catch (Exception ex) {
           System.out.println("getRoleCount() 에러: " + ex);
       } finally {
           JDBCUtil.close(rs, pstmt, conn);
       }
       return roleCount;
   }
}
