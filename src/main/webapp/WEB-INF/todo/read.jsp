<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세보기</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<h1>상세보기</h1>
<form name="tForm" id="tForm"  action="" method="get">
	<input type="text" name="tid" id="tid" value="${dto.tid}" readonly="readonly"><br/>
	<input type="text" name="title" id="title" value="${dto.title}" disabled="disabled"><br/>
	<input type="date" name="dueDate" id="dueDate" value="${dto.dueDate}" disabled="disabled"><br/>
	<input type="checkbox" name="finished"  id="finished" ${dto.finished ? "checked" : ""} disabled="disabled"><br/>
	<input type="button" value="수정" id="modify">
	<input type="button" value="목록" id="list"><br/>
	<a href="${pageContext.request.contextPath}/todo/modify?tid=${dto.tid}">수정</a>
	<a href="${pageContext.request.contextPath}/todo/list">목록</a>
</form>
<script>
$("#modify").on("click", e => {
	tForm.action = "${pageContext.request.contextPath}/todo/modify";
	tForm.submit();
});
$("#list").on("click", e => {
	tForm.action = "${pageContext.request.contextPath}/todo/list";
	tForm.submit();
});
	
</script>

</body>
</html>