package com.common.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.log4j.Logger;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

public class WebCrawler {

	Logger log = Logger.getLogger(this.getClass());
	
	// 프로세스 처리 시간 체크용 함수
	public static String getCurrentData() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");
		return sdf.format(new Date());
	}

	// 네이버 날씨 크롤링 메소드
	public Object getWeatherInfo() throws Exception {
		// 작업 시작 전 시간 기록
		log.debug(" Start Date : " + getCurrentData());
		
		// 가져올 HTTP 주소 세팅
		HttpPost http = new HttpPost("https://weather.naver.com/rgn/cityWetrMain.nhn");
		
		// 가져오기를 실행할 클라이언트 객체 생성하기
		HttpClient httpClient = HttpClientBuilder.create().build();
		
		// 실행 및 실행 데이터를 Response 객체에 담음
		HttpResponse response = httpClient.execute(http);
		
		// Response 받은 데이터 중 DOM 데이터를 가져와 Entity에 담음
		HttpEntity entity = response.getEntity();
		
		// Charset을 알아내기 위해 DOM의 컨텐트 타입을 가져와 담고 Charset을 가져옴
		ContentType contentType = ContentType.getOrDefault(entity);
		Charset charset = contentType.getCharset();
		
		// DOM 데이터를 한 줄씩 읽기 위해 BufferedReader에 담음 (inputStream / Buffered중 선택)
		BufferedReader br = new BufferedReader(new InputStreamReader(entity.getContent(), charset));
		
		// 가져온 DOM 데이터를 담기위해 StringBuffer 생성
		StringBuffer sb = new StringBuffer();
		
		// DOM 데이터 가져오기
		String line = "";
		while((line=br.readLine()) != null)
		{
			sb.append(line + "\n");
		}
		
		// 가져온 DOM을 로그로 출력
		log.debug(sb.toString());
		
		// Jsoup으로 파싱하기
		Document doc = Jsoup.parse(sb.toString());
		
		// DOM 영역에서 #content 아이디를 사용하는 태그를 선택 ex) <div id="content"> 자식노드들 </div>
		Elements el = doc.select("#content");
		
		// el 엘리먼트 내용 중 .today_map 클래스를 사용하는 영역을 삭제 
		el.select(".today_map").remove();
		
		// 작업 끝 시간 기록
		log.debug("End Date : " + getCurrentData());
		
		/*
		
		String url = "https://weather.naver.com/rgn/cityWetrMain.nhn";
		// Jsoup으로 파싱하기
		Document doc = Jsoup.connect(url).get();
		// 파싱한 DOM 객체에서 특정 엘리먼트 태그 담기 - css 선택자를 활용해서 원하는 엘리먼트를 가져올 수 있음
		Elements element = doc.select(".tbl_weather tbody>tr:nth-child(1)");
		// 가져온 엘리먼트를 배열로 나눠담음
		String[] str = element.text().split(" ");
		
		// 이미지를 가져오기
		Elements element2 = doc.select("weather tbody>tr:nth-child(1) img");

		if(log.isDebugEnabled())
		{
			log.debug(element);
			for(int i = 0; i < str.length; i++)
			{
				log.debug(str[i]);
			}
		}
		*/
		return el;
	}
}
