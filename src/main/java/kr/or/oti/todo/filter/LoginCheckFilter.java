package kr.or.oti.todo.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.oti.todo.dto.MemberDTO;
import kr.or.oti.todo.service.MemberService;
import lombok.extern.slf4j.Slf4j;

@WebFilter("/todo/*")
@Slf4j
public class LoginCheckFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        log.info("Login Check filter ... ");
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession();

        if (session.getAttribute("loginInfo") == null) {
            
            Cookie[] cookies = req.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("remember-me".equals(cookie.getName())) {
                        String uuid = cookie.getValue();

                        try {
                            MemberDTO memberDTO = MemberService.INSTANCE.getByUUID(uuid);

                            if (memberDTO != null) {
                                session.setAttribute("loginInfo", memberDTO);
                                chain.doFilter(request, response);
                                return;
                            }
                        } catch (Exception e) {
                            log.error("자동 로그인(UUID) 처리 중 예외 발생: ", e);
                        }
                    }
                }
            }

            log.info("로그인한 사용자가 없습니다");
            resp.sendRedirect("/login");
            return;
        }

        chain.doFilter(request, response);
    }
}