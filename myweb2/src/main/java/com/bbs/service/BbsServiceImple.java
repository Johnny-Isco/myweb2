package com.bbs.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.bbs.dao.BbsDAO;

@Service("bbsService")
public class BbsServiceImple implements BbsService {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="bbsDAO")
	private BbsDAO bbsDAO;

	// 게시물 목록 조회 로직 호출
	@Override
	public List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception {
		return bbsDAO.selectBoardList(map);
	}
	
	// 게시물 등록 로직 호출
	@Override
	public void insertBoard(Map<String, Object> map) throws Exception {
		bbsDAO.insertBoard(map);		
	}
	
	// 게시물 상세보기 로직 호출
	@Override
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception {
		// 게시물 조회 시 조회 카운트 증가
		bbsDAO.updateHitCnt(map);
		
		Map<String, Object> resultMap = bbsDAO.selectBoardDetail(map);
		return resultMap;
	}
	
	// 게시물 수정 로직 호출
	@Override
	public void boardUpdate(Map<String, Object> map) throws Exception {
		bbsDAO.boardUpdate(map);
	}
	
	// 게시물 삭제 로직 호출
	@Override
	public void boardDelete(Map<String, Object> map) throws Exception {
		bbsDAO.boardDelete(map);
	}
}
