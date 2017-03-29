<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<script type="text/javascript" src="/SourceMeister/static/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="/SourceMeister/static/js/json2.js"></script>

<script type="text/javascript">
	$().ready(function() {
		$("#signUpForm").find("input[type=button]").click(function() {

			if ($("#userId").val() == "") {
				alert("아이디를 입력해 주세요");
				$("#userId").focus();
				return;
			}

			if ($("#userPassword").val() == "") {
				alert("비밀번호를 입력해 주세요");
				$("#userPassword").focus();
				return;
			}

			if ($("#userName").val() == "") {
				alert("닉네임을 입력해주세요");
				$("#userName").focus();
				return;
			}

			if ($("#userPassword").val().length < 7) { // 자바스크립트에서 length는 속성에 해당.
				alert("비밀번호는 8자 이상 입력해야 합니다.");
				$("#userPassword").focus();
				return;
			}

			$.post("/SourceMeister/user/checkDuplicate", {
				"userId" : $("#userId").val()
			}, function(response) {

				var jsonObj = JSON.parse(response);

				if (jsonObj.duplicated) {
					alert("입력한 ID는 사용중입니다.\n다른 ID를 입력하세요");
					return;
				} else {
					$("#signUpForm").attr({
						"method" : "post",
						"action" : "/SourceMeister/user/signUp"
					});
					$("#signUpForm").submit();
				}
			});
		});

		$("#userId").keyup(function() {
			$.post("/SourceMeister/user/checkDuplicate", {
				"userId" : $("#userId").val()
			}, function(response) {
				var jsonObj = JSON.parse(response);
				console.log(jsonObj);

				if (jsonObj.duplicated) {
					$("#duplicated").text("중복되는 아이디 입니다..");
				} else {
					$("#duplicated").text("사용할 수 있는 아이디 입니다.");
				}
			});
		});
	});
</script>
</head>
<body>
	<c:if test="${not empty param.errorCode }">
		<!--  에러코드가 있는 경우 -->
		<div>
			<c:choose>
				<c:when test="${param.errorCode == 0 }">
					ID는 필수 입력사항 입니다.
				</c:when>
				<c:when test="${param.errorCode == 1 }">
					PASSWORD는 필수 입력사항 입니다.
				</c:when>
				<c:when test="${param.errorCode == 2 }">
					닉네임은 필수 입력사항 입니다.
				</c:when>
				<c:when test="${param.errorCode == 3 }">
					이미 사용중인 ID 입니다.
				</c:when>
				<c:otherwise>
					????
				</c:otherwise>
			</c:choose>
		</div>
	</c:if>
	<h3>회원가입 페이지</h3>
	<form id="signUpForm">
		<input type="text" name="userId" id="userId"  placeholder="아이디를 입력하세요" /><br/>
		<input type="text" name="userName" id="userName"  placeholder="닉네임을 입력하세요" /><br /> <span id="duplicated"></span> 
		<input type="password" name="userPassword" id="userPassword"  placeholder="비밀번호 입력하세요" /><br /> 
		
		<h3>개인 정보</h3>
		<hr/>
	
		<input type="button" value="가입완료" /><br />
	</form>
</body>
</html>