<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Editorial Detail - To-Do</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

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
    
    /* 포인트 컬러 */
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
    max-width: 600px;
    margin: 0 auto;
  }

  /* Header Section */
  .magazine-header {
    text-align: center;
    border-bottom: 2px solid var(--border-dark);
    padding-bottom: 24px;
    margin-bottom: 40px;
  }

  .magazine-header .sub-title {
    font-family: 'Cinzel', serif;
    font-size: 0.85rem;
    letter-spacing: 5px;
    text-transform: uppercase;
    color: var(--accent-brown);
    font-weight: 700;
    margin-bottom: 8px;
  }

  .magazine-header h1 {
    font-family: 'Playfair Display', 'Noto Sans KR', serif;
    font-size: 2.2rem;
    font-weight: 800;
    letter-spacing: -0.5px;
    color: var(--text-primary);
  }

  /* Form Layout */
  .read-form {
    display: flex;
    flex-direction: column;
    gap: 24px;
  }

  .form-group {
    display: flex;
    flex-direction: column;
    gap: 8px;
  }

  .form-group label {
    font-family: 'Cinzel', 'Noto Sans KR', serif;
    font-size: 0.85rem;
    font-weight: 700;
    letter-spacing: 1px;
    color: var(--accent-brown);
    text-transform: uppercase;
  }

  /* Input Field Styles (Disabled/Readonly) */
  .form-control {
    width: 100%;
    padding: 14px 16px;
    font-size: 1rem;
    font-family: 'Noto Sans KR', sans-serif;
    color: var(--text-primary);
    background-color: #fcfcfc;
    border: 1px solid var(--border-color);
    outline: none;
  }

  .form-control:disabled,
  .form-control[readonly] {
    background-color: #f9f8f6;
    color: var(--text-primary);
    border-color: #e2e0dc;
    cursor: default;
  }

  /* Custom Checkbox Group */
  .checkbox-group {
    flex-direction: row;
    align-items: center;
    gap: 12px;
    margin-top: 8px;
  }

  .checkbox-group input[type="checkbox"] {
    width: 18px;
    height: 18px;
    accent-color: var(--accent-green);
  }

  .checkbox-group label {
    font-family: 'Noto Sans KR', sans-serif;
    font-size: 0.95rem;
    color: var(--text-primary);
    text-transform: none;
    letter-spacing: 0;
  }

  /* Button Group */
  .btn-group {
    display: flex;
    gap: 12px;
    margin-top: 16px;
    padding-top: 24px;
    border-top: 1px solid var(--border-color);
  }

  .btn {
    flex: 1;
    padding: 12px 0;
    font-size: 0.9rem;
    font-weight: 600;
    letter-spacing: 1px;
    border: 1px solid var(--border-dark);
    background-color: transparent;
    cursor: pointer;
    transition: all 0.25s ease;
    text-align: center;
  }

  /* 수정 버튼: 짙은 녹색 */
  .btn-modify {
    background-color: var(--accent-green);
    border-color: var(--accent-green);
    color: #ffffff;
  }

  .btn-modify:hover {
    background-color: #0d281e;
    border-color: #0d281e;
  }

  /* 목록 버튼: 갈색 테두리 */
  .btn-list {
    border-color: var(--accent-brown);
    color: var(--accent-brown);
  }

  .btn-list:hover {
    background-color: var(--accent-brown);
    color: #ffffff;
  }

  .back-link {
    display: inline-block;
    margin-bottom: 20px;
    font-family: 'Cinzel', serif;
    font-size: 0.8rem;
    letter-spacing: 1px;
    color: var(--text-muted);
    text-decoration: none;
    transition: color 0.2s ease;
  }

  .back-link:hover {
    color: var(--accent-green);
  }
</style>
</head>
<body>

<div class="magazine-container">

  <!-- 목록으로 돌아가기 링크 -->
  <a href="${pageContext.request.contextPath}/todo/list" class="back-link">&larr; BACK TO LIST</a>

  <!-- Header -->
  <header class="magazine-header">
    <div class="sub-title">View Item</div>
    <h1>상세보기</h1>
  </header>

  <!-- Form -->
  <form name="tForm" id="tForm" action="" method="get" class="read-form">
    
    <!-- TID -->
    <div class="form-group">
      <label for="tid">Task ID</label>
      <input type="text" name="tid" id="tid" value="${dto.tid}" readonly="readonly" class="form-control">
    </div>

    <!-- Title -->
    <div class="form-group">
      <label for="title">Title</label>
      <input type="text" name="title" id="title" value="${dto.title}" disabled="disabled" class="form-control">
    </div>

    <!-- Due Date -->
    <div class="form-group">
      <label for="dueDate">Due Date</label>
      <input type="date" name="dueDate" id="dueDate" value="${dto.dueDate}" disabled="disabled" class="form-control">
    </div>

    <!-- Finished Checkbox -->
    <div class="form-group checkbox-group">
      <input type="checkbox" name="finished" id="finished" ${dto.finished ? "checked" : ""} disabled="disabled">
      <label for="finished">완료 여부 (Finished)</label>
    </div>

    <!-- Action Buttons -->
    <div class="btn-group">
      <input type="button" value="수정" id="modify" class="btn btn-modify">
      <input type="button" value="목록" id="list" class="btn btn-list">
    </div>

  </form>

</div>

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