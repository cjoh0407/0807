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
<h1>수정화면</h1>
<form name="tForm" id="tForm"  action="${pageContext.request.contextPath}/todo/modify" method="post">
	<input type="text" name="tid" id="tid" value="${dto.tid}" readonly="readonly"><br/>
	<input type="text" name="title" id="title" value="${dto.title}" ><br/>
	<input type="date" name="dueDate" id="dueDate" value="${dto.dueDate}" ><br/>
	<input type="checkbox" name="finished"  id="finished" ${dto.finished ? "checked" : "" } value="true"><br/>
	<input type="submit" value="수정" id="modify">
	<input type="button" value="삭제" id="remove">
	<input type="reset" value="초기화" >
</form>

<script>
$("#remove").on("click", e => {
	tForm.action = "${pageContext.request.contextPath}/todo/remove";
	tForm.submit();
});
</script>

</body>
</html>