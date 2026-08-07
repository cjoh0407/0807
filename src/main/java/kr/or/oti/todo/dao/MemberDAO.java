package kr.or.oti.todo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import kr.or.oti.todo.domain.MemberVO;
import kr.or.oti.todo.domain.TodoVO;
import kr.or.oti.todo.dto.MemberDTO;
import lombok.Cleanup;

public class MemberDAO {

	public MemberVO selectOne(String mid) throws Exception  {
		@Cleanup Connection conn = ConnectionUtil.INSTANCE.getConnection();
		@Cleanup PreparedStatement pstmt = conn.prepareStatement("select * from tbl_member where mid=?") ;
		pstmt.setString(1, mid);
		
		@Cleanup ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			return MemberVO.builder()
					.mid(rs.getString("mid"))
					.mpw(rs.getString("mpw"))
					.mname(rs.getString("mname"))
					.build();
		}
		
		return null;
	}

	public void updateUUID(String mid, String uuid) throws Exception {
		@Cleanup Connection conn = ConnectionUtil.INSTANCE.getConnection();
		@Cleanup PreparedStatement pstmt = conn.prepareStatement("update tbl_member set uuid=? where mid=?") ;
		pstmt.setString(1, uuid);
		pstmt.setString(2, mid);
		
		pstmt.executeUpdate();
	}

	public MemberVO getByUUID(String uuid) throws Exception {
		@Cleanup Connection conn = ConnectionUtil.INSTANCE.getConnection();
		@Cleanup PreparedStatement pstmt = conn.prepareStatement("select * from tbl_member where uuid=?") ;
		pstmt.setString(1, uuid);
		
		@Cleanup ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			return MemberVO.builder()
					.mid(rs.getString("mid"))
					.mpw(rs.getString("mpw"))
					.mname(rs.getString("mname"))
					.build();
		}
		
		return null;
	}
}
