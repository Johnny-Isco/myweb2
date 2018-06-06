<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/include/include-header.jsp" %>
<style>
.wrapper {margin: 0 auto;}
</style>
</head>
<body>
<%@ include file="/WEB-INF/include/include-title.jsp" %>
<div class="container">
	<div class="wrapper">
		<h2>게시판 목록</h2>
		<form class="form-inline">
			<div class="form-group">
				<select name="searchType" id="select_searchType" class="form-control">
					<c:choose>
						<c:when test="${map.searchType == 'TITLE' }">
							<option value="TITLE" selected="selected">제목</option>
							<option value="NO">글 번호</option>
						</c:when>
						<c:otherwise>
							<option value="TITLE">제목</option>
							<option value="NO" selected="selected">번호</option>
						</c:otherwise>
					</c:choose>
				</select>
				<input type="text" name="searchWord" id="searchWord" value="${map.searchWord }" placeholder="검색어를 입력해주세요." class="form-control">
				<button class="btn btn-default" id="searchBtn">검색</button>
			</div>
		</form>
		<p>${map.count }개의 게시물이 있습니다.</p>
		<table class="table">
		    <colgroup>
		        <col width="10%">
		        <col width="*">
		        <col width="10%">
		        <col width="20%">
		        <col width="15%">
		    </colgroup>
		    <thead>
		        <tr>
		            <th scope="col">글번호</th>
		            <th scope="col">제목</th>
		            <th scope="col">작성자</th>
		            <th scope="col">작성일</th>
		            <th scope="col">조회수</th>
		        </tr>
		    </thead>
		    <tbody>
		        <c:choose>
		            <c:when test="${fn:length(map.list) > 0}">
		                <c:forEach items="${map.list }" var="row">
		                    <tr>
		                        <td>${row.IDX }</td>
		                        <td style="text-align: left;">
		                        	<a href="javascript:fn_openBoardDetail('${row.IDX }', '${map.paging.curPage }', '${map.saerchType }', '${map.searchWord }')" name="title"><c:out value="${row.TITLE }" /></a>
		                        	<input type="hidden" id="IDX" name="IDX" value="${row.IDX }" />
		                        </td>
		                        <td>${row.CREA_ID }</td>
		                        <td>${row.CREA_DTM }</td>
		                        <td>${row.HIT_CNT }</td>
		                    </tr>
		                </c:forEach>
		            </c:when>
		            <c:otherwise>
		                <tr>
		                    <td colspan="4">조회된 결과가 없습니다.</td>
		                </tr>
		            </c:otherwise>
		        </c:choose>
		        <tr>
		        	<td colspan="4" style="text-align: center;">
		        		<!-- 처음 페이지로 이동 : 현재 페이지가 1보다 크면 [처음]을 출력 -->
		        		<c:if test="${map.paging.curPage > 1 }">
		        			<a href="javascript:fn_list('1')" class="btn btn-xs btn-default">처음</a>
		        		</c:if>
		        		<!-- 이전 페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]을 출력 -->
		        		<c:if test="${map.paging.curBlock > 1 }">
		        			<a href="javascript:fn_list('${map.paging.prevPage }')" class="btn btn-xs btn-default">이전</a>
		        		</c:if>
		        		<!-- 하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
		        		<c:forEach var="num" begin="${map.paging.blockBegin }" end="${map.paging.blockEnd }">
		        			<!-- 현재 페이지이면 하이퍼링크 제거 -->
		        			<c:choose>
		        				<c:when test="${num == map.paging.curPage }">
		        					<span style="color: red">${num }</span>&nbsp;
		        				</c:when>
		        				<c:otherwise>
		        					<a href="javascript:fn_list('${num }')">${num }</a>&nbsp;
		        				</c:otherwise>
		        			</c:choose>
		        		</c:forEach>
		        		<!-- 다음 페이지 블록으로 이동 : 현재 페이지 블록이 전체 페이지 블록보다 작거나 같으면 [다음]을 출력 -->
		        		<c:if test="${map.paging.curBlock <= map.paging.totalBlock }">
		        			<a href="javascript:fn_list('${map.paging.nextPage }')" class="btn btn-xs btn-default">다음</a>
		        		</c:if>
		        		<!-- 끝 페이지로 이동 : 현재 페이지가 전체 페이지보다 작으면 [끝]을 출력 -->
		        		<c:if test="${map.paging.curPage < map.paging.totalPage }">
		        			<a href="javascript:fn_list('${map.paging.totalPage }')" class="btn btn-xs btn-default">끝</a>
		        		</c:if>
		        	</td>
		        	<td style="text-align: right">
		        		<button class="btn btn-primary" id="write">글쓰기</button>
		        	</td>
		        </tr>
		    </tbody>
		</table>
	</div>
</div>

<%@ include file="/WEB-INF/include/include-body.jsp" %>

<script>
$(document).ready(function(e) {
	$("#write").unbind("click").click(function(e) {
		e.preventDefault();
		fn_openBoardWrite();
	});
	
	$("#searchBtn").unbind("click").click(function(e) {
		e.preventDefault();
		fn_searchList();
	});
});

// 게시물 작성 화면 이동 함수
function fn_openBoardWrite() {
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("<c:url value='/bbs/openBoardWrite.do' />");
	comSubmit.submit();
}

// 게시물 상세보기 화면 이동 함수
function fn_openBoardDetail(idx, curPage, searchType, searchWord) {
	window.location.href="/bbs/openBoardDetail.do?IDX=" + idx 
			+ "&curPage=" + curPage 
			+ "&searchType=" + searchType 
			+ "&searchWord=" + searchWord;
}

// 페이징 이동 함수
function fn_list(page) {
	var searchType = $("#select_searchType option:selected").val();
	var searchWord = $("#searchWord").val();
	
	window.location.href="/bbs/openBoardList.do?curPage=" + page 
			+ "&searchType=" + searchType 
			+ "&searchWord=" + searchWord;
}

// 검색 함수
function fn_searchList() {
	var searchType = $("#select_searchType option:selected").val();
	var searchWord = $("#searchWord").val();
	
	// 검색버튼을 클릭할 때 마다 첫번째 페이지를 보여주기 위해 curPage를 1로 고정한다.
	window.location.href="/bbs/openBoardList.do?curPage=1"
			+ "&searchType=" + searchType 
			+ "&searchWord=" + searchWord;
}

</script>
</body>
</html>
