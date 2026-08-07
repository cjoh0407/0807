<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Editorial To-Do List</title>

<!-- Google Fonts (클래식 매거진용 Serif + Sans-serif 조합) -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@600;700&family=Noto+Sans+KR:wght@300;400;500;700&family=Playfair+Display:ital,wght@0,600;0,800;1,400&display=swap" rel="stylesheet">

<style>
  :root {
    --bg-color: #ffffff;           /* 순백색 바탕 */
    --card-bg: #ffffff;
    --text-primary: #111111;       /* 깊은 검은색 글씨 */
    --text-muted: #666666;
    
    /* 요청하신 포인트 컬러 */
    --accent-green: #1b4332;       /* 짙은 포레스트 녹색 */
    --accent-brown: #8d5b4c;       /* 웜 톤 클래식 갈색 */
    
    --border-color: #e5e5e5;
    --border-dark: #111111;
  }

  * {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
  }

  body {
    background-color: var(--bg-color);
    color: var(--text-primary);
    font-family: 'Noto Sans KR', sans-serif;
    line-height: 1.6;
    padding: 50px 20px;
  }

  a {
    color: inherit;
    text-decoration: none;
  }

  .magazine-container {
    max-width: 880px;
    margin: 0 auto;
  }

  /* Header Section */
  .magazine-header {
    text-align: center;
    border-bottom: 2px solid var(--border-dark);
    padding-bottom: 28px;
    margin-bottom: 36px;
  }

  .magazine-header .sub-title {
    font-family: 'Cinzel', serif;
    font-size: 0.85rem;
    letter-spacing: 5px;
    text-transform: uppercase;
    color: var(--accent-brown); /* 갈색 포인트 */
    font-weight: 700;
    margin-bottom: 8px;
  }

  .magazine-header h1 {
    font-family: 'Playfair Display', 'Noto Sans KR', serif;
    font-size: 2.7rem;
    font-weight: 800;
    letter-spacing: -0.5px;
    color: var(--text-primary);
  }

  /* User Info Bar */
  .user-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid var(--border-color);
    padding-bottom: 18px;
    margin-bottom: 40px;
  }

  .user-welcome {
    font-size: 1.05rem;
    font-weight: 400;
  }

  .user-welcome span {
    font-weight: 700;
    color: var(--accent-green); /* 짙은 녹색 포인트 */
    border-bottom: 2px solid var(--accent-green);
  }

  .nav-actions {
    display: flex;
    gap: 12px;
  }

  .btn {
    display: inline-block;
    padding: 9px 18px;
    font-size: 0.85rem;
    font-weight: 600;
    letter-spacing: 0.5px;
    border: 1px solid var(--border-dark);
    background-color: transparent;
    cursor: pointer;
    transition: all 0.25s ease;
  }

  /* 메인 버튼: 짙은 녹색 배경 */
  .btn-primary {
    background-color: var(--accent-green);
    border-color: var(--accent-green);
    color: #ffffff;
  }

  .btn-primary:hover {
    background-color: #0d281e;
    border-color: #0d281e;
  }

  /* 서브 버튼: 갈색 테두리 */
  .btn-outline {
    border-color: var(--accent-brown);
    color: var(--accent-brown);
  }

  .btn-outline:hover {
    background-color: var(--accent-brown);
    color: #ffffff;
  }

  /* 위험/탈퇴 버튼 */
  .btn-danger {
    border-color: #999999;
    color: #777777;
  }

  .btn-danger:hover {
    border-color: var(--text-primary);
    color: var(--text-primary);
  }

  /* Todo List Table-Style Grid */
  .todo-list {
    list-style: none;
    display: flex;
    flex-direction: column;
    gap: 14px;
  }

  .todo-item {
    background-color: var(--card-bg);
    border: 1px solid var(--border-color);
    transition: all 0.2s ease;
  }

  .todo-item:hover {
    border-color: var(--accent-brown); /* 호버 시 갈색 테두리 */
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.04);
  }

  .todo-link {
    display: grid;
    grid-template-columns: 55px 1fr 130px 100px;
    align-items: center;
    padding: 22px 28px;
    gap: 16px;
  }

  /* 넘버링: 갈색 포인트 */
  .todo-num {
    font-family: 'Playfair Display', serif;
    font-size: 1.35rem;
    font-weight: 700;
    color: var(--accent-brown);
    font-style: italic;
  }

  .todo-title {
    font-size: 1.1rem;
    font-weight: 500;
    color: var(--text-primary);
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }

  .todo-date {
    font-size: 0.85rem;
    color: var(--text-muted);
    font-family: 'Cinzel', sans-serif;
    text-align: right;
  }

  .todo-status {
    text-align: right;
  }

  .status-badge {
    display: inline-block;
    padding: 5px 12px;
    font-size: 0.72rem;
    font-weight: 700;
    letter-spacing: 1.2px;
    text-transform: uppercase;
  }

  /* DONE: 짙은 녹색 뱃지 */
  .status-badge.done {
    background-color: #e8f0ec;
    color: var(--accent-green);
    border: 1px solid var(--accent-green);
  }

  /* PENDING: 갈색 뱃지 */
  .status-badge.yet {
    background-color: #f7f2f0;
    color: var(--accent-brown);
    border: 1px solid var(--accent-brown);
  }

  /* Responsive Design */
  @media (max-width: 680px) {
    .todo-link {
      grid-template-columns: 40px 1fr;
      row-gap: 8px;
      padding: 16px 20px;
    }
    
    .todo-date, .todo-status {
      text-align: left;
      grid-column: 2;
    }

    .user-bar {
      flex-direction: column;
      align-items: flex-start;
      gap: 16px;
    }
  }
</style>
</head>
<body>

<div class="magazine-container">
  
  <!-- Header -->
  <header class="magazine-header">
    <div class="sub-title">The Editorial Archive</div>
    <h1>${empty loginInfo ? "Guest" : loginInfo.mname}'s To-Do Collection</h1>
  </header>

  <!-- User Bar -->
  <div class="user-bar">
    <div class="user-welcome">
      <c:choose>
        <c:when test="${not empty loginInfo}">
          <span>${loginInfo.mname}</span>님의 수집된 목록입니다.
        </c:when>
        <c:otherwise>
          로그인이 필요한 서비스입니다.
        </c:otherwise>
      </c:choose>
    </div>

    <div class="nav-actions">
      <a href="${pageContext.request.contextPath}/todo/register" class="btn btn-primary">할일 등록</a>
      
      <c:choose>
        <c:when test="${empty loginInfo}">
          <a href="${pageContext.request.contextPath}/login" class="btn btn-outline">로그인</a>
        </c:when>
        <c:otherwise>
          <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline">로그아웃</a>
          <a href="${pageContext.request.contextPath}/member/remove" class="btn btn-danger">회원탈퇴</a>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <!-- Main Content -->
  <main>
    <ul class="todo-list">
      <c:forEach items="${list}" var="dto" varStatus="varStatus">
        <li class="todo-item">
          <a href="${pageContext.request.contextPath}/todo/read?tid=${dto.tid}" class="todo-link">
            <!-- 숫자: 갈색 Accent -->
            <span class="todo-num">
              <c:if test="${varStatus.index + 1 < 10}">0</c:if>${varStatus.index + 1}
            </span>
            
            <!-- 제목: 검은색 -->
            <span class="todo-title">${dto.title}</span>
            
            <!-- 마감일 -->
            <span class="todo-date">${dto.dueDate}</span>
            
            <!-- 상태 뱃지: DONE(녹색) / PENDING(갈색) -->
            <span class="todo-status">
              <c:choose>
                <c:when test="${dto.finished}">
                  <span class="status-badge done">DONE</span>
                </c:when>
                <c:otherwise>
                  <span class="status-badge yet">PENDING</span>
                </c:otherwise>
              </c:choose>
            </span>
          </a>
        </li>
      </c:forEach>
    </ul>
  </main>

</div>

</body>
</html>