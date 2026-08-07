package kr.or.oti.login;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.oti.todo.dto.MemberDTO;
import kr.or.oti.todo.service.MemberService;
import kr.or.oti.todo.service.TodoService;

/**
 * Servlet implementation class LoginController
 */
@WebServlet("/login")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/loginView/login.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 한글 깨짐 방지
		request.setCharacterEncoding("UTF-8");
		
		// 사용자가 입력한 파라미터 값 받기
		String id = request.getParameter("loginId");
		String pw = request.getParameter("loginPw");
		String auto = request.getParameter("auto");
		
		try {
			MemberDTO memberDTO = MemberService.INSTANCE.login(id, pw);
			if(memberDTO != null) {
			    HttpSession session = request.getSession();
			    session.setAttribute("loginInfo", memberDTO);

			    //자동로그인 설정 
			    if ("on".equals(auto)) {
			    	//1. uuid 발급 받는다
			    	String uuid = UUID.randomUUID().toString();
			    	
			    	//2. 발급 uuid를 DB에 저장한다
			    	MemberService.INSTANCE.updateUUID(id, uuid);
			    	
			    	//3. 발급 받은 uuid를 쿠키로 기록하여 브라우저에 저장한다
			    	Cookie cookie = new Cookie("remember-me", uuid);
			    	cookie.setMaxAge(60 * 60); //1 시간 
			    	cookie.setPath("/");
			    	
			    	response.addCookie(cookie);
			    	
			    }
			    
			    response.sendRedirect("/todo/list");
			    return;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		response.sendRedirect("/login?result=error");
	}

}
