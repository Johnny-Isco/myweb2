package com.user.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class UserInterceptor extends HandlerInterceptorAdapter {

	private Logger log = Logger.getLogger(this.getClass());
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, 
			Object handler) throws Exception {
		try 
		{
			// 로그인상태가 아니면 홈으로 이동시킨다.
			if(request.getSession().getAttribute("loginInfo") == null)
			{
				// 프로젝트의 Context Path명을 반환하고 그 경로에 /user/openLogin.do를 추가한다.
				response.sendRedirect(request.getContextPath() + "/user/openLogin.do");
				return false;
			}
			else
			{
				return true;
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		
		return super.preHandle(request, response, handler);
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, 
			Object handler, ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}
}
