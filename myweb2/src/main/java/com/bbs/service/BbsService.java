package com.bbs.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface BbsService {

	// 전체 게시물의 레코드 갯수를 구하는 서비스 호출
	int boardListGetCount(String searchType, 
			String searchWord) throws Exception;
		
	// 게시물 목록 서비스 호출
	List<Map<String, Object>> selectBoardList(Map<String, Object> map, 
			int start, 
			int end,
			String searchType, 
			String searchWord) throws Exception;

	// 게시물 등록 서비스 호출
	void insertBoard(Map<String, Object> map, 
			HttpServletRequest request) throws Exception;

	// 게시물 상세보기 서비스 호출
	Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception;

	// 게시물 수정 서비스 호출
	void boardUpdate(Map<String, Object> map, 
			HttpServletRequest request) throws Exception;

	// 게시물 삭제 서비스 호출
	void boardDelete(Map<String, Object> map) throws Exception;

	// 댓글 목록 서비스 호출
	List<Map<String, Object>> selectCommentList(Map<String, Object> map) throws Exception;
	
	// 댓글 등록 서비스 호출
	void insertComment(Map<String, Object> map) throws Exception;

}
