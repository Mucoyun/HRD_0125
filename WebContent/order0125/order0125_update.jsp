<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>윤원태 - 실습 21</title>
	<style>
		input:read-only{
			background-color: lightgray;
		}input,#totalinput{
			background-color: white;
		}
	</style>
	<script>
		function check() {
			if(document.iu_form.id.value==""){
				alert("상품코드를 입력하세요.");
				document.iu_form.id.focus();
			}else if(document.iu_form.name.value==""){
				alert("주문자 이름을 입력하세요.");
				document.iu_form.name.focus();
			}else{
				document.iu_form.action = "order0125_update_process.jsp";
				document.iu_form.submit();
			}
		}
		function retry() {
			history.back(-1);
		}
		
		function idcheck() {
			document.iu_form.submit();
		}
		
		function paycheck(pay) {
			//alert(pay.value);
			if(pay.value=="1"){
				document.iu_form.cardno.value = "";
				document.iu_form.cardno.readOnly=true;
				document.iu_form.cardno.style.backgroundColor = "lightgray";
			}
			if(pay.value=="2"){
				document.iu_form.cardno.readOnly=false;
				document.iu_form.cardno.style.backgroundColor = "white";
			}
		}
	</script>
</head>
<body>
	<%@ include file="/DBConn.jsp" %>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<%
		String send_id = request.getParameter("send_id");
		String send_name = request.getParameter("send_name");
		
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String orderdate = request.getParameter("orderdate");
		String tel = request.getParameter("tel");
		String addr = request.getParameter("addr");
		String pay = request.getParameter("pay");
		String cardno = request.getParameter("cardno");
		String prodcount = request.getParameter("prodcount");
		String total = request.getParameter("total");
	
		int unitprice = 0;
		int unitsInstock = 0;
		int getProdcount = 0;
		int totalUnitsInstock = 0;
		if(id==null){
			id=send_id;
		}
		
		
		try{
			String sql = "select unitprice,unitsInstock,prodcount from product0125,order0125 where productId=? and id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				unitprice = rs.getInt(1);
				unitsInstock = rs.getInt(2);
				getProdcount = rs.getInt(3);
				totalUnitsInstock = unitsInstock+getProdcount;
			}
			
			sql = "select id,name,to_char(orderdate,'yyyy-mm-dd'),addr,tel,pay,cardno,prodcount,b.unitsInstock,total from order0125 a, product0125 b where a.id=b.productId and a.id=? and  a.name=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, send_id);
			pstmt.setString(2, send_name);
			rs = pstmt.executeQuery();
			if(rs.next()){
				id = rs.getString(1);
				name = rs.getString(2);
				orderdate = rs.getString(3);
				addr = rs.getString(4);
				tel = rs.getString(5);
				pay = rs.getString(6);			
				cardno = rs.getString(7);
				prodcount = rs.getString(8);
				unitsInstock = rs.getInt(9);
				total = rs.getString(10);
				totalUnitsInstock = unitsInstock+Integer.parseInt(prodcount);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		
		if(Integer.parseInt(prodcount)>totalUnitsInstock){
			%><script>
				alert("보유중인 재고수를 초과했습니다.");
			</script><%
			prodcount = Integer.toString(totalUnitsInstock);
		}else if(Integer.parseInt(prodcount)<0){
			prodcount = "0";
		}
		total = Integer.toString(unitprice*Integer.parseInt(prodcount));
	%>
	<section>
		<h2>주문 정보 변경 화면</h2>
		<form name="iu_form" method="post" action="/HRD_0125/order0125/order0125_update.jsp">
			<table id="iu_table">
				<tr>
					<th>상품 코드</th>
					<td><input type="text" name="id" value="<%=id %>" readonly></td>
					<th>주문자 이름</th>
					<td><input type="text" name="name" value="<%=name %>" readonly></td>
				</tr>
				<tr>
					<th>주문 날짜</th>
					<td><input type="text" name="orderdate" value="<%=orderdate %>"></td>
					<th>전화 번호</th>
					<td><input type="text" name="tel" value="<%=tel %>"></td>
				</tr>
				<tr>
					<th>배달 주소</th>
					<td colspan="3"><input class="clid" type="text" name="addr" value="<%=addr %>"></td>
				</tr>
				<tr>
					<th>결제 방법</th>
					<td>
						<input type="radio" name="pay" value="1" <%if(pay.equals("1")){%> checked <%} %> onclick="paycheck(this)"> 현금
						<input type="radio" name="pay" value="2" <%if(pay.equals("2")){%> checked <%} %> onclick="paycheck(this)"> 카드
					</td>
					<th>카드 번호</th>
					<td><input type="text" name="cardno" value="<%=cardno %>" readonly></td>
				</tr>
				<tr>
					<th>주문상품수</th>
					<td><input type="number" name="prodcount" value="<%=prodcount %>" onchange="idcheck()"></td>
					<th>주문금액</th>
					<td><input id="totalinput" type="text" name="total" value="<%=total %>" readonly></td>
				</tr>
				<tr>
					<td id="btntd" colspan="4">
						<button type="button" onclick="check()">주문변경</button>
						<button type="button" onclick="retry()">뒤로</button>
					</td>
				</tr>
			</table>
		</form>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>
