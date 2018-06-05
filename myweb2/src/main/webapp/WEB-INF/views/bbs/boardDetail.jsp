<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/include/include-header.jsp" %>
</head>
<body>
<table class="board_view">
	<colgroup>
		<col width="15%" />
		<col width="35%" />
		<col width="15%" />
		<col width="35%" />
	</colgroup>
	
	<caption>게시글 상세</caption>
	
	<tbody>
		<tr>
			<th scope="row">글번호</th>
			<td>${map.IDX }</td>
			<th scope="row">조회수</th>
			<td>${map.HIT_CNT }</td>
		</tr>
		<tr>
			<th scope="row">작성자</th>
			<td>${map.CREA_ID }</td>
			<th scope="row">작성시간</th>
			<td>${map.CREA_DTM }</td>
		</tr>
		<tr>
			<th scope="row">제목</th>
			<td colspan="3"><c:out value="${map.TITLE }" />	</td>
		</tr>
		<tr>
			<td colspan="4"><c:out value="${map.CONTENTS }" /></td>
		</tr>
		<tr>
			<th scope="row">첨부파일</th>
			<td colspan="3">
				<c:forEach var="row" items="${list }">
					<p>
						<input type="hidden" id="IDX" value="${row.IDX }" />
						<a href="#" name="file"><c:out value="${row.ORIGINAL_FILE_NAME }" /></a>
						(${row.FILE_SIZE }kb)
					</p>
				</c:forEach>
			</td>
		</tr>
	</tbody>
</table>

<a href="#" class="btn" id="list">목록으로</a>
<a href="#" class="btn" id="update">수정하기</a>
<br>

<table class="board_view" id="comment_table">
	<caption>댓글</caption>
	<colgroup>
		<col width="15%" />
		<col width="10%" />
		<col width="20%" />
		<col width="50%" />
	</colgroup>
	<thead>
		<tr>
			<th>댓글번호</th>
			<th>게시글 아이디</th>
			<th>사용자 아이디</th>
			<th>댓글내용</th>
		</tr>
	</thead>
	<tbody id="reply_list">
		<tr>
			<td colspan="4" id="td_page" style="text-align: right;"></td>
		</tr>
	</tbody>
</table>
<br>

<div style="width: 660px;">
	<p>
		<textarea rows="10" cols="90" name="DESCRIPTION" id="DESCRIPTION"></textarea>
	</p>
	<p style="text-align: right;">
		<a href="#" class="btn" id="commentBtn">등록</a>
	</p>
</div>

<%@ include file="/WEB-INF/include/include-body.jsp" %>

<script>
$(document).ready(function(e) {
	$("#list").unbind("click").click(function(e) {
		e.preventDefault();
		fn_openBoardList();
	});
	
	$("#update").unbind("click").click(function(e) {
		e.preventDefault();
		fn_openBoardUpdate();
	});
	
	$("a[name='file']").unbind("click").click(function(e) {
		e.preventDefault();
		fn_downloadFile($(this));
	});
	
	$("#commentBtn").unbind("click").click(function(e) {
		e.preventDefault();
		fn_insertComment();
	})
	
	if($("#reply_list tr").next().length < 1)
	{
		fn_viewComment(1);
	}
});

// 게시물 목록 이동 함수
function fn_openBoardList() {
	window.location.href="/bbs/openBoardList.do?curPage=" + "${curPage}" 
			+ "&searchType=" + "${searchType}" 
			+ "&searchWord=" + "${searchWord}";
}

// 게시물 수정 화면 이동 함수
function fn_openBoardUpdate() {
	var idx = "${map.IDX}";
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("<c:url value='/bbs/openBoardUpdate.do' />");
	comSubmit.addParam("IDX", idx);
	comSubmit.submit();
}

// 첨부파일 다운로드 함수
function fn_downloadFile(obj) {
	var idx = obj.parent().find("#IDX").val();
	var comSubmit = new ComSubmit();
	var formCount = $("#commonForm");
	comSubmit.setUrl("<c:url value='/common/downloadFile.do' />");
	comSubmit.addParam("IDX", idx);
	comSubmit.submit();
	
	/*
	$.ajax({
		type	: "POST",
		url		: "/common/downloadFile.do",
		data	: {"IDX": idx},
		success	: function(result) {
			alert(result.msg);
			
		},
		error	: function(XHR, textStatus, error) {
			alert(textStatus + " : " +error);
		}
	});
	*/
	/*
	 - 파일 다운로드 후 Form태그의  addParam 태그 삭제
	 1. 파일 다운로드 후 Form태그의 addParam 태그를 삭제하지 않을 경우 다음 파일을 다운로드 받을 때 
	 이전에 받은 파일이 다운로드 되는 이슈가 발생함.
	*/
	if (formCount.length > 0)
	{
	 formCount.children().remove();
	}
}

// 댓글 작성 함수
function fn_insertComment() {
	if("${loginInfo.ID}".length < 1)
	{
		alert("로그인 후 이용해주세요.");
	}
	else if($("#DESCRIPTION").val().length < 1)
	{
		alert("댓글을 작성하고 시도해주세요.");
	}
	else
	{
		$.ajax({
			type	: "POST", 
			url		: "/bbs/insertComment.do",
			data	: {
				IDX			: "${map.IDX}",
				USER_ID		: "${loginInfo.ID}",
				DESCRIPTION	: $("#DESCRIPTION").val()
			},
			error	: function(request, status, error) {
				alert("서버가 응답하지 않습니다." + "\n" + "다시 시도해주시기 바랍니다." + "\n" 
						+ "code: " + request.status + "\n" 
						+ "message : " + request.responseText + "\n" 
						+ "error: " + error);
			},
			success	: function(result) {
				$("#DESCRIPTION").val("");
				// 현재 보고있는 댓글 페이지 번호를 인자로 넘김
				fn_viewComment($("#reply_list").find("span").text());
			}
		});
	}
}

// 댓글 리스트 함수
function fn_viewComment(curPage) {
	$.ajax({
		type	: "POST",
		url		: "/bbs/viewComment.do",
		dataType: "json",
		data	: {
			IDX		: "${map.IDX}", 
			curPage	: curPage < 1 ? 1 : curPage
		},
		error	: function(request, status, error) {
			alert("서버가 응답하지 않습니다." + "\n" + "다시 시도해주시기 바랍니다." + "\n" 
					+ "code: " + request.status + "\n" 
					+ "message : " + request.responseText + "\n" 
					+ "error: " + error);
		},
		success	: function(result) {
			// 댓글 카운팅, 페이징, 댓글 전부 삭제
			$("#comment_table").find("caption").children().remove();
			$("#td_page").children().remove();
			$("#reply_list tr").next().remove();
			
			// 댓글 카운팅 표기
			$("#comment_table").find("caption").text("댓글 : " + result.count);
			
			// 페이징
			var page = "";
			if (result.paging.curPage > 1)
			{
				page += "<a href='javascript:fn_viewComment(1)'>[처음]</a>";
			}
			if (result.paging.curBlock > 1)
			{
				page += "<a href='javascript:fn_viewComment(" + result.paging.prevPage + ")'>[이전]</a>";
			}
			
			// 번호 페이징
			for (var i = result.paging.blockBegin; i <= result.paging.blockEnd; i++)
			{
				if (i == result.paging.curPage)
				{
					page += "<span style='color: red'>" + i + "</span>";
				}
				else
				{
					page += "<a href='javascript:fn_viewComment(" + i + ")'>" + i + "</a>";
				}
			}
			
			if (result.paging.curBlock <= result.paging.totalBlock)
			{
				page += "<a href='javascript:fn_viewComment(" + result.paging.nextPage + ")'>[다음]</a>";
			}
			if (result.paging.curPage < result.paging.totalPage)
			{
				page += "<a href='javascript:fn_viewComment(" + result.paging.totalPage + ")'>[끝]</a>";
			}
			
			// 페이징 표기
			$("#td_page").append(page);
		
			
			// 댓글 내용
			$(result.list).each(function(i) {
				var str ="<tr>" 
					+ "<td>" + result.list[i].REPLY_ID + "</td>" 
					+ "<td>" + result.list[i].ARTICLE_ID + "</td>" 
					+ "<td>" + result.list[i].USER_ID + "</td>" 
					+ "<td>" + result.list[i].DESCRIPTION + "</td>" 
					+ "</tr>";
					
				// 댓글 표기
				$("#reply_list").append(str);	
			});
		}
	});
}
</script>
</body>
</html>