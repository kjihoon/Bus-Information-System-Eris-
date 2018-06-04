<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    
    
<div>


<form action="/first/admin/selfcontroll.do">
<input type="text" name="temp">
	<input type="text" name="busidx">
	<input type="submit">
</form>

</div>



<script>


$(document).ready(function(){
	
	
	
})

function req(){
	
}

function req_ajax(){
	$.ajax({			
        url:'recontroltemp.do?busidx=5',
        success:function(data){
        	var a = JSON.parse(data);
         },
        error:function(){
           alert("fail")
        }
     });
    setTimeout("card_ajax()",3000);	
}
</script>
        