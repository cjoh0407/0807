package kr.or.oti.todo.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpFilter;
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
		log.trace("trace");
		log.debug("debug");
		log.info("info");
		log.warn("warn");
		log.error("error");
		log.info("Login Check filter ... ");
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		HttpSession session = req.getSession();
		
		if (session.getAttribute("loginInfo") == null) {
			//1. remember-me 쿠키 값 존재 여부 확인 
			for (Cookie cookie : req.getCookies()) {
				if ("remember-me".equals(cookie.getName())) {
					//2. remember-me 쿠키에 있는 값을 uuid 변수에 설정한다 
					String uuid = cookie.getValue();
					
					//3. uuid를 이용하여 로그인 객체를 얻는다
					MemberDTO memberDTO = MemberService.INSTANCE.getByUUID(uuid);
					
					//로그인 객체를 세션에 저장한다
					if (memberDTO != null) {
						session.setAttribute("loginInfo", memberDTO);
						chain.doFilter(request, response);
						return ;
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
