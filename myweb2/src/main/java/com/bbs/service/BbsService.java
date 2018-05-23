package com.bbs.service;

import java.util.List;
import java.util.Map;

public interface BbsService {

	// 게시물 목록 서비스 호출
	List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception;

	// 게시물 등록 서비스 호출
	void insertBoard(Map<String, Object> map) throws Exception;

	// 게시물 상세보기 서비스 호출
	Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception;

	// 게시물 수정 서비스 호출
	void boardUpdate(Map<String, Object> map) throws Exception;

	// 게시물 삭제 서비스 호출
	void boardDelete(Map<String, Object> map) throws Exception;

}
