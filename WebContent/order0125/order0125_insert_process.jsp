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
		String orderdate = request.getParameter("orderdate");
		String addr = request.getParameter("addr");
		String tel = request.getParameter("tel");
		
		String pay = request.getParameter("pay");
		String cardno = request.getParameter("cardno");
		String prodcount = request.getParameter("prodcount");
		String total = request.getParameter("total");
		
		int unitsInstock = 0;
		
		try{
			String sql = "select unitsInstock from product0125 where productId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				unitsInstock = rs.getInt(1);
				
				sql = "update product0125 set unitsInstock=? where productId=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, unitsInstock-Integer.parseInt(prodcount));
				pstmt.setString(2, id);
				pstmt.executeUpdate();
				
				sql = "insert into order0125 values(?,?,?,?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, name);
				pstmt.setString(3, orderdate);
				pstmt.setString(4, addr);
				pstmt.setString(5, tel);
				pstmt.setString(6, pay);
				pstmt.setString(7, cardno);
				pstmt.setString(8, prodcount);
				pstmt.setString(9, total);
				pstmt.executeUpdate();
				
				%><script>
					alert("등록이 완료되었습니다.");
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
	%>
</body>
</html>