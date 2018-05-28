package com.user.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

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
}
