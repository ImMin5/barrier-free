package com.team.bf.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements  HandlerInterceptor{
	
	@Override
	public boolean preHandle (HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception 
	{
		HttpSession session = request.getSession();
		String logId = (String)session.getAttribute("logId");
		if(logId != null && !logId.equals("")) {
			
			return true;
		}
		else {
			response.sendRedirect(request.getContextPath());
			return false;
		}
				
	}
}

