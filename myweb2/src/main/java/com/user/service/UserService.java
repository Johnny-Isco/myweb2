package com.user.service;

import java.util.HashMap;
import java.util.Map;

public interface UserService {

	// 회원 아이디 중복 체크 서비스 호출
	Map<String, Object> selectUserID(Map<String, Object> map) throws Exception;

	// 회원가입 서비스 호출
	void insertUserData(Map<String, Object> map) throws Exception;

	// 로그인 서비스 호출
	Map<String, Object> selectUserInfo(Map<String, Object> map) throws Exception;

	// 자동로그인 세션ID 저장 서비스 호출
	void keepLogin(Map<String, Object> map) throws Exception;
	
	// 자동로그인 서비스 호출
	HashMap<String, Object> checkUserInfoWithCookie(HashMap<String, Object> map) throws Exception;
}
