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
