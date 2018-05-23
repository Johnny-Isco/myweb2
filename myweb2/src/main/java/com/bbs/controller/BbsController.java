package com.bbs.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.bbs.service.BbsService;
import com.company.common.CommandMap;

@Controller
public class BbsController {

	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="bbsService")
	private BbsService bbsService;
	
	// 게시물 목록 이동 메소드
	@RequestMapping(value="/bbs/openBoardList.do")
	public ModelAndView openBoardList(CommandMap commandMap) throws Exception {
		List<Map<String, Object>> list = bbsService.selectBoardList(commandMap.getMap());
		ModelAndView mav = new ModelAndView("/bbs/boardList");
		mav.addObject("list", list);
		
		return mav;
	}
	
	// 게시물 등록 화면 이동 메소드
	@RequestMapping(value="/bbs/openBoardWrite.do")
	public ModelAndView openBoardWrite(CommandMap commandMap) throws Exception {
		ModelAndView mav = new ModelAndView("/bbs/boardWrite");
		return mav;
	}
	
	// 게시물 등록 메소드
	@RequestMapping(value="/bbs/insertBoard.do")
	public ModelAndView insertBoard(CommandMap commandMap) throws Exception {
		bbsService.insertBoard(commandMap.getMap());
		
		ModelAndView mav = new ModelAndView("redirect:/bbs/openBoardList.do");
		return mav;
	}
	
	// 게시물 상세보기 화면 이동 메소드
	@RequestMapping(value="/bbs/openBoardDetail.do")
	public ModelAndView openBoardDetail(CommandMap commandMap) throws Exception {
		Map<String, Object> map = bbsService.selectBoardDetail(commandMap.getMap());
		
		ModelAndView mav = new ModelAndView("/bbs/boardDetail");
		mav.addObject("map", map);
		
		return mav;
	}
	
	// 게시물 수정 화면 이동 메소드
	@RequestMapping(value="/bbs/openBoardUpdate.do")
	public ModelAndView openBoardUpdate(CommandMap commandMap) throws Exception {
		Map<String, Object> map = bbsService.selectBoardDetail(commandMap.getMap());
		
		ModelAndView mav = new ModelAndView("/bbs/boardUpdate");
		mav.addObject("map", map);
		
		return mav;
	}
	
	// 게시물 수정 메소드
	@RequestMapping(value="/bbs/boardUpdate.do")
	public ModelAndView boardUpdate(CommandMap commandMap) throws Exception {
		bbsService.boardUpdate(commandMap.getMap());
		
		ModelAndView mav = new ModelAndView("redirect:/bbs/openBoardDetail.do");
		mav.addObject("IDX", commandMap.get("IDX"));
		
		return mav;
	}
	
	// 게시물 삭제 메소드
	@RequestMapping(value="/bbs/boardDelete.do")
	public ModelAndView boardDelete(CommandMap commandMap) throws Exception {
		bbsService.boardDelete(commandMap.getMap());
		
		ModelAndView mav = new ModelAndView("redirect:/bbs/openBoardList.do");
		return mav;
	}
	
}
