package kr.or.oti.todo;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.oti.todo.domain.TodoVO;
import kr.or.oti.todo.dto.TodoDTO;
import kr.or.oti.todo.service.TodoService;

/**
 * Servlet implementation class TodoModifyController
 */
@WebServlet("/todo/modify")
public class TodoModifyController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletContext application =  request.getServletContext();

		String count = (String) application.getAttribute("count");

		//tid에 대한 할일 상세 정보를 얻는다 
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
		
		//할일 상세 정보 출력 
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/todo/modify.jsp");
		rd.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//tid에 대한 상세 정보를 수정한다
		
		long tid = Long.parseLong(request.getParameter("tid"));
		String title = request.getParameter("title");
		String dueDate = request.getParameter("dueDate");
		String finished = request.getParameter("finished");
		TodoDTO todoDTO = TodoDTO.builder()
				.tid(tid)
				.title(title)
				.dueDate(LocalDate.parse(dueDate))
				.finished("true".equals(finished))
				.build();

		System.out.println("title = " + title);
		System.out.println("dueDate = " + dueDate);
		System.out.println("finished = " + finished);
		
		try {
			TodoService.INSTANCE.modify(todoDTO);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//목록으로 이동한다 
		response.sendRedirect("/todo/list");
	}

}
