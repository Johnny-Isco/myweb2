<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/include/include-header.jsp" %>
<style>
.visuallyHidden {visibility: hidden; overflow: hidden;}
.thFull {visibility: hidden; overflow: hidden;}
.short {visibility: hidden; overflow: hidden;}
.expandable {visibility: hidden; overflow: hidden;}
.nombre-equipo-clasificacion-movil {visibility: hidden; overflow: hidden;}
</style>
</head>
<body>
<%@include file="/WEB-INF/include/include-title.jsp" %>
<div class="container">
<div class="form-inline">
<select class="form-control" id="league_select">
<option selected="selected" value="1">EPL</option>
<option value="2">LFP</option>
</select>
<button class="btn btn-default" id="league_btn">검색</button>
</div>
</div>

<script>
$(document).ready(function(e) {
	fn_selectLeague();
	
	$("#league_btn").trigger("click");
});

// 셀렉트 메뉴 이벤트 함수
function fn_selectLeague() {
	$("#league_btn").unbind("click").click(function(e) {
		var url;
		var val = $("#league_select").val();
		if(val == 1)
		{
			url = "/crawler/eplTable.do";
		}
		else if(val == 2)
		{
			url = "/crawler/laligaTable.do";
		}
		fn_changeTable(val, url);
	});
}

// 리그 순위표 호출 함수
function fn_changeTable(val, url) {
	$.ajax({
		url			: url,
		type		: "POST",
		dataType	: "json", 
		success		: function(result) {
			$(".table").remove();
			$(".container").append(result.league_info);
			if(val == 1)
			{
				fn_drawEPLTable();
				fn_drawEPLTableTh();
			}
			else if(val == 2)
			{
				fn_drawLaligaTable();
				fn_drawLaligaTableTh();
			}
		},
		error	: function(request, status, error) {
			alert("서버가 응답하지 않습니다." + "\n" + "다시 시도해주시기 바랍니다." + "\n" 
					+ "code: " + request.status + "\n" 
					+ "message : " + status + "\n" 
					+ "error: " + error);
		}
	});
}

function fn_drawEPLTable() {
	$("table").attr("class", "table");
}

function fn_drawEPLTableTh() {
	var changeStr = ["순위", "클럽명", "경기", "승리", "무승부", "패배", "득점", "실점", "득실차", "승점"];
	
	for(var i=0; i < changeStr.length; i++)
	{
		$("table").find("th:eq("+(i+1)+")").text(changeStr[i]);
	}
}


function fn_drawLaligaTable() {
	$("table").attr("class", "table");
}

function fn_drawLaligaTableTh() {
	var changeStr = ["순위", "클럽명", "승점", "경기", "승리", "무승부", "패배", "득점", "실점"];
	
	for(var i=0; i < changeStr.length; i++)
	{
		$("table").find("th:eq("+i+")").text(changeStr[i]);
	}
}
</script>
</body>
</html>