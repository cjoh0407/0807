package kr.or.oti.todo;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.oti.todo.dto.TodoDTO;
import kr.or.oti.todo.service.TodoService;

/**
 * Servlet implementation class TodoListController
 */
@WebServlet("/todo/list")
public class TodoListController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ServletContext application =  request.getServletContext();
		HttpSession session = request.getSession();
		
		
		application.setAttribute("count", "0");
		session.setAttribute("count", 0);
		System.out.println("session id " + session.getId());
		
		response.addCookie(new Cookie("name", "hong"));
		
		List<TodoDTO> list;
		try {
			list = TodoService.INSTANCE.getList();
			request.setAttribute("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/todo/list.jsp");
		rd.forward(request, response);
	}

	public static void main(String [] args) {
//		List<TodoDTO> list = TodoService.INSTANCE.getList();
//		System.out.println(list);
//		
//		for (TodoDTO todoDTO : list) {
//			System.out.println(todoDTO);
//		}
//		TodoService.INSTANCE.register(new TodoDTO());
	}
	
}
