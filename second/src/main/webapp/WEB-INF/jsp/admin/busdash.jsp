<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style>

td {
    border: 1px solid #dddddd;
    padding: 8px;
    text-align:center;
}

</style>

   <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
</head>
<body>

 <div class="col-lg-8">
    <div class="card mb-3">
	        <div class="card-header">
	          <i class="fa fa-area-chart"></i> ���� ���� ����  <!--dirveridx ���� �̸����� ��ü  -->
	    	</div>
<table >
	<tr>
		<td>Button1</td>
		<td colspan="3">x</td>
			
	</tr>
	<tr>
		<td>Button2</td>
		<td colspan="2">x</td>
		<td>x</td>
		<td>�� ����ð�<h4>04h 02m</h4></td>			
	</tr>
	<tr>		
		<td>���� �⸧<h3></h3></td>
		<td>x</td>
		<td>x</td>
		<td>x</td>
		<td>�� ����Ÿ�<h4>142.05km</h4></td>
	</tr>
	<tr>
		<td colspan="2">Forward left<h3>34Psi</h3></td>
		<td rowspan="2"><img src="../img/busgif.gif" style="width:auto;'"></td>
		<td colspan="2">Forward right<h3>34Psi</h3></td>	
	</tr>
	<tr>
		<td colspan="2">Back left<h3>34Psi</h3></td>
		<td colspan="2">Back left<h3>34Psi</h3></td>	
	</tr>
	<tr>
		<td colspan="5" style="text-align:center;">���� ��Ȳ<hr><h3>��ȣ</h3></td>
	</tr>
</table>
</div>
</div>

</body>
<script>
function aa(){
	var speed =Math.floor((Math.random() * 30) + 50);
	$('#speed').html(speed+"km/h")
	 setTimeout("aa()",500);
}
$(document).ready(function(){
	aa();
})
</script>
</html>