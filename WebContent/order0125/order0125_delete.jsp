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
		String send_name = request.getParameter("send_name");
		
		int unitsInstock = 0;
		int prodcount = 0;
		
		try{
			String sql = "select a.unitsInstock,b.prodcount from product0125 a,order0125 b where productId=? and id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, send_id);
			pstmt.setString(2, send_id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				unitsInstock = rs.getInt(1);
				prodcount = rs.getInt(2);
				
				sql = "update product0125 set unitsInstock=? where productId=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, unitsInstock+prodcount);
				pstmt.setString(2, send_id);
				pstmt.executeUpdate();
				
				sql = "delete from order0125 where id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, send_id);
				pstmt.executeUpdate();
				
				%><script>
					alert("삭제가 완료되었습니다.");
					location.href="/HRD_0125/order0125/order0125_select.jsp";
				</script><%
			}else{
				%><script>
					alert("재고수 조회 실패.");
					location.href="/HRD_0125/product0125/product0125_select.jsp";
				</script><%
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		
		
		
		try{
			String sql = "select";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, send_id);
			
			sql = "delete from order0125 where id=? and name=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, send_id);
			pstmt.setString(2, send_name);
			pstmt.executeUpdate();
			%><script>
				alert("삭제가 완료되었습니다.");
				location.href="/HRD_0125/order0125/order0125_select.jsp";
			</script><%
		}catch(SQLException e){
			e.printStackTrace();
		}
	%>
</body>
</html>