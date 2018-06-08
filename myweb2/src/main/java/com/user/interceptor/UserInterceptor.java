package com.user.interceptor;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.user.service.UserService;

public class UserInterceptor extends HandlerInterceptorAdapter {

	private Logger log = Logger.getLogger(this.getClass());
	
	@Inject
	UserService userService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler) throws Exception {
		try 
		{
			log.debug("UserInterceptor 접근!");
			
			// 로그인상태 아닌지 판단한다
			if(request.getSession().getAttribute("loginInfo") == null)
			{
				// 세션정보가 없으면 쿠키 정보를 확인한다.
				Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
				if (loginCookie != null)
				{
					// 쿠키에서 세션ID를 꺼낸다.
					HashMap<String, Object> sessionMap = new HashMap<String, Object>();
					sessionMap.put("SESSIONID", loginCookie.getValue());
					
					// 세션ID값을 기준으로 검색하여 로그인 정보를 가져온다.
					HashMap<String, Object> resultMap = userService.checkUserInfoWithCookie(sessionMap);
					// 로그인 정보가 존재하는 경우
					if (resultMap != null)
					{
						// 세션에 로그인 정보를 저장한다.
						request.getSession().setAttribute("loginInfo", resultMap);
						request.getSession().setMaxInactiveInterval(60 * 30);
						return true;
					}
				}
				else
				{
					// 프로젝트의 Context Path명을 반환하고 그 경로에 /home/openHome.do를 추가한다.
					response.sendRedirect(request.getContextPath() + "/home/openHome.do");
					return false;
				}
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
	public void postHandle(HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler, ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}
}
