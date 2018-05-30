<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/include/include-header.jsp" %>
</head>
<body>
<h2>게시판 목록</h2>
<a href="#" class="btn" id="write1">글쓰기</a>
<p>${map.count }개의 게시물이 있습니다.</p>
<table style="board_list">
    <colgroup>
        <col width="10%"/>
        <col width="*"/>
        <col width="15%"/>
        <col width="20%"/>
    </colgroup>
    <thead>
        <tr>
            <th scope="col">글번호</th>
            <th scope="col">제목</th>
            <th scope="col">조회수</th>
            <th scope="col">작성일</th>
        </tr>
    </thead>
    <tbody>
        <c:choose>
            <c:when test="${fn:length(map.list) > 0}">
                <c:forEach items="${map.list }" var="row">
                    <tr>
                        <td>${row.IDX }</td>
                        <td>
                        	<a href="javascript:fn_openBoardDetail('${row.IDX }', '${map.paging.curPage }')" name="title"><c:out value="${row.TITLE }" /></a>
                        	<input type="hidden" id="IDX" name="IDX" value="${row.IDX }" />
                        </td>
                        <td>${row.HIT_CNT }</td>
                        <td>${row.CREA_DTM }</td>
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
        	<td colspan="4">
        		<!-- 처음 페이지로 이동 : 현재 페이지가 1보다 크면 [처음]을 출력 -->
        		<c:if test="${map.paging.curBlock > 1 }">
        			<a href="javascript:fn_list('1')">[처음]</a>
        		</c:if>
        		<!-- 이전 페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]을 출력 -->
        		<c:if test="${map.paging.curBlock > 1 }">
        			<a href="javascript:fn_list('${map.paging.prevPage }')">[이전]</a>
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
        		<c:if test="${map.paging.curBlock < map.paging.totalBlock }">
        			<a href="javascript:fn_list('${map.paging.nextPage }')">[다음]</a>
        		</c:if>
        		<!-- 끝 페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]을 출력 -->
        		<c:if test="${map.paging.curPage <= map.paging.totalPage }">
        			<a href="javascript:fn_list('${map.paging.totalPage }')">[끝]</a>
        		</c:if>
        	</td>
        </tr>
    </tbody>
</table>

<br>
<a href="#" class="btn" id="write2">글쓰기</a>

<%@ include file="/WEB-INF/include/include-body.jsp" %>

<script>
$(document).ready(function(e) {
	$("#write1, #write2").unbind("click").click(function(e) {
		e.preventDefault();
		fn_openBoardWrite();
	});
});

// 게시물 작성 화면 이동 함수
function fn_openBoardWrite() {
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("<c:url value='/bbs/openBoardWrite.do' />");
	comSubmit.submit();
}

// 게시물 상세보기 화면 이동 함수
function fn_openBoardDetail(idx, curPage) {
	window.location.href="/bbs/openBoardDetail.do?IDX=" + idx + "&curPage=" + curPage;
}

// 페이징 이동 함수
function fn_list(page) {
	window.location.href="/bbs/openBoardList.do?curPage=" + page;
}

</script>
</body>
</html>
