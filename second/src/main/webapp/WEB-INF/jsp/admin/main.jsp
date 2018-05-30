<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Eris BIS</title>
  
  <style>
  
body{
    background:#f9f9fb;    
}
.view-account{
    background:#FFFFFF; 
    margin-top:20px;
}
.view-account .pro-label {
    font-size: 13px;
    padding: 4px 5px;
    position: relative;
    top: -5px;
    margin-left: 10px;
    display: inline-block
}

.view-account .side-bar {
    padding-bottom: 30px
}

.view-account .side-bar .user-info {
    text-align: center;
    margin-bottom: 15px;
    padding: 30px;
    color: #616670;
    border-bottom: 1px solid #f3f3f3
}

.view-account .side-bar .user-info .img-profile {
    width: 120px;
    height: 120px;
    margin-bottom: 15px
}

.view-account .side-bar .user-info .meta li {
    margin-bottom: 10px
}

.view-account .side-bar .user-info .meta li span {
    display: inline-block;
    width: 100px;
    margin-right: 5px;
    text-align: right
}

.view-account .side-bar .user-info .meta li a {
    color: #616670
}

.view-account .side-bar .user-info .meta li.activity {
    color: #a2a6af
}

.view-account .side-bar .side-menu {
    text-align: center
}

.view-account .side-bar .side-menu .nav {
    display: inline-block;
    margin: 0 auto
}

.view-account .side-bar .side-menu .nav>li {
    font-size: 14px;
    margin-bottom: 0;
    border-bottom: none;
    display: inline-block;
    float: left;
    margin-right: 15px;
    margin-bottom: 15px
}

.view-account .side-bar .side-menu .nav>li:last-child {
    margin-right: 0
}

.view-account .side-bar .side-menu .nav>li>a {
    display: inline-block;
    color: #9499a3;
    padding: 5px;
    border-bottom: 2px solid transparent
}

.view-account .side-bar .side-menu .nav>li>a:hover {
    color: #616670;
    background: none
}

.view-account .side-bar .side-menu .nav>li.active a {
    color: #40babd;
    border-bottom: 2px solid #40babd;
    background: none;
    border-right: none
}

.theme-2 .view-account .side-bar .side-menu .nav>li.active a {
    color: #6dbd63;
    border-bottom-color: #6dbd63
}

.theme-3 .view-account .side-bar .side-menu .nav>li.active a {
    color: #497cb1;
    border-bottom-color: #497cb1
}

.theme-4 .view-account .side-bar .side-menu .nav>li.active a {
    color: #ec6952;
    border-bottom-color: #ec6952
}

.view-account .side-bar .side-menu .nav>li .icon {
    display: block;
    font-size: 24px;
    margin-bottom: 5px
}

.view-account .content-panel {
    padding: 30px
}

.view-account .content-panel .title {
    margin-bottom: 15px;
    margin-top: 0;
    font-size: 18px
}

.view-account .content-panel .fieldset-title {
    padding-bottom: 15px;
    border-bottom: 1px solid #eaeaf1;
    margin-bottom: 30px;
    color: #616670;
    font-size: 16px
}

.view-account .content-panel .avatar .figure img {
    float: right;
    width: 64px
}

.view-account .content-panel .content-header-wrapper {
    position: relative;
    margin-bottom: 30px
}

.view-account .content-panel .content-header-wrapper .actions {
    position: absolute;
    right: 0;
    top: 0
}

.view-account .content-panel .content-utilities {
    position: relative;
    margin-bottom: 30px
}

.view-account .content-panel .content-utilities .btn-group {
    margin-right: 5px;
    margin-bottom: 15px
}

.view-account .content-panel .content-utilities .fa {
    font-size: 16px;
    margin-right: 0
}

.view-account .content-panel .content-utilities .page-nav {
    position: absolute;
    right: 0;
    top: 0
}

.view-account .content-panel .content-utilities .page-nav .btn-group {
    margin-bottom: 0
}

.view-account .content-panel .content-utilities .page-nav .indicator {
    color: #a2a6af;
    margin-right: 5px;
    display: inline-block
}

.view-account .content-panel .mails-wrapper .mail-item {
    position: relative;
    padding: 10px;
    border-bottom: 1px solid #f3f3f3;
    color: #616670;
    overflow: hidden
}

.view-account .content-panel .mails-wrapper .mail-item>div {
    float: left
}

.view-account .content-panel .mails-wrapper .mail-item .icheck {
    background-color: #fff
}

.view-account .content-panel .mails-wrapper .mail-item:hover {
    background: #f9f9fb
}

.view-account .content-panel .mails-wrapper .mail-item:nth-child(even) {
    background: #fcfcfd
}

.view-account .content-panel .mails-wrapper .mail-item:nth-child(even):hover {
    background: #f9f9fb
}

.view-account .content-panel .mails-wrapper .mail-item a {
    color: #616670
}

.view-account .content-panel .mails-wrapper .mail-item a:hover {
    color: #494d55;
    text-decoration: none
}

.view-account .content-panel .mails-wrapper .mail-item .checkbox-container,
.view-account .content-panel .mails-wrapper .mail-item .star-container {
    display: inline-block;
    margin-right: 5px
}

.view-account .content-panel .mails-wrapper .mail-item .star-container .fa {
    color: #a2a6af;
    font-size: 16px;
    vertical-align: middle
}

.view-account .content-panel .mails-wrapper .mail-item .star-container .fa.fa-star {
    color: #f2b542
}

.view-account .content-panel .mails-wrapper .mail-item .star-container .fa:hover {
    color: #868c97
}

.view-account .content-panel .mails-wrapper .mail-item .mail-to {
    display: inline-block;
    margin-right: 5px;
    min-width: 120px
}

.view-account .content-panel .mails-wrapper .mail-item .mail-subject {
    display: inline-block;
    margin-right: 5px
}

.view-account .content-panel .mails-wrapper .mail-item .mail-subject .label {
    margin-right: 5px
}

.view-account .content-panel .mails-wrapper .mail-item .mail-subject .label:last-child {
    margin-right: 10px
}

.view-account .content-panel .mails-wrapper .mail-item .mail-subject .label a,
.view-account .content-panel .mails-wrapper .mail-item .mail-subject .label a:hover {
    color: #fff
}

.view-account .content-panel .mails-wrapper .mail-item .mail-subject .label-color-1 {
    background: #f77b6b
}

.view-account .content-panel .mails-wrapper .mail-item .mail-subject .label-color-2 {
    background: #58bbee
}

.view-account .content-panel .mails-wrapper .mail-item .mail-subject .label-color-3 {
    background: #f8a13f
}

.view-account .content-panel .mails-wrapper .mail-item .mail-subject .label-color-4 {
    background: #ea5395
}

.view-account .content-panel .mails-wrapper .mail-item .mail-subject .label-color-5 {
    background: #8a40a7
}

.view-account .content-panel .mails-wrapper .mail-item .time-container {
    display: inline-block;
    position: absolute;
    right: 10px;
    top: 10px;
    color: #a2a6af;
    text-align: left
}

.view-account .content-panel .mails-wrapper .mail-item .time-container .attachment-container {
    display: inline-block;
    color: #a2a6af;
    margin-right: 5px
}

.view-account .content-panel .mails-wrapper .mail-item .time-container .time {
    display: inline-block;
    text-align: right
}

.view-account .content-panel .mails-wrapper .mail-item .time-container .time.today {
    font-weight: 700;
    color: #494d55
}

.drive-wrapper {
    padding: 15px;
    background: #f5f5f5;
    overflow: hidden
}

.drive-wrapper .drive-item {
    width: 130px;
    margin-right: 15px;
    display: inline-block;
    float: left
}

.drive-wrapper .drive-item:hover {
    box-shadow: 0 1px 5px rgba(0, 0, 0, .1);
    z-index: 1
}

.drive-wrapper .drive-item-inner {
    padding: 15px
}

.drive-wrapper .drive-item-title {
    margin-bottom: 15px;
    max-width: 100px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis
}

.drive-wrapper .drive-item-title a {
    color: #494d55
}

.drive-wrapper .drive-item-title a:hover {
    color: #40babd
}

.theme-2 .drive-wrapper .drive-item-title a:hover {
    color: #6dbd63
}

.theme-3 .drive-wrapper .drive-item-title a:hover {
    color: #497cb1
}

.theme-4 .drive-wrapper .drive-item-title a:hover {
    color: #ec6952
}

.drive-wrapper .drive-item-thumb {
    width: 100px;
    height: 80px;
    margin: 0 auto;
    color: #616670
}

.drive-wrapper .drive-item-thumb a {
    -webkit-opacity: .8;
    -moz-opacity: .8;
    opacity: .8
}

.drive-wrapper .drive-item-thumb a:hover {
    -webkit-opacity: 1;
    -moz-opacity: 1;
    opacity: 1
}

.drive-wrapper .drive-item-thumb .fa {
    display: inline-block;
    font-size: 36px;
    margin: 0 auto;
    margin-top: 20px
}

.drive-wrapper .drive-item-footer .utilities {
    margin-bottom: 0
}

.drive-wrapper .drive-item-footer .utilities li:last-child {
    padding-right: 0
}

.drive-list-view .name {
    width: 60%
}

.drive-list-view .name.truncate {
    max-width: 100px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis
}

.drive-list-view .type {
    width: 15px
}

.drive-list-view .date,
.drive-list-view .size {
    max-width: 60px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis
}

.drive-list-view a {
    color: #494d55
}

.drive-list-view a:hover {
    color: #40babd
}

.theme-2 .drive-list-view a:hover {
    color: #6dbd63
}

.theme-3 .drive-list-view a:hover {
    color: #497cb1
}

.theme-4 .drive-list-view a:hover {
    color: #ec6952
}

.drive-list-view td.date,
.drive-list-view td.size {
    color: #a2a6af
}

@media (max-width:767px) {
    .view-account .content-panel .title {
        text-align: center
    }
    .view-account .side-bar .user-info {
        padding: 0
    }
    .view-account .side-bar .user-info .img-profile {
        width: 60px;
        height: 60px
    }
    .view-account .side-bar .user-info .meta li {
        margin-bottom: 5px
    }
    .view-account .content-panel .content-header-wrapper .actions {
        position: static;
        margin-bottom: 30px
    }
    .view-account .content-panel {
        padding: 0
    }
    .view-account .content-panel .content-utilities .page-nav {
        position: static;
        margin-bottom: 15px
    }
    .drive-wrapper .drive-item {
        width: 100px;
        margin-right: 5px;
        float: none
    }
    .drive-wrapper .drive-item-thumb {
        width: auto;
        height: 54px
    }
    .drive-wrapper .drive-item-thumb .fa {
        font-size: 24px;
        padding-top: 0
    }
    .view-account .content-panel .avatar .figure img {
        float: none;
        margin-bottom: 15px
    }
    .view-account .file-uploader {
        margin-bottom: 15px
    }
    .view-account .mail-subject {
        max-width: 100px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis
    }
    .view-account .content-panel .mails-wrapper .mail-item .time-container {
        position: static
    }
    .view-account .content-panel .mails-wrapper .mail-item .time-container .time {
        width: auto;
        text-align: left
    }
}

@media (min-width:768px) {
    .view-account .side-bar .user-info {
        padding: 0;
        padding-bottom: 15px
    }
    .view-account .mail-subject .subject {
        max-width: 200px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis
    }
}

@media (min-width:992px) {
    .view-account .content-panel {
        min-height: 800px;
        border-left: 1px solid #f3f3f7;
        margin-left: 200px
    }
    .view-account .mail-subject .subject {
        max-width: 280px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis
    }
    .view-account .side-bar {
        position: absolute;
        width: 200px;
        min-height: 600px
    }
    .view-account .side-bar .user-info {
        margin-bottom: 0;
        border-bottom: none;
        padding: 30px
    }
    .view-account .side-bar .user-info .img-profile {
        width: 120px;
        height: 120px
    }
    .view-account .side-bar .side-menu {
        text-align: left
    }
    .view-account .side-bar .side-menu .nav {
        display: block
    }
    .view-account .side-bar .side-menu .nav>li {
        display: block;
        float: none;
        font-size: 14px;
        border-bottom: 1px solid #f3f3f7;
        margin-right: 0;
        margin-bottom: 0
    }
    .view-account .side-bar .side-menu .nav>li>a {
        display: block;
        color: #9499a3;
        padding: 10px 15px;
        padding-left: 30px
    }
    .view-account .side-bar .side-menu .nav>li>a:hover {
        background: #f9f9fb
    }
    .view-account .side-bar .side-menu .nav>li.active a {
        background: #f9f9fb;
        border-right: 4px solid #40babd;
        border-bottom: none
    }
    .theme-2 .view-account .side-bar .side-menu .nav>li.active a {
        border-right-color: #6dbd63
    }
    .theme-3 .view-account .side-bar .side-menu .nav>li.active a {
        border-right-color: #497cb1
    }
    .theme-4 .view-account .side-bar .side-menu .nav>li.active a {
        border-right-color: #ec6952
    }
    .view-account .side-bar .side-menu .nav>li .icon {
        font-size: 24px;
        vertical-align: middle;
        text-align: center;
        width: 40px;
        display: inline-block
    }
}
.module {
    border: 1px solid #f3f3f3;
    border-bottom-width: 2px;
    background: #fff;
    margin-bottom: 30px;
    position: relative;
    border-radius: 4px;
    background-clip: padding-box;
}
.module .module-footer {
    background: #fff;
    border-top: 1px solid #f3f3f7;
    padding: 15px;
}
.module .module-footer a {
    color: #9499a3;
}
  </style>
      <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
  <!-- Bootstrap core CSS-->
  <link href="../adminBoot/admin_vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom fonts for this template-->
  <link href="../adminBoot/admin_vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
  <!-- Page level plugin CSS-->
  <link href="../adminBoot/admin_vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
  <!-- Custom styles for this template-->
  <link href="../adminBoot/admin_css/sb-admin.css" rel="stylesheet">
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<style>

/*nav col  */
 .navbar-custom {
    background-color:   #41848F   ;
}
/* text col in nav */
/* change the brand and text color */
.navbar-custom .navbar-brand,
.navbar-custom .navbar-text {
    color: #fff;
}
/* change the link color */
.navbar-custom .navbar-nav .nav-link {
    color: #fff;
}

/* hoover col  */
/* change the color of active or hovered links */
.navbar-custom .nav-item.active .nav-link,
.navbar-custom .nav-item:hover .nav-link {
    color:    #0A555C;
} 

.navbar-sidenav{
 background-color:   #41848F   ;
}
.navbar-toggler{
	background-color:	 #72A7A3;
}
.navbar-toggler-icon{
background-color:	 #EBE2B3;
}
.nav-item{
background-color:	 #41848F;
border-color: coral;
}
div .card-header{
 background-color:     #EBE2B3     ;
}
.breadcrumb{
background-color: #97C0B7;
}
</style>
</head>

<body class="fixed-nav sticky-footer bg-dark" id="page-top">

	

  <!-- Navigation-->
  <!-- "navbar navbar-expand-lg navbar-custom" -->
  <nav class="navbar navbar-expand-lg navbar-custom fixed-top" id="mainNav">
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
              <a href="busdash.do">Detail Information</a>
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
