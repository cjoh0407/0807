package kr.or.oti.login;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.oti.todo.dto.MemberDTO;
import kr.or.oti.todo.service.MemberService;

@WebServlet("/member/remove")
public class RemoveController extends HttpServlet {

    private static final long serialVersionUID = 1L;


    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        MemberDTO memberDTO =
                (MemberDTO) session.getAttribute("loginInfo");

        try {

            if (memberDTO != null) {

                MemberService.INSTANCE.remove(memberDTO.getMid());

            }

            // 세션 제거
            session.invalidate();


            // 자동로그인 쿠키 제거
            Cookie cookie = new Cookie("remember-me", null);
            cookie.setMaxAge(0);
            cookie.setPath("/");

            response.addCookie(cookie);


            response.sendRedirect("/login");


        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}