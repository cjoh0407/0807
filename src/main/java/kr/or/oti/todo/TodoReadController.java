package kr.or.oti.todo;

import java.io.IOException;

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
 * Servlet implementation class TodoReadController
 */
@WebServlet("/todo/read")
public class TodoReadController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int count = (int) session.getAttribute("count");

		System.out.println("session id " + session.getId());
		System.out.println("count " + count);
		
		session.setAttribute("count", count+1);
		Cookie []  cookies = request.getCookies();
		if (cookies != null) {
			for(int i=0;i<cookies.length;i++) {
				Cookie cookie = cookies[i];
				System.out.println(cookie.getName() + " : " + cookie.getValue());
			}
		}
		for(Cookie cookie : request.getCookies()) {
			System.out.println(cookie.getName() + " : " + cookie.getValue());
		}
		
		//할일 번호에 맞는 상세 정보를 얻는다 
		long tid = Long.parseLong(request.getParameter("tid"));
		TodoDTO dto;
		try {
			dto = TodoService.INSTANCE.get(tid);
			//JSP를 출력할 수 있게 dto 설정함 
			request.setAttribute("dto", dto);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//할일 상세 정보 출력하러 간다
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/todo/read.jsp");
		rd.forward(request, response);
	}

}
