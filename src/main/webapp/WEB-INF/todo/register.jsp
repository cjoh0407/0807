<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/todo/register" method="post">
	<input type="text" name="title" id="title" ><br/>
	<input type="date" name="dueDate" id="dueDate"><br/>
	<input type="submit" value="등록">
</form>
</body>
</html>