<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>Eris BIS</title>
  
  
  
  <!-- Bootstrap core CSS-->
  <link href="../adminBoot/admin_vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom fonts for this template-->
  <link href="../adminBoot/admin_vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
  <!-- Page level plugin CSS-->
  <link href="../adminBoot/admin_vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
  <!-- Custom styles for this template-->
  <link href="../adminBoot/admin_css/sb-admin.css" rel="stylesheet">
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
  

</head>

<body class="fixed-nav sticky-footer bg-dark" id="page-top">

	

  <!-- Navigation-->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav" >
    <a class="navbar-brand" href="main.do?service=0"><strong>SBIS  [Seoul Bus Information System]</strong></a>
    <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarResponsive">
      <ul class="navbar-nav navbar-sidenav" id="exampleAccordion">
   
   		 <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Tables">
          <a class="nav-link" href="main.do?service=0">
            <i class="fa fa-fw fa-table"></i>
            <span class="nav-link-text"><strong>전체 차량 조회</strong><br>(ALL Buses)</span>
          </a>
        </li>  
   
        <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Tables">
          <a class="nav-link" href="main.do">
            <i class="fa fa-fw fa-table"></i>
            <span class="nav-link-text"><strong>운행 차량 조회</strong><br>(Buses in Driving)</span>
          </a>
        </li>  
 		 <!-- After click specified bus(in driving) info, -->
       <c:if  test="${allbusInfo !=null}" >  
        <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Components">
          <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#collapseComponents" data-parent="#exampleAccordion">
            <i class="fa fa-fw fa-wrench"></i>
            <span class="nav-link-text"><strong>차량 세부 제어</strong><br>(Bus Detail Controller)</span>
          </a>
          <ul class="sidenav-second-level collapse" id="collapseComponents">
            <li>
              <a href="navbar.do">Frame</a>
            </li>
            <li>
              <a href="cards.do">Other</a>
            </li>
          </ul>
        </li>           
       </c:if>
 		
 		
 		
       
       <!-- After click specified bus(in driving) info, -->
       <c:if  test="${busInfo !=null}" >
		 <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Dashboard">
          <a class="nav-link" href="eachbus.do">
            <i class="fa fa-fw fa-dashboard"></i>
            <span class="nav-link-text"><strong>${busInfo.NUM }차량 현황</strong><br>(Realtime Infomation)</span>
          </a>
        </li>    
        <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Components">
          <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#collapseComponents" data-parent="#exampleAccordion">
            <i class="fa fa-fw fa-wrench"></i>
            <span class="nav-link-text"><strong>${busInfo.NUM } 차량 세부 제어</strong><br>(Bus Detail Controller)</span>
          </a>
          <ul class="sidenav-second-level collapse" id="collapseComponents">
            <li>
              <a href="navbar.do">Frame</a>
            </li>
            <li>
              <a href="cards.do">Other</a>
            </li>
          </ul>
        </li>           
       </c:if>
       <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Tables">
          <a class="nav-link" href="main.do">
            <i class="fa fa-fw fa-table"></i>
            <span class="nav-link-text"><strong>기사님 정보</strong><br>(ALL Driver Information)</span>
          </a>
        </li>
             
      </ul>
      <ul class="navbar-nav sidenav-toggler">
        <li class="nav-item">
          <a class="nav-link text-center" id="sidenavToggler">
            <i class="fa fa-fw fa-angle-left"></i>
          </a>
        </li>
      </ul>
      
      <ul class="navbar-nav ml-auto">
      
      
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle mr-lg-2" id="messagesDropdown" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fa fa-fw fa-envelope"></i>
            <span class="d-lg-none">Messages
              <span class="badge badge-pill badge-primary">${msgsize }</span>
            </span>
            <span class="indicator text-primary d-none d-lg-block">
              <i class="fa fa-fw fa-circle"></i>
            </span>
          </a>
          <div class="dropdown-menu" aria-labelledby="messagesDropdown">
            <h6 class="dropdown-header">New Messages:</h6>
            <div class="dropdown-divider"></div>   
					<c:if test="${list!=null }">
		            	<c:forEach items="${list }" var="i">		            		
		            		 <a class="dropdown-item" href="#">
				              <strong>${i.name }</strong>
				              <span class="small float-right text-muted">${i.time }</span>
				              <div class="dropdown-message small">${i.message }</div>
				             </a>		            	
		            	</c:forEach>
	          	 	</c:if>
        </li>
        
        
        
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle mr-lg-2" id="alertsDropdown" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fa fa-fw fa-bell"></i>
            <span class="d-lg-none">Alerts
              <span class="badge badge-pill badge-warning">6 New</span>
            </span>
            <span class="indicator text-warning d-none d-lg-block">
              <i class="fa fa-fw fa-circle"></i>
            </span>
          </a>
          <div class="dropdown-menu" aria-labelledby="alertsDropdown">
            <h6 class="dropdown-header">New Alerts:</h6>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="#">
              <span class="text-success">
                <strong>
                  <i class="fa fa-long-arrow-up fa-fw"></i>Status Update</strong>
              </span>
              <span class="small float-right text-muted">11:21 AM</span>
              <div class="dropdown-message small">This is an automated server response message. All systems are online.</div>
            </a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="#">
              <span class="text-danger">
                <strong>
                  <i class="fa fa-long-arrow-down fa-fw"></i>Status Update</strong>
              </span>
              <span class="small float-right text-muted">11:21 AM</span>
              <div class="dropdown-message small">This is an automated server response message. All systems are online.</div>
            </a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="#">
              <span class="text-success">
                <strong>
                  <i class="fa fa-long-arrow-up fa-fw"></i>Status Update</strong>
              </span>
              <span class="small float-right text-muted">11:21 AM</span>
              <div class="dropdown-message small">This is an automated server response message. All systems are online.</div>
            </a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item small" href="#">View all alerts</a>
          </div>
        </li>
        <li class="nav-item">
          <a class="nav-link" data-toggle="modal" data-target="#exampleModal2">
            <i class="fa fa-fw fa-sign-out"></i>신규 등록</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" data-toggle="modal" data-target="#exampleModal">
            <i class="fa fa-fw fa-sign-out"></i>로그 아웃</a>
        </li>        
      </ul>
    </div>
  </nav>
    <div class="content-wrapper">
     <div class="container-fluid">
     
     <c:choose>
     	<c:when test="${center==null }">
     		<jsp:include page="testtable.jsp"></jsp:include>   
     	</c:when>
     	<c:otherwise>
     		<jsp:include page="${center }.jsp"></jsp:include> 
     	</c:otherwise>
     </c:choose>
     	</div>
     </div>
    <footer class="sticky-footer">
      <div class="container">
        <div class="text-center">
          <small>Eris Bus Information System</small>
        </div>
      </div>
    </footer>
    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
      <i class="fa fa-angle-up"></i>
    </a>
    
    <!-- Logout Modal-->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">로그아웃</h5>
            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">닫기</span>
            </button>
          </div>
          <div class="modal-body">로그아웃 버튼을 클릭하면 정상적으로 로그아웃이됩니다.</div>
          <div class="modal-footer">
            <button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
            <a class="btn btn-primary" href="logout.do" >로그아웃</a>
          </div>
        </div>
      </div>
    </div>
    
    
     <!-- Register Modal-->
    <div class="modal fade" id="exampleModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel2">등록</h5>
            
            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">닫기</span>
            </button>
            
          </div>
          <div class="modal-body">등록을 원하는 타입을 선택해주세요.</div>
          
          <div class="modal-footer">
            <button class="btn btn-secondary" type="button" data-dismiss="modal" id="registerbus">버스</button>
  			<button class="btn btn-secondary" type="button" data-dismiss="modal" id="registerdriver">기사</button>
          </div>
          
        </div>
      </div>
    </div>

