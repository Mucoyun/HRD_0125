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
				document.iu_form.action = "order0125_insert_process.jsp";
				document.iu_form.submit();
			}
		}
		function retry() {
			document.iu_form.reset();
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
		
		if(id == null){ id = ""; }	
		if(name == null){ name = ""; }
		if(orderdate == null){ orderdate = "2022-01-01"; }
		if(tel == null){ tel = ""; }
		if(addr == null){ addr = ""; }
		
		if(pay == null){ pay = "1"; }
		if(cardno == null){ cardno = ""; }
		if(prodcount == null){ prodcount = "0"; }
		if(total == null){ total = "0"; }		
		
		try{
			//상품명, 상품가격, 상품재고수
			String sql = "select unitprice,unitsInstock from product0125 where productId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				unitprice = rs.getInt(1);
				unitsInstock = rs.getInt(2);
			}else if(id.equals("")){
				id = "";
			}else{
				id = "";
				%><script>
					alert("등록된 상품코드가 아닙니다.");
					idcheck();
				</script><%
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		
		if(Integer.parseInt(prodcount)>unitsInstock){
			%><script>
				alert("보유중인 재고수를 초과했습니다.");
			</script><%
			prodcount = Integer.toString(unitsInstock);
		}else if(Integer.parseInt(prodcount)<0){
			prodcount = "0";
		}
		total = Integer.toString(unitprice*Integer.parseInt(prodcount));
		
	%>
	<section>
		<h2>주문 정보 등록 화면</h2>
		<form name="iu_form" method="post" action="order0125_insert.jsp">
			<table id="iu_table">
				<tr>
					<th>상품 코드</th>
					<td><input type="text" name="id" value="<%=id %>" onchange="idcheck()"></td>
					<th>주문자 이름</th>
					<td><input type="text" name="name" value="<%=name %>"></td>
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
						<button type="button" onclick="check()">주문등록</button>
						<button type="button" onclick="retry()">다시작성</button>
					</td>
				</tr>
			</table>
		</form>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>