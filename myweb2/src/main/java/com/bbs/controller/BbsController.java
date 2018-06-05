package com.bbs.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bbs.page.BbsPaging;
import com.bbs.service.BbsService;
import com.company.common.CommandMap;

@Controller
public class BbsController {

	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="bbsService")
	private BbsService bbsService;
	
	// 게시물 목록 이동 메소드
	@RequestMapping(value="/bbs/openBoardList.do")
	public ModelAndView openBoardList(CommandMap commandMap,
			@RequestParam(value="curPage", defaultValue="1") int curPage, 
			@RequestParam(value="searchType", defaultValue="TITLE")String searchType, 
			@RequestParam(value="searchWord", defaultValue="")String searchWord) throws Exception {
		
		// 전체 게시물 레코드의 갯수
		int count = bbsService.boardListGetCount(searchType, searchWord);
		
		BbsPaging paging = new BbsPaging(count, curPage);
		// 현재 페이지 번호
		int start = paging.getPageBegin();
		// 현재 페이지의 끝번호
		int end = paging.getPageEnd();
		
		List<Map<String, Object>> list = bbsService.selectBoardList(commandMap.getMap(), start, end, searchType, searchWord);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("count", count);
		map.put("searchType", searchType);
		map.put("searchWord", searchWord);
		map.put("paging", paging);
		
		ModelAndView mav = new ModelAndView("/bbs/boardList");
		mav.addObject("map", map);
		
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
	public ModelAndView insertBoard(CommandMap commandMap, 
			HttpServletRequest request) throws Exception {
		
		bbsService.insertBoard(commandMap.getMap(), request);
		
		ModelAndView mav = new ModelAndView("redirect:/bbs/openBoardList.do");
		return mav;
	}
	
	// 게시물 상세보기 화면 이동 메소드
	@RequestMapping(value="/bbs/openBoardDetail.do")
	public ModelAndView openBoardDetail(CommandMap commandMap, 
			@RequestParam(value="curPage", defaultValue="1")int curPage, 
			@RequestParam(value="searchType", defaultValue="TITLE")String searchType, 
			@RequestParam(value="searchWord", defaultValue="")String searchWord) throws Exception {
		
		Map<String, Object> map = bbsService.selectBoardDetail(commandMap.getMap());
		
		ModelAndView mav = new ModelAndView("/bbs/boardDetail");
		mav.addObject("map", map.get("map"));
		mav.addObject("list", map.get("list"));
		mav.addObject("curPage", curPage);
		mav.addObject("searchType", searchType);
		mav.addObject("searchWord", searchWord);
		
		return mav;
	}
	
	// 게시물 수정 화면 이동 메소드
	@RequestMapping(value="/bbs/openBoardUpdate.do")
	public ModelAndView openBoardUpdate(CommandMap commandMap) throws Exception {
		
		Map<String, Object> map = bbsService.selectBoardDetail(commandMap.getMap());
		
		ModelAndView mav = new ModelAndView("/bbs/boardUpdate");
		mav.addObject("map", map.get("map"));
		mav.addObject("list", map.get("list"));
		
		return mav;
	}
	
	// 게시물 수정 메소드
	@RequestMapping(value="/bbs/boardUpdate.do")
	public ModelAndView boardUpdate(CommandMap commandMap, 
			HttpServletRequest request) throws Exception {
		
		bbsService.boardUpdate(commandMap.getMap(), request);
		
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
	
	// 댓글 목록 메소드
	@RequestMapping(value="/bbs/viewComment.do")
	@ResponseBody
	public HashMap<String, Object> viewComment(CommandMap commandMap, 
			@RequestParam(value="curPage", defaultValue="1")int curPage) throws Exception {
		
		// 전체 댓글의 레코드 갯수
		int count = bbsService.commentListGetCount(commandMap.getMap());
		
		BbsPaging paging = new BbsPaging(count, curPage);
		
		// 현재 페이지 번호
		int start = paging.getPageBegin();
		// 현재 페이지 끝 번호
		int end = paging.getPageEnd();
		
		List<Map<String, Object>> list = bbsService.selectCommentList(commandMap.getMap(), start, end);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("count", count);
		map.put("paging", paging);
		
		return map;
	}
	
	// 댓글 등록 메소드
	@RequestMapping(value="/bbs/insertComment.do")
	@ResponseBody
	public void insertComment(CommandMap commandMap) throws Exception {
		
		bbsService.insertComment(commandMap.getMap());
	}
}
