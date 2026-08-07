<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
    body {
        font-family: Arial, sans-serif;
        height: 100vh;
        margin: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: #f4f4f4;
    }
    .login-box {
        background: white;
        padding: 40px;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        width: 300px;
        text-align: center;
    }
    .login-box h2 {
        margin-bottom: 25px;
        color: #333;
    }
    .input-group {
        margin-bottom: 15px;
        text-align: left;
    }
    .input-group label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
        font-size: 14px;
    }
    .input-group input {
        width: 100%;
        padding: 10px;
        box-sizing: border-box;
        border: 1px solid #ddd;
        border-radius: 4px;
    }
    .login-btn {
        width: 100%;
        padding: 10px;
        background-color: #007BFF;
        color: white;
        border: none;
        border-radius: 4px;
        font-size: 16px;
        cursor: pointer;
        margin-top: 10px;
    }
    .login-btn:hover {
        background-color: #0056b3;
    }
</style>
</head>
<body>

	<c:if test="${param.result == 'error'}">
		<div>
			아이디 또는 비밀번호를 확인해주세요 
		</div>
	</c:if>

    <div class="login-box">
        <h2>로그인</h2>
        <!-- 컨트롤러로 데이터를 보내기 위해 action과 method 지정 -->
        <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post">
            <div class="input-group">
                <label for="loginId">아이디</label>
                <input type="text" id="loginId" name="loginId" placeholder="아이디를 입력하세요" value="kosa">
            </div>

            <div class="input-group">
                <label for="loginPw">비밀번호</label>
                <input type="password" id="loginPw" name="loginPw" placeholder="비밀번호를 입력하세요" value="kosa1004">
            </div>
			
			<input type="checkbox" name="auto" id="auto" value="on" checked="checked">
			<label for="auto">자동 로그인</label>
			 
            <button type="submit" class="login-btn">로그인</button>
        </form>
    </div>

    <script>
	    const $loginId = $("#loginId");
	    const $loginPw = $("#loginPw");
	    
	    $(".login-btn").on("click", e => {
    		
            const id = $loginId.val().trim();
            const pw = $loginPw.val().trim();

            if (id === "") {
                alert("아이디를 입력해주세요!");
                $loginId.focus();
        		e.preventDefault();
                return false;
            }

            if (pw === "") {
                alert("비밀번호를 입력해주세요!");
                $loginPw.focus();
        		e.preventDefault();
                return false;
            }

            // 유효성 검사가 끝나면 폼을 서버(Controller)로 전송
            //$("#loginForm").submit();
    		
    	})
    </script>

</body>
</html>