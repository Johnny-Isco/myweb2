package com.user.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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
	public ModelAndView openLogin(HttpServletRequest request, HttpServletResponse response, 
			CommandMap commandMap) throws Exception {
		ModelAndView mav = new ModelAndView("/user/login");
		return mav;
	}
	
	// 로그인 메소드
	@RequestMapping(value="/user/login.do")
	@ResponseBody
	public Map<String, Object> login(HttpServletRequest request, HttpServletResponse response, 
			CommandMap commandMap) throws Exception {
		Map<String, Object> map = userService.selectUserInfo(commandMap.getMap());
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// 로그인 정보가 있다면 로그인
		if(map == null)
		{
			resultMap.put("status", 1);
			resultMap.put("msg", "입력하신 정보가 잘못되었거나 존재하지 않는 정보입니다.");
		}
		else
		{
			request.getSession().setAttribute("loginInfo", map);
			request.getSession().setMaxInactiveInterval(60 * 30);
			resultMap.put("status", 0);
			resultMap.put("msg", "정상적으로 로그인되었습니다.");
		}
		
		return resultMap;
	}
	
	// 로그아웃 메소드
	@RequestMapping(value="/user/logout.do")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response, 
			CommandMap commandMap) throws Exception {
		request.getSession().removeAttribute("loginInfo");
		ModelAndView mav = new ModelAndView("redirect:/home/openHome.do");
		return mav;
	}
}
