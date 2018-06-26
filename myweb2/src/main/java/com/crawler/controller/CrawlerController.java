package com.crawler.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.common.util.WebCrawler;
import com.company.common.CommandMap;

@Controller
public class CrawlerController {

	Logger log = Logger.getLogger(this.getClass());
	
	@RequestMapping(value="/crawler/openWeather.do")
	public ModelAndView openWeather(CommandMap commandMap) throws Exception {
		ModelAndView mav = new ModelAndView("/crawler/weather");
		WebCrawler crawler = new WebCrawler();
		
		mav.addObject("weather_info", crawler.getWeatherInfo());
		
		return mav;
	}
}
