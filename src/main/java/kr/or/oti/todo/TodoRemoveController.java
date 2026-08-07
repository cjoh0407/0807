package kr.or.oti.todo;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.oti.todo.dto.TodoDTO;
import kr.or.oti.todo.service.TodoService;

/**
 * Servlet implementation class TodoRemoveController
 */
@WebServlet("/todo/remove")
public class TodoRemoveController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//할일을 삭제한다
		long tid = Long.parseLong(request.getParameter("tid"));
		try {
			TodoService.INSTANCE.remove(tid);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//목록으로 이동한다 
		response.sendRedirect("/todo/list");
	}

}
