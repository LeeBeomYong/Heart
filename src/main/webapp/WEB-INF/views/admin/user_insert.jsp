<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<link rel="stylesheet" href="resources/css/admin_include.css">
<body>
<jsp:include page="../include/admin_header.jsp" />
<br><br>
<div class="div1" align="center">
	<form>
		<table class="table">
			<tr>
				<th class="table-secondary"><span class="sp2">아이디</span></th>
				<td><input class ="input1" type="text"></td>
			</tr>
			<tr>
				<th class="table-secondary"><span class="sp2">이름</span></th>
				<td><input class ="input1" type="text"></td>
			</tr>
			<tr>
				<th class="table-secondary"><span class="sp2">주민등록번호</span></th>
				<td><input class ="input1" type="text"></td>
			</tr>
			<tr>
				<th class="table-secondary"><span class="sp2">등급</span></th>
				<td><input class ="input1" type="text"></td>
			</tr>
			<tr>
				<th class="table-secondary"><span class="sp2">이메일</span></th>
				<td><input class ="input1" type="text"></td>
			</tr>
			<tr>
				<th class="table-secondary"><span class="sp2">연락처</span></th>
				<td><input class ="input1" type="text"></td>
			</tr>
			<tr>
				<th class="table-secondary"><span class="sp2">주소</span></th>
				<td><input class ="input1" type="text"></td>
			</tr>
			<tr>
				<th class="table-secondary"><span class="sp2">후원금액</span></th>
				<td><input class ="input1" type="text"></td>
			</tr>
			<tr>
				<th class="table-secondary"><span class="sp2">반려동물경험</span></th>
				<td><input class ="input1" type="text"></td>
			</tr>
		</table>
		<br>
		<input id="update_btn" type="submit" value="등록" align="center">
	</form>
</div>
</body>
</html>