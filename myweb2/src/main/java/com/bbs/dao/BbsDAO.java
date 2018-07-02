package com.bbs.dao;

import java.util.Calendar;
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
		
		List<Map<String, Object>> list = selectList("bbs.selectBoardList", map);
		
		// 현재 시스템의 날짜 정보를 가져온다.
		Calendar today = Calendar.getInstance();
		
		// 년도
		String this_year = Integer.toString(today.get(Calendar.YEAR));
		// 월(0~11, 0: 1월)
		// 월에 대한 값이 0월~11월이므로 + 1을 더하여 1월~12월로 값을 조정한다.
		String this_month = Integer.toString((today.get(Calendar.MONTH) + 1));
		// 월데이터의 자릿수가 두자릿수보다 작으면 앞에 0을 붙여서 표현한다. ex) 1월 => 01월
		// 이는 DB에서 조회한 월 데이터가 01, 02로 두자릿수로 표현되기 때문이다.
		this_month = this_month.length() < 2 ? "0" + this_month : this_month;
		// 이 달의 일
		String this_day = Integer.toString(today.get(Calendar.DATE));
		this_day = this_day.length() < 2 ? "0" + this_day : this_day;
		
		for (int i = 0; i < list.size(); i++)
		{
			// DB년도
			String db_year = list.get(i).get("CREA_DTM").toString().substring(0, 4);
			// DB월
			String db_month = list.get(i).get("CREA_DTM").toString().substring(5, 7);
			// DB일
			String db_day = list.get(i).get("CREA_DTM").toString().substring(8, 10);
			// DB시간
			String db_time = list.get(i).get("CREA_DTM").toString().substring(11);
			
			
			log.debug(db_day);
			log.debug(this_day);
			
			// 현재 날짜와 게시글이 DB에 등록된 날짜가 동일하다면 게시글이 등록된 시간만 표현한다.
			if (db_year.equals(this_year) && db_month.equals(this_month) && db_day.equals(this_day))
			{
				list.get(i).put("CREA_DTM", db_time);
			}
			// 현재 날짜와 게시글이 DB에 등록된 날짜가 동일하지 않다면 게시글이 등록된 날짜를 표현한다.
			else
			{
				list.get(i).put("CREA_DTM", db_year + "-" + db_month + "-" + db_day);
			}
		}
		
		
		log.debug(list);
		
		return list;
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

	// 댓글 목록 쿼리 호출
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCommentList(Map<String, Object> map, 
			int start, 
			int end) throws Exception {
		map.put("START", start);
		map.put("END", end);
		
		return (List<Map<String, Object>>)selectList("bbs.selectCommentList", map);
	}

	// 전체 댓글의 레코드 갯수를 구하는 쿼리 호출
	public int commentListGetCount(Map<String, Object> map) throws Exception {
		return Integer.parseInt(selectOne("bbs.commentListGetCount", map).toString());
	}
	
	// 댓글 등록 쿼리 호출
	public void insertComment(Map<String, Object> map) throws Exception {
		insert("bbs.insertComment", map);
	}

	// 댓글 삭제 쿼리 호출
	public void deleteComment(Map<String, Object> map) throws Exception {
		delete("bbs.deleteComment", map);
	}
}
