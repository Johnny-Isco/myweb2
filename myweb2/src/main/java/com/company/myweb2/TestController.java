package com.company.myweb2;

import java.util.Iterator;
import java.util.Map.Entry;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.company.common.CommandMap;

@Controller
public class TestController {

	Logger log = Logger.getLogger(this.getClass());
	
	@RequestMapping(value="/test/logTest.do")
	public ModelAndView logTest() throws Exception {
		ModelAndView mav = new ModelAndView();
		if (log.isDebugEnabled())
		{
			log.debug("인터셉터 테스트");
		}
		
		return mav;
	}
	
	@RequestMapping(value="/test/resolverTest.do")
	public ModelAndView resolverTest(CommandMap commandMap) throws Exception {
		
		if(commandMap.isEmpty() == false)
		{
			Iterator<Entry<String, Object>> iterator = commandMap.getMap().entrySet().iterator();
			Entry<String, Object> entry = null;
			while(iterator.hasNext())
			{
				entry = iterator.next();
				if(log.isDebugEnabled())
				{
					log.debug("key : " + entry.getKey() + " / value : " + entry.getValue());
				}
			}
		}
		
		ModelAndView mav = new ModelAndView("");
		
		return mav;
	}
}
