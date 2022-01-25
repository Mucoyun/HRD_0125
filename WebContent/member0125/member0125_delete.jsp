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
		String send_id = request.getParameter("send_id");
	
		try{
			String sql = "delete from member0125 where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, send_id);
			pstmt.executeUpdate();
			%><script>
				alert("삭제가 완료되었습니다.");
				location.href="/HRD_0125/member0125/member0125_select.jsp";
			</script><%	
			
		}catch(SQLException e){
			e.printStackTrace();
		}
	
	%>
</body>
</html>