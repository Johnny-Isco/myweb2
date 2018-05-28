package com.home.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.company.common.CommandMap;

@Controller
public class HomeController {
	Logger log = Logger.getLogger(this.getClass());
	
	@RequestMapping(value="/home/openHome.do")
	public ModelAndView home(CommandMap commandMap) throws Exception {
		ModelAndView mav = new ModelAndView("/home/home");
		
		return mav;
	}
}
