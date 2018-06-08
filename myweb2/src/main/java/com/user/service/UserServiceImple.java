package com.user.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.company.common.CommandMap;
import com.user.dao.UserDAO;

@Service("userService")
public class UserServiceImple implements UserService {

	@Resource(name="userDAO")
	private UserDAO userDAO;
	
	// 회원 아이디 중복체크 로직 호출
	@Override
	public Map<String, Object> selectUserID(Map<String, Object> map) throws Exception {
		return userDAO.selectUserID(map);
	}
	
	// 회원가입 로직 호출
	@Override
	public void insertUserData(Map<String, Object> map) throws Exception {
		userDAO.insertUserData(map);
	}
	
	// 로그인 로직 호출
	@Override
	public Map<String, Object> selectUserInfo(Map<String, Object> map) throws Exception {
		return userDAO.selectUserInfo(map);
	}
	
	// 자동로그인 세션ID 저장 로직 호출
	@Override
	public void keepLogin(Map<String, Object> map) throws Exception {
		userDAO.keepLogin(map);
	}
	
	// 자동로그인 로직 호출
	@Override
	public HashMap<String, Object> checkUserInfoWithCookie(HashMap<String, Object> map) throws Exception {
		return userDAO.checkUserInfoWithCookie(map);
	}
}
