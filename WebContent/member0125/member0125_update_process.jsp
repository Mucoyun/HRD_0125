<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>윤원태 - 실습 21</title>
</head>
<body>
	<%@ include file="/DBConn.jsp" %>
	<%
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String gender = request.getParameter("gender");
		String birth = request.getParameter("birth");

		String mail1 = request.getParameter("mail1");
		String mail2 = request.getParameter("mail2");
		String mail = mail1 + "@" + mail2;
		
		String phone1 = request.getParameter("phone1");
		String phone2 = request.getParameter("phone2");
		String phone3 = request.getParameter("phone3");
		String phone = phone1 + "-" + phone2 + "-" + phone3;
		
		String address = request.getParameter("address");
		String nickname = request.getParameter("nickname");
		
		try{
			String sql = "update member0125 set name=?,password=?,gender=?,birth=?,mail=?,phone=?,address=?,nickname=? where id=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, name);
			pstmt.setString(2, password);
			pstmt.setString(3, gender);
			pstmt.setString(4, birth);
			pstmt.setString(5, mail);
			pstmt.setString(6, phone);
			pstmt.setString(7, address);
			pstmt.setString(8, nickname);
			pstmt.setString(9, id);
			pstmt.executeUpdate();
			%><script>
				alert("변경이 완료되었습니다.");
				location.href="/HRD_0125/member0125/member0125_select.jsp";
			</script><%
		}catch(SQLException e){
			e.printStackTrace();
		}
	%>
</body>
</html>