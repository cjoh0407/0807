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

import kr.or.oti.todo.dto.MemberDTO;
import kr.or.oti.todo.dto.TodoDTO;
import kr.or.oti.todo.service.TodoService;

@WebServlet("/todo/list")
public class TodoListController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ServletContext application = request.getServletContext();
		HttpSession session = request.getSession();
		
		application.setAttribute("count", "0");
		session.setAttribute("count", 0);
		System.out.println("session id " + session.getId());
		
		response.addCookie(new Cookie("name", "hong"));
		
		try {
		    MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo");
		    
		    if (loginInfo == null) {
		        response.sendRedirect(request.getContextPath() + "/login");
		    }
		    
		    String mid = loginInfo.getMid();
		    List<TodoDTO> list = TodoService.INSTANCE.getList(mid);
		    request.setAttribute("list", list);
		    
		    RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/todo/list.jsp");
		    rd.forward(request, response);
		    
		} catch (Exception e) {
		    e.printStackTrace();
		    throw new ServletException(e); // 예외 발생 시 원인을 콘솔에 명확히 남기기 위함
		}
	}

	public static void main(String [] args) {
	}
}