<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>할일 목록</h1>
	<c:forEach var="i" begin="1" end="10">
	${i}<br/>
	</c:forEach>


<c:if test="${list.size() % 2 == 0}">짝수</c:if>
<c:if test="${list.size() % 2 == 1}">홀수</c:if>

<c:choose>
	<c:when test="${list.size() % 2 == 0}">짝수</c:when>
	<c:otherwise>홀수</c:otherwise>
</c:choose>

${list.size() % 2 == 0 ? '짝수' : '홀수'}

<c:if test="${fn:length(list) % 2 == 0}">짝수</c:if>
<c:if test="${fn:length(list) % 2 == 1}">홀수</c:if>

<c:choose>
	<c:when test="${fn:length(list) % 2 == 0}">짝수</c:when>
	<c:otherwise>홀수</c:otherwise>
</c:choose>

${fn:length(list) % 2 == 0 ? '짝수' : '홀수'}

<ul>
	<c:forEach items="${list}" var="dto" varStatus="varStatus">
		<li>
			<a href="${pageContext.request.contextPath}/todo/read?tid=${dto.tid}">${fn:length(list) - varStatus.index}.</a> 
				${dto.title} 
				${dto.dueDate} 
				${dto.finished}
				${dto.finishedStr}
		</li>
	</c:forEach>
</ul>

<a href="${pageContext.request.contextPath}/todo/register">할일등록</a>
<c:choose>
	<c:when test="${empty(loginInfo)}">
		<a href="${pageContext.request.contextPath}/login">로그인</a>
	</c:when>
	<c:otherwise>
		${loginInfo.mname} <a href="${pageContext.request.contextPath}/logout">로그아웃</a>
	</c:otherwise>
</c:choose>


</body>
</html>