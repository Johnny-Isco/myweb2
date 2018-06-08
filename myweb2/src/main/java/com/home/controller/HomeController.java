package com.home.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.company.common.CommandMap;

@Controller
public class HomeController {
	Logger log = Logger.getLogger(this.getClass());
	
	// 비포어 홈 화면 이동 메소드 index.jsp forwarding -> beforeMain.do -> beforeHome.do
	@RequestMapping(value="/home/beforeMain.do")
	public ModelAndView beforeHome(CommandMap commandMap) throws Exception {
		ModelAndView mav = new ModelAndView("/home/beforeHome");
		
		return mav;
	}
	// 홈 화면 이동 메소드
	@RequestMapping(value="/home/openHome.do")
	public ModelAndView home(CommandMap commandMap) throws Exception {
		ModelAndView mav = new ModelAndView("/home/home");
		
		return mav;
	}
}
