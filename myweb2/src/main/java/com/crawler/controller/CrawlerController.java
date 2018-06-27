package com.crawler.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.common.util.WebCrawler;
import com.company.common.CommandMap;

@Controller
public class CrawlerController {

	Logger log = Logger.getLogger(this.getClass());
	
	// 날씨 페이지 이동 메소드
	@RequestMapping(value="/crawler/openWeather.do")
	public ModelAndView openWeather(CommandMap commandMap) throws Exception {
		WebCrawler crawler = new WebCrawler();
		ModelAndView mav = new ModelAndView("/crawler/weather");
		mav.addObject("weather_info", crawler.getWeatherInfo());
		
		return mav;
	}
	
	// 유럽 축구 리그표 페이지 이동 메소드
	@RequestMapping(value="/crawler/openSoccerLeagueTable.do")
	public ModelAndView openSoccerLeagueTable(CommandMap commandMap) throws Exception {
		ModelAndView mav = new ModelAndView("/crawler/soccerLeagueTable");

		return mav;
	}
	
	@RequestMapping(value="/crawler/eplTable.do")
	@ResponseBody
	public Map<String, Object> eplTable(HttpServletRequest req, 
			HttpServletResponse res) throws Exception {
		WebCrawler crawler = new WebCrawler();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("league_info", crawler.getPremireLeague());
		
		return map;
	}
	
	@RequestMapping(value="/crawler/laligaTable.do")
	@ResponseBody
	public Map<String, Object> laligaTable() throws Exception {
		WebCrawler crawler = new WebCrawler();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("league_info", crawler.getLaliga());
		
		return map;
	}
}