</body>
<script>
$(document).ready(function(){
	var a = "check"+"${result}"; //register check
	if (a !="check"){
		alert("${result }")
	}
	var dt = new Date();
	var month = dt.getMonth()+1;
	var day = dt.getDate();
	var year = dt.getFullYear();
	var hour = dt.getHours();
    var min = dt.getMinutes();
    var present ="업데이트 시간:  "+year+"년 "+month+"월 "+day+"일  "+hour+":"+min;
    $('div[name=updatetime]').html(present)
})

$('#registerbus').click(function(){
	window.location.href="registerbus.do";
})
$('#registerdriver').click(function(){
	window.location.href="registerdriver.do";
})

</script>

 <!-- Bootstrap core JavaScript-->
    <script src="../adminBoot/admin_vendor/jquery/jquery.min.js"></script>
    <script src="../adminBoot/admin_vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Core plugin JavaScript-->
    <script src="../adminBoot/admin_vendor/jquery-easing/jquery.easing.min.js"></script>
    <!-- Page level plugin JavaScript-->
    <script src="../adminBoot/admin_vendor/chart.js/Chart.min.js"></script>
    <script src="../adminBoot/admin_vendor/datatables/jquery.dataTables.js"></script>
    <script src="../adminBoot/admin_vendor/datatables/dataTables.bootstrap4.js"></script>
    <!-- Custom scripts for all pages-->
    <script src="../adminBoot/admin_js/sb-admin.min.js"></script>
    <!-- Custom scripts for this page-->
    <script src="../adminBoot/admin_js/sb-admin-datatables.min.js"></script>
    <script src="../adminBoot/admin_js/sb-admin-charts.min.js"></script>

</html>
