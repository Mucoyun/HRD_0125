<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>윤원태 - 실습 21</title>
	<script>
		function check() {
			if(document.iu_form.productId.value==""){
				alert("상품번호를 입력하세요.");
				document.iu_form.productId.focus();
			}else if(document.iu_form.productName.value==""){
				alert("상품명을 입력하세요.");
				document.iu_form.productName.focus();
			}else{
				document.iu_form.submit();
			}
		}
		function retry() {
			document.iu_form.reset();
		}
		
		function idcheck() {
			document.iu_form.submit();
		}
	</script>
</head>
<body>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<section>
		<h2>상품 정보 등록 화면</h2>
		<form name="iu_form" method="post" action="product0125_insert_process.jsp">
			<table id="iu_table">
				<tr>
					<th>상품코드</th>
					<td colspan="3"><input class="clid" type="text" name="productId"></td>
				</tr>
				<tr>
					<th>상품명</th>
					<td colspan="3"><input class="clid" type="text" name="productName"></td>
				</tr>
				<tr>
					<th>가격</th>
					<td colspan="3"><input class="clid" type="text" name="unitprice"></td>
				</tr>
				<tr>
					<th>상세정보</th>
					<td colspan="3"><input class="clid" type="text" name="description"></td>
				</tr>
				<tr>
					<th>제조사</th>
					<td colspan="3"><input class="clid" type="text" name="manufacturer"></td>
				</tr>
				<tr>
					<th>분류</th>
					<td><input type="text" name="category"></td>
					<th>재고수</th>
					<td><input type="text" name="unitsInstock"></td>
				</tr>
				<tr>
					<th>상태</th>
					<td colspan="3">
						<input type="radio" name="condition" value="신규제품" checked> 신규제품
						<input type="radio" name="condition" value="중고제품"> 중고제품
						<input type="radio" name="condition" value="재생제품"> 재생제품
					</td>
				</tr>
				<tr>
					<td id="btntd" colspan="4">
						<button type="button" onclick="check()">상품등록</button>
						<button type="button" onclick="retry()">다시작성</button>
					</td>
				</tr>
			</table>
		</form>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>