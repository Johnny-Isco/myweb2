package com.common.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository("commonDAO")
public class CommonDAO extends AbstractDAO{

	// 첨부파일 다운로드 대상 정보 조회 쿼리 호출
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectFileInfo(Map<String, Object> map) {
		return (Map<String, Object>)selectOne("common.selectFileInfo", map);
	}

}
