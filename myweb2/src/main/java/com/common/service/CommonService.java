package com.common.service;

import java.util.Map;

public interface CommonService {

	// 첨부파일 다운로드 대상 정보 조회 서비스 호출
	Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception;
}
