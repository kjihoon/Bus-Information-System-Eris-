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
<style>
.alert {
    padding: 20px;
    background-color: #f44336;
    color: white;
    opacity: 1;
    transition: opacity 0.6s;
    margin-bottom: 15px;
}

.alert.success {background-color: #4CAF50;}
.alert.info {background-color: #2196F3;}
.alert.warning {background-color: #ff9800;}

.closebtn {
    margin-left: 15px;
    color: white;
    font-weight: bold;
    float: right;
    font-size: 22px;
    line-height: 20px;
    cursor: pointer;
    transition: 0.3s;
}

.closebtn:hover {
    color: black;
}
</style>
<style>
/* The Modal (background) */
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
    background-color: #fefefe;
    margin: auto;
    padding: 20px;
    border: 1px solid #888;
    width: 60%;
    left: 8%;
}

/* The Close Button */
.close {
    color: #aaaaaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: #000;
    text-decoration: none;
    cursor: pointer;
}
</style>
   <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
</head>
<body>

<div class="row">
 <div class="col-lg-8">
    <div class="card mb-3">
	        <div class="card-header">
	          <i class="fa fa-area-chart"></i> ���� ���� ����  <!--dirveridx ���� �̸����� ��ü  -->
	    	</div>
	    	 <div class="card-body">
		<table >
			<tr>
				<td>Engine Lord Value(%)<h4 id="enginelordvalue"></h4>(normal scope: 0-35)</td>
				<td rowspan="3"><jsp:include page="../bus/can.jsp"></jsp:include></td>
				<td>enginRPM(rpm)<h4 id="enginRPM"></h4>(normal scope: ~13000)</td>
			</tr>
			<tr>
				<td  id="speed"></td>
				<td>MAF<h4 id="MAF"></h4></td>			
			</tr>
			<tr>		
				<td>engineCoolantTemperature(c)<h3 id="engineCoolantTemperature"></h3>(normal scope: 96-110)</td>
				<td>throttlePosition<h4 id="throttlePosition"></h4>(normal scope: ~98</td>
			</tr>
			<tr>
				<td>Forward left<h3>34Psi</h3></td>
				<td rowspan="2"><img src="../img/busgif.gif" style="width:100%;'"></td>
				<td>Forward right<h3>34Psi</h3></td>	
			</tr>
			<tr>
				<td>Back left<h3>34Psi</h3></td>
				<td>Back left<h3>34Psi</h3></td>	
			</tr>
			<tr>
				<td colspan="3" style="text-align:center;">���� ��Ȳ<hr> </td>
			</tr>
		</table>
		</div>
</div>
</div>

 	<div class="col-lg-4">
        <!-- Example Notifications Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bell-o"></i> ${busInfo.NUM } BUS Detail Info</div>
            <div class="list-group list-group-flush small">
              
              <a name="myBtn" id="EngineLord" class="list-group-item list-group-item-action" href="#">
                <div class="media">
                  <img class="d-flex mr-3 rounded-circle" src="/first/img/warning.png" alt="">
                  <div class="media-body">
					 <div class="alert">
					  <span class="closebtn">&times;</span>  
					  <strong>EngineLord Value(���)</strong><br> �̻�ġ �߰�
					</div>     
                  </div>
                </div>
              </a>
              
              <a id="MAF" name="myBtn" class="list-group-item list-group-item-action" href="#">
                <div class="media">
                  <img class="d-flex mr-3 rounded-circle" src="/first/img/low.png" alt="">
                  <div class="media-body">
                    <div class="alert warning">
					  <span class="closebtn">&times;</span>  
					  <strong>EngineLord Value(���)</strong><br> �̻�ġ �߰�
					</div>
                  </div>
                </div>
              </a>

              
              
              <a  class="list-group-item list-group-item-action" href="#">��ü ����</a>
            </div>
            <div class="card-footer small text-muted" name="updatetime"></div>
          </div>                     
        </div>        
</div>

  
        
        
<!-- The Modal -->
<div id="myModal" class="modal">

  <!-- Modal content -->
  
  <div class="modal-content">
    <span id="closeModal" class="close">&times;</span>
     <div class="container-fluid">
      <div class="card mb-3">
  			<h2 id="itemName" style="text-align:center;"></h2>
			<h4 id="itemName" style="text-align:center;">Result of Analysis</h4>
			<img src="../img/Rplot.png">
    </div>
    </div>
  </div>

</div>


</body>
<script>

$(document).ready(function(){	 
	can_ajax()
});
function can_ajax(){
	$.ajax({			
        url:'candata.do?busidx=${busidx}',
        success:function(data){
        	var a = JSON.parse(data);
        	$("#enginelordvalue").html(a.engineLoadValue);
        	$("#engineCoolantTemperature").html(a.engineCoolantTemperature);
        	$("#enginRPM").html(a.enginRPM);
        	$("#MAF").html(a.MAF);
        	$("#throttlePosition").html(a.throttlePosition);
        	
         },
        error:function(){
           alert("fail")
        }
     });
    setTimeout("can_ajax()",5000);
}


var a =1;
function aa(){
	var speed =Math.floor((Math.random() * 30) + 50);
	$('#speed').html("EngineLordValue<h4>"+speed+"%</h4>")
	if (a==1){
		$('#speed').css("color","red");
		a=2;
	}else{
		$('#speed').css("color","black");
		a=1;
	}
	setTimeout("aa()",500);
}
$(document).ready(function(){
	aa();
})
</script>
<script>
$(".closebtn").click(function(){
	var div = $(this).closest("div")
	var a = $(this).closest("a")
	div.css("opacity","0");
	a.css("opacity","0");
    setTimeout(function(){ 
    	div.css("display","none");
    	a.css("display","none");
    }, 500);
})

$("a[name=myBtn]").click(function(){
	var modal = $('#myModal')
	var btn = $(this)
	$("#itemName").html($(this).attr('id'))
	modal.css("display","block")
})
var modal = document.getElementById('myModal');
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
var span = document.getElementsByClassName("close")[0];
span.onclick = function() {
    modal.style.display = "none";
}

</script>
</html>