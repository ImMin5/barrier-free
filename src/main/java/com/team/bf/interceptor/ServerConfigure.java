package com.team.bf.interceptor;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class ServerConfigure implements WebMvcConfigurer {
	
	private static final List<String> LOGIN_URL_PATTERNS = Arrays.asList("/mypage*");
	private static final List<String> ADMIN_URL_PATTERNS = Arrays.asList("/admin/*");
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new LoginInterceptor())
		.addPathPatterns(LOGIN_URL_PATTERNS);
		
		registry.addInterceptor(new AdminInterceptor())
		.addPathPatterns(ADMIN_URL_PATTERNS);
	}
}
