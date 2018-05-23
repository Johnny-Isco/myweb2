package com.common.util;

import java.util.UUID;

public class CommonUtils {

	// 서버로 업로드 되는 첨부파일의 이름을 랜덤한 32글자의 문자열로 변경하는 메소드
	public static String getRandomString() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
}
