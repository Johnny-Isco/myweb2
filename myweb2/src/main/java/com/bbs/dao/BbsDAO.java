package com.bbs.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.common.dao.AbstractDAO;

@Repository("bbsDAO")
public class BbsDAO extends AbstractDAO {

	// 전체 게시물의 레코드 갯수 구하는 쿼리 호출
	@SuppressWarnings("unchecked")
	public int boardListGetCount(String searchType, 
			String searchWord) throws Exception {
		
		Map<String, Object> tempMap = new HashMap<String, Object>();
		tempMap.put("SEARCH_TYPE", searchType);
		tempMap.put("SEARCH_WORD", searchWord);
		
		Map<String, Object> map = (Map<String, Object>)selectOne("bbs.boardListGetCount", tempMap);
		int idx = Integer.parseInt(map.get("COUNT(IDX)").toString());
		return idx;
	}
	
	// 게시물 목록 조회 쿼리 호출
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBoardList(Map<String, Object> map, 
			int start, 
			int end, 
			String searchType, 
			String searchWord) throws Exception {
		
		map.put("START", start);
		map.put("END", end);
		map.put("SEARCH_TYPE", searchType);
		map.put("SEARCH_WORD", searchWord);
		
		return (List<Map<String, Object>>)selectList("bbs.selectBoardList", map);
	}

	// 게시물 등록 쿼리 호출
	public void insertBoard(Map<String, Object> map) throws Exception {
		insert("bbs.insertBoard", map);
	}
	
	// 게시물의 첨부파일 등록 쿼리 호출
	public void insertFile(Map<String, Object> map) throws Exception {
		insert("bbs.insertFile", map);
	}

	// 게시물 조회 시 조회수 증가 쿼리 호출
	public void updateHitCnt(Map<String, Object> map) {
		update("bbs.updateHitCnt", map);
	}
	
	// 게시물 상세보기 쿼리 호출
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception {
		return (Map<String, Object>)selectOne("bbs.selectBoardDetail", map);
	}
	
	// 게시물 파일리스트 조회 쿼리 호출
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectFileList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>)selectList("bbs.selectFileList", map);
	}

	// 게시물 수정 쿼리 호출
	public void boardUpdate(Map<String, Object> map) throws Exception {
		update("bbs.boardUpdate", map);
	}
	
	// 첨부파일 삭제 쿼리 호출
	public void deleteFileList(Map<String, Object> map) throws Exception {
		update("bbs.deleteFileList", map);
	}
	
	// 첨부파일 업데이트 쿼리 호출
	public void updateFile(Map<String, Object> map) throws Exception {
		update("bbs.updateFile", map);
	}

	// 게시물 삭제 쿼리 호출
	public void boardDelete(Map<String, Object> map) throws Exception {
		update("bbs.boardDelete", map);
	}
}
