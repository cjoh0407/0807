package kr.or.oti.todo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import kr.or.oti.todo.domain.TodoVO;
import lombok.Cleanup;

public class TodoDAO {

	public List<TodoVO> selectAll() throws Exception  {
		@Cleanup Connection conn = ConnectionUtil.INSTANCE.getConnection();
		@Cleanup PreparedStatement pstmt = conn.prepareStatement("select * from tbl_todo") ;
		@Cleanup ResultSet rs = pstmt.executeQuery();
		List<TodoVO> list = new ArrayList<>();
		
		while(rs.next()) {
			list.add(TodoVO.builder()
					.tid(rs.getLong("tid"))
					.title(rs.getString("title"))
					.dueDate(rs.getDate("dueDate").toLocalDate())
					.finished(rs.getBoolean("finished"))
					.build());
		}
		
		return list;
	}
	
	public TodoVO selectOne(long tid) throws Exception  {
		@Cleanup Connection conn = ConnectionUtil.INSTANCE.getConnection();
		@Cleanup PreparedStatement pstmt = conn.prepareStatement("select * from tbl_todo where tid=?") ;
		pstmt.setLong(1, tid);
		
		@Cleanup ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			return TodoVO.builder()
					.tid(rs.getLong("tid"))
					.title(rs.getString("title"))
					.dueDate(rs.getDate("dueDate").toLocalDate())
					.finished(rs.getBoolean("finished"))
					.build();
		}
		
		return null;
	}

	public void deleteOne(long tid) throws Exception  {
		@Cleanup Connection conn = ConnectionUtil.INSTANCE.getConnection();
		@Cleanup PreparedStatement pstmt = conn.prepareStatement("delete from tbl_todo where tid=?") ;
		pstmt.setLong(1, tid);
		
		pstmt.executeUpdate();
	}
	
	public void updateOne(TodoVO todoVO) throws Exception  {
		@Cleanup Connection conn = ConnectionUtil.INSTANCE.getConnection();
		@Cleanup PreparedStatement pstmt = conn.prepareStatement("update tbl_todo set title=?, dueDate=?, finished=? where tid=?") ;
		pstmt.setString(1, todoVO.getTitle());
		pstmt.setDate(2, java.sql.Date.valueOf(todoVO.getDueDate()));
		pstmt.setBoolean(3, todoVO.isFinished());
		pstmt.setLong(4, todoVO.getTid());
		
		pstmt.executeUpdate();
	}
	
	public void insertOne(TodoVO todoVO) throws Exception  {
		@Cleanup Connection conn = ConnectionUtil.INSTANCE.getConnection();
		@Cleanup PreparedStatement pstmt = conn.prepareStatement("insert into tbl_todo (title, dueDate, finished, mid) values (?,?,?,?)") ;
		pstmt.setString(1, todoVO.getTitle());
		pstmt.setDate(2, java.sql.Date.valueOf(todoVO.getDueDate()));
		pstmt.setBoolean(3, todoVO.isFinished());
		pstmt.setString(4, todoVO.getMid());
		
		pstmt.executeUpdate();
	}
	
	public static void main(String[] args) throws Exception {
//		Connection conn = null;
//		try {
//			conn = ConnectionUtil.INSTANCE.getConnection();
//			System.out.println("DB 연결 객체 얻기 되면 실제 DB에 연결됨 ");
//			conn.close();
//			System.out.println("DB 연결 닫기");
//		} catch (Exception e) {
//			e.printStackTrace();
//		}

//		try(Connection conn = ConnectionUtil.INSTANCE.getConnection()) {
//			System.out.println("DB 연결 객체 얻기 되면 실제 DB에 연결됨 ");
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		System.out.println("DB 연결 닫기");

//		@Cleanup Connection conn = ConnectionUtil.INSTANCE.getConnection();
//		System.out.println("DB 연결 객체 얻기 되면 실제 DB에 연결됨 ");
		
		TodoDAO todoDAO = new TodoDAO();
		List<TodoVO> list = todoDAO.selectAll();
		System.out.println(list);

		System.out.println(todoDAO.selectOne(2));
		
		TodoVO todoVO = TodoVO.builder()
				.tid((long)2)
				.title("수정된 제목")
				.dueDate(LocalDate.now())
				.finished(false)
				.build();
		todoDAO.updateOne(todoVO);
		
		TodoVO todoVO2 = TodoVO.builder()
				.title("신규 제목")
				.dueDate(LocalDate.now())
				.finished(true)
				.build();
		todoDAO.insertOne(todoVO2);
		
	}
}
