package com.user.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.common.dao.AbstractDAO;

@Repository("userDAO")
public class UserDAO extends AbstractDAO {

	// 회원 아이디 중복 체크 쿼리 호출
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectUserID(Map<String, Object> map) throws Exception {
		//int result = Integer.valueOf(String.valueOf(resultMap.get("RESULT")));
		return (Map<String, Object>)selectOne("user.selectUserID", map);
	}

	// 회원가입 쿼리 호출
	public void insertUserData(Map<String, Object> map) throws Exception {
		insert("user.insertUserData", map);
	}

	
}
