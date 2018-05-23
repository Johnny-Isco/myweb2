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
            <c:when test="${fn:length(list) > 0}">
                <c:forEach items="${list }" var="row">
                    <tr>
                        <td>${row.IDX }</td>
                        <td>
                        	<a href="#" name="title"><c:out value="${row.TITLE }" /></a>
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
	
	$("a[name='title']").unbind("click").click(function(e) {
		e.preventDefault();
		fn_openBoardDetail($(this));
	});
});

// 게시물 작성 화면 이동 함수
function fn_openBoardWrite() {
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("<c:url value='/bbs/openBoardWrite.do' />");
	comSubmit.submit();
}

// 게시물 상세보기 화면 이동 함수
function fn_openBoardDetail(obj) {
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("<c:url value='/bbs/openBoardDetail.do' />");
	comSubmit.addParam("IDX", obj.parent().find("#IDX").val());
	comSubmit.submit();
}
</script>
</body>
</html>
