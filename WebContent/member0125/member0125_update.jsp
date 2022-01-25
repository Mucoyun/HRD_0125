<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>윤원태 - 실습 21</title>
	<script>
		function check() {
			if(document.iu_form.id.value==""){
				alert("아이디를 입력하세요.");
				document.iu_form.id.focus();
			}else if(document.iu_form.name.value==""){
				alert("이름을 입력하세요.");
				document.iu_form.name.focus();
			}else if(document.iu_form.password.value==""){
				alert("비밀번호를 입력하세요.");
				document.iu_form.password.focus();
			}else{
				document.iu_form.submit();
			}
		}
		function retry() {
			history.back(-1);
		}
	</script>
</head>
<body>
	<%@ include file="/DBConn.jsp" %>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<%
		String send_id = request.getParameter("send_id");
	
		String id = "";
		String name = "";
		String password = "";
		String gender = "";
		String birth = "";
		
		String[] mails;
		String mail = "";
		String mail1 = "";
		String mail2 = "";
		
		String[] phones;
		String phone = "";
		String phone1 = "";
		String phone2 = "";
		String phone3 = "";
		
		String address = "";
		String nickname = "";
	
		try{
			String sql = "select id,name,password,gender,to_char(birth,'yyyy-mm-dd'),mail,phone,address,nickname from member0125 where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, send_id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				id = rs.getString(1);
				name = rs.getString(2);
				password = rs.getString(3);
				gender = rs.getString(4);
				birth = rs.getString(5);
				mail = rs.getString(6);
				phone = rs.getString(7);
				address = rs.getString(8);
				nickname = rs.getString(9);
				
				
				mails = mail.split("@");
				mail1 = mails[0];
				mail2 = mails[1];
				
				phones = phone.split("-");
				phone1 = phones[0];
				phone2 = phones[1];
				phone3 = phones[2];
				
			}else{
				%><script>
					alert("해당 아이디정보가 없습니다.");
					history.back(-1);
				</script><%
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
	
	%>
	<section>
		<h2>회원 정보 등록 화면</h2>
		<form name="iu_form" method="post" action="member0125_update_process.jsp">
			<table id="iu_table">
				<tr>
					<th>아이디</th>
					<td><input type="text" name="id" value="<%=id %>" readonly></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="name" value="<%=name %>"></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="password" value="<%=password %>"></td>
				</tr>
				<tr>
					<th>성별</th>
					<td>
						<input type="radio" name="gender" value="남성" <%if(gender.equals("남성")){%> checked <%} %>> 남성
						<input type="radio" name="gender" value="여성" <%if(gender.equals("여성")){%> checked <%} %>> 여성
					</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td><input type="date" name="birth" value="<%=birth %>"></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<input type="text" name="mail1" value="<%=mail1 %>"> @
						<select name="mail2">
							<option value="naver.com" <%if(mail2.equals("naver.com")){%> selected <%} %>>naver.com</option>
							<option value="gmail.com" <%if(mail2.equals("gmail.com")){%> selected <%} %>>gmail.com</option>
							<option value="nate.com" <%if(mail2.equals("nate.com")){%> selected <%} %>>nate.com</option>
						</select>
					</td>
				</tr>
				<tr id="phonetr">
					<th>핸드폰</th>
					<td>
						<select name="phone1">
							<option value="010" <%if(phone1.equals("010")){%> selected <%} %>>010</option>
							<option value="011" <%if(phone1.equals("011")){%> selected <%} %>>011</option>
							<option value="070" <%if(phone1.equals("070")){%> selected <%} %>>070</option>
						</select>-
						<input type="text" name="phone2" value="<%=phone2 %>" maxlength="4">-
						<input type="text" name="phone3" value="<%=phone3 %>" maxlength="4">
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td><input type="text" name="address" value="<%=address %>"></td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td><input type="text" name="nickname" value="<%=nickname %>"></td>
				</tr>
				<tr>
					<td id="btntd" colspan="2">
						<button type="button" onclick="check()">회원변경</button>
						<button type="button" onclick="retry()">뒤로</button>
					</td>
				</tr>
			</table>
		</form>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>