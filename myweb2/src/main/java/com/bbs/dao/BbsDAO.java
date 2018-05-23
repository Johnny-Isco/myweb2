package com.bbs.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.common.dao.AbstractDAO;

@Repository("bbsDAO")
public class BbsDAO extends AbstractDAO {

	// 게시물 목록 조회 쿼리 호출
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBoardList(Map<String, Object> commandMap) throws Exception {
		return (List<Map<String, Object>>)selectList("bbs.selectBoardList", commandMap);
	}

	// 게시물 등록 쿼리 호출
	public void insertBoard(Map<String, Object> map) throws Exception {
		insert("bbs.insertBoard", map);
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

	// 게시물 수정 쿼리 호출
	public void boardUpdate(Map<String, Object> map) throws Exception {
		update("bbs.boardUpdate", map);
	}

	// 게시물 삭제 쿼리 호출
	public void boardDelete(Map<String, Object> map) throws Exception {
		update("bbs.boardDelete", map);
	}
}
