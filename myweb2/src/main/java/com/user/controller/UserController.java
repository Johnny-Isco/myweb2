package com.user.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.company.common.CommandMap;
import com.user.service.UserService;

@Controller
public class UserController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="userService")
	private UserService userService;
	
	// 회원가입 페이지 이동 메소드
	@RequestMapping(value="/user/openSignUp.do")
	public ModelAndView openSignUp(CommandMap commandMap) throws Exception {
		ModelAndView mav = new ModelAndView("/user/signUp");
		return mav;
	}
	
	// 회원 아이디 중복 체크 메소드
	@RequestMapping(value="/user/checkUserID.do")
	@ResponseBody
	public Map<String, Object> checkUserID(CommandMap commandMap) throws Exception {
		Map<String, Object> map = userService.selectUserID(commandMap.getMap());
		return map;
	 }
	
	// 회원가입 메소드
	@RequestMapping(value="/user/signUp.do")
	@ResponseBody
	public Map<String, Object> signUp(CommandMap commandMap) throws Exception {
		userService.insertUserData(commandMap.getMap());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("msg", "정상적으로 회원가입되었습니다.");
		
		return map;
	}
	
	// 로그인 페이지 이동 메소드
	@RequestMapping(value="/user/openLogin.do")
	public ModelAndView openLogin(HttpServletRequest request, 
			HttpServletResponse response, 
			CommandMap commandMap) throws Exception {
		ModelAndView mav = new ModelAndView("/user/login");
		return mav;
	}
	
	// 로그인 메소드
	@RequestMapping(value="/user/login.do")
	@ResponseBody
	public Map<String, Object> login(HttpServletRequest request, 
			HttpServletResponse response, 
			CommandMap commandMap) throws Exception {
		
		Map<String, Object> loginInfo = userService.selectUserInfo(commandMap.getMap());
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// 로그인 정보가 있다면 로그인
		if(loginInfo == null)
		{
			resultMap.put("status", 1);
			resultMap.put("msg", "입력하신 정보가 잘못되었거나 존재하지 않는 정보입니다.");
		}
		else
		{
			// 로그인 세션 생성
			request.getSession().setAttribute("loginInfo", loginInfo);
			request.getSession().setMaxInactiveInterval(60 * 30);
			// 로그인 쿠키 생성 유무 판단
			if (commandMap.get("isUseCookie").equals("Y"))
			{
				// 쿠키를 생성하고 생성한 세션의 id를 쿠키에 저장한다.
				Cookie cookie = new Cookie("loginCookie", request.getSession().getId());
				// 쿠키를 찾을 경로를 컨텍스트 경로로 변경한다.
				cookie.setPath("/");
				// 7일로 유효기간을 설정한다.
				cookie.setMaxAge(60*60*24*7);
				// 쿠키를 reponse객체에 담는다.
				response.addCookie(cookie);
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("SESSIONID", request.getSession().getId());
				// currentTimeMillis()가 1/1000초 단위이므로 (* 1000) 한다.
				Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * (60*60*24*7)));
				map.put("SESSIONLIMIT", sessionLimit);
				map.put("loginInfo", loginInfo);
				userService.keepLogin(map);
			}
			resultMap.put("status", 0);
			resultMap.put("msg", "정상적으로 로그인되었습니다.");
		}
		
		return resultMap;
	}
	
	// 로그아웃 메소드
	@RequestMapping(value="/user/logout.do")
	public ModelAndView logout(HttpServletRequest request, 
			HttpServletResponse response, 
			CommandMap commandMap) throws Exception {
		
		HttpSession session = request.getSession();
		
		if (session.getAttribute("loginInfo") != null)
		{
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			
			// 쿠키 정보가 존재하는 경우
			if (loginCookie != null)
			{
				loginCookie.setPath("/");
				// 쿠키는 없앨 때 유효시간을 0으로 설정함으로써 없앨 수 있다.
				loginCookie.setMaxAge(0);
				response.addCookie(loginCookie);
				
				// 사용자 테이블에서도 유효기간을 현재시간으로 재설정한다.
				commandMap.put("SESSIONID", session.getId());
				Date sessionLimit = new Date(System.currentTimeMillis());
				commandMap.put("SESSIONLIMIT", sessionLimit);
				commandMap.put("loginInfo", session.getAttribute("loginInfo"));
				userService.keepLogin(commandMap.getMap());
			}
			// loginInfo 세션을 삭제한다.
			request.getSession().removeAttribute("loginInfo");
			// 세션 전체를 삭제한다.
			request.getSession().invalidate();
		}
		
		ModelAndView mav = new ModelAndView("redirect:/home/openHome.do");
		return mav;
	}
}
