<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<!DOCTYPE html>
<html>
<head>
<style>
	a {
    color: inherit;
    text-decoration: none;
}
</style>
<meta charset="UTF-8">
<title>할일 목록</title>
</head>
<body>
<h1>${loginInfo.mname}님의 할일 목록</h1>

<ul>
	<c:forEach items="${list}" var="dto" varStatus="varStatus">
		<li>
			<a href="${pageContext.request.contextPath}/todo/read?tid=${dto.tid}">${varStatus.index+1}. 
				${dto.title} 
				${dto.dueDate} 
				${dto.finished}
				<%-- DTO에 getFinishedStr()이 구현되어 있다면 사용 가능 --%>
				${dto.finishedStr}
			</a>
		</li>
	</c:forEach>
</ul>
<button>
	<a href="${pageContext.request.contextPath}/todo/register">할일등록</a>
</button>
<button>
<c:choose>
	<c:when test="${empty loginInfo}">
		<a href="${pageContext.request.contextPath}/login">로그인</a>
	</c:when>
	<c:otherwise>
		<a href="${pageContext.request.contextPath}/logout">로그아웃</a>
	</c:otherwise>
</c:choose>
</button>
<a href="${pageContext.request.contextPath}/member/remove">회원탈퇴</a>


</body>
</html>