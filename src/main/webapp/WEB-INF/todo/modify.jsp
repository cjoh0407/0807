<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Editorial Edit - To-Do</title>
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
  .edit-form {
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

  /* Input Field Styles */
  .form-control {
    width: 100%;
    padding: 14px 16px;
    font-size: 1rem;
    font-family: 'Noto Sans KR', sans-serif;
    color: var(--text-primary);
    background-color: var(--card-bg);
    border: 1px solid var(--border-color);
    outline: none;
    transition: all 0.25s ease;
  }

  .form-control:focus {
    border-color: var(--accent-green);
    box-shadow: 0 0 0 1px var(--accent-green);
  }

  /* Readonly Style */
  .form-control[readonly] {
    background-color: #f9f9f9;
    color: var(--text-muted);
    border-color: #eeeeee;
    cursor: not-allowed;
  }

  /* Custom Checkbox Group */
  .checkbox-group {
    flex-direction: row;
    align-items: center;
    gap: 12px;
    margin-top: 8px;
    cursor: pointer;
  }

  .checkbox-group input[type="checkbox"] {
    width: 18px;
    height: 18px;
    accent-color: var(--accent-green);
    cursor: pointer;
  }

  .checkbox-group label {
    font-family: 'Noto Sans KR', sans-serif;
    font-size: 0.95rem;
    color: var(--text-primary);
    text-transform: none;
    letter-spacing: 0;
    cursor: pointer;
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
  .btn-submit {
    background-color: var(--accent-green);
    border-color: var(--accent-green);
    color: #ffffff;
  }

  .btn-submit:hover {
    background-color: #0d281e;
    border-color: #0d281e;
  }

  /* 삭제 버튼: 경고성 차분한 갈색/붉은 톤 테두리 */
  .btn-delete {
    border-color: var(--accent-brown);
    color: var(--accent-brown);
  }

  .btn-delete:hover {
    background-color: var(--accent-brown);
    color: #ffffff;
  }

  /* 초기화/목록 버튼 */
  .btn-reset {
    border-color: #cccccc;
    color: #666666;
  }

  .btn-reset:hover {
    border-color: var(--text-primary);
    color: var(--text-primary);
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
    <div class="sub-title">Modify Item</div>
    <h1>상세 및 수정화면</h1>
  </header>

  <!-- Form -->
  <form name="tForm" id="tForm" action="${pageContext.request.contextPath}/todo/modify" method="post" class="edit-form">
    
    <!-- TID (Readonly) -->
    <div class="form-group">
      <label for="tid">Task ID</label>
      <input type="text" name="tid" id="tid" value="${dto.tid}" readonly="readonly" class="form-control">
    </div>

    <!-- Title -->
    <div class="form-group">
      <label for="title">Title</label>
      <input type="text" name="title" id="title" value="${dto.title}" class="form-control" placeholder="할 일을 입력하세요">
    </div>

    <!-- Due Date -->
    <div class="form-group">
      <label for="dueDate">Due Date</label>
      <input type="date" name="dueDate" id="dueDate" value="${dto.dueDate}" class="form-control">
    </div>

    <!-- Finished Checkbox -->
    <div class="form-group checkbox-group">
      <input type="checkbox" name="finished" id="finished" ${dto.finished ? "checked" : "" } value="true">
      <label for="finished">완료 여부 (Finished)</label>
    </div>

    <!-- Action Buttons -->
    <div class="btn-group">
      <input type="submit" value="수정완료" id="modify" class="btn btn-submit">
      <input type="button" value="삭제" id="remove" class="btn btn-delete">
      <input type="reset" value="초기화" class="btn btn-reset">
    </div>

  </form>

</div>

<script>
$("#remove").on("click", e => {
	tForm.action = "${pageContext.request.contextPath}/todo/remove";
	tForm.submit();
});
</script>

</body>
</html>