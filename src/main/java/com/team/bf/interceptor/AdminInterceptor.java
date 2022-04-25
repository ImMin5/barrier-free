package com.team.bf.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;

public class AdminInterceptor implements  HandlerInterceptor{
	
	@Override
	public boolean preHandle (HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception 
	{
		HttpSession session = request.getSession();
		
		String adminStatus = (String)session.getAttribute("adminStatus");
		if(adminStatus != null && adminStatus.equals("Y")) {
			return true;
		}
		else {
			System.out.println(request.getContextPath());
			response.sendRedirect("/");
			return false;
		}
				
	}
}

