package com.user.service;

import java.util.Map;

public interface UserService {

	// 회원 아이디 중복 체크 서비스 호출
	Map<String, Object> selectUserID(Map<String, Object> map) throws Exception;

	// 회원가입 서비스 호출
	void insertUserData(Map<String, Object> map) throws Exception;

}
