package com.bbs.service;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.bbs.dao.BbsDAO;
import com.common.util.FileUtils;

@Service("bbsService")
public class BbsServiceImple implements BbsService {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Resource(name="bbsDAO")
	private BbsDAO bbsDAO;

	// 전체 게시물의 레코드 갯수 구하는 로직 호출
	@Override
	public int boardListGetCount(String searchType, 
			String searchWord) throws Exception {
		
		return bbsDAO.boardListGetCount(searchType, searchWord);
	}
	
	// 게시물 목록 조회 로직 호출
	@Override
	public List<Map<String, Object>> selectBoardList(Map<String, Object> map, 
			int start, 
			int end, 
			String searchType, 
			String searchWord) throws Exception {
		
		List<Map<String, Object>> list = bbsDAO.selectBoardList(map, start, end, searchType, searchWord);
		
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
		
		return list;
	}
	
	// 게시물 등록 로직 호출
	@Override
	public void insertBoard(Map<String, Object> map, 
			HttpServletRequest request) throws Exception {
		
		bbsDAO.insertBoard(map);
		
		List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(map, request);
		for(int i = 0, size = list.size(); i < size; i++)
		{
			bbsDAO.insertFile(list.get(i));
		}
	}
	
	// 게시물 상세보기 로직 호출
	@Override
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception {
		
		// 게시물 조회 시 조회 카운트 증가
		bbsDAO.updateHitCnt(map);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> tempMap = bbsDAO.selectBoardDetail(map);
		resultMap.put("map", tempMap);
		
		List<Map<String, Object>> list = bbsDAO.selectFileList(map);
		resultMap.put("list", list);
		
		return resultMap;
	}
	
	// 게시물 수정 로직 호출
	@Override
	public void boardUpdate(Map<String, Object> map, 
			HttpServletRequest request) throws Exception {
		
		bbsDAO.boardUpdate(map);
		
		bbsDAO.deleteFileList(map);
		
		List<Map<String, Object>> list = fileUtils.parseUpdateFileInfo(map, request);
		Map<String, Object> tempMap = null;
		
		for(int i = 0, size = list.size(); i < size; i++)
		{
			if(log.isDebugEnabled())
			{
				log.debug(list.get(i));
			}
			tempMap = list.get(i);
			
			if(tempMap.get("IS_NEW").equals("Y"))
			{
				bbsDAO.insertFile(tempMap);
			}
			else
			{
				bbsDAO.updateFile(tempMap);
			}
		}
	}
	
	// 게시물 삭제 로직 호출
	@Override
	public void boardDelete(Map<String, Object> map) throws Exception {
		bbsDAO.deleteFileList(map);
		bbsDAO.boardDelete(map);
	}
	
	// 댓글 목록 로직 호출
	@Override
	public List<Map<String, Object>> selectCommentList(Map<String, Object> map, int start, int end) throws Exception {
		return bbsDAO.selectCommentList(map, start, end);
	}
	
	// 전체 댓글의 레코드 갯수를 구하는 로직 호출
	@Override
	public int commentListGetCount(Map<String, Object> map) throws Exception {
		return bbsDAO.commentListGetCount(map);
	}
	
	// 댓글 등록 로직 호출
	@Override
	public void insertComment(Map<String, Object> map) throws Exception {
		bbsDAO.insertComment(map);
	}
	
	// 댓글 삭제 로직 호출
	@Override
	public void deleteComment(Map<String, Object> map) throws Exception {
		bbsDAO.deleteComment(map);
	}
}
