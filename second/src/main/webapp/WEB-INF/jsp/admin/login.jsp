<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>Admin - Login page</title>
  <!-- Bootstrap core CSS-->
  <link href="../adminBoot/admin_vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom fonts for this template-->
  <link href="../adminBoot/admin_vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
  <!-- Page level plugin CSS-->
  <link href="../adminBoot/admin_vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
  <!-- Custom styles for this template-->
  <link href="../adminBoot/admin_css/sb-admin.css" rel="stylesheet">

</head>

<body class="bg-dark">
  <div class="container">
    <div class="card card-login mx-auto mt-5">
      <div class="card-header">관리자 계정 로그인</div>
      <div class="card-body">
        
        
        <form action="loginimp.do" id="adminlogin" method="post">
          <div class="form-group">
            <label for="exampleInputEmail1">ID</label>
            <input class="form-control" id="exampleInputEmail1" type="text" aria-describedby="emailHelp" placeholder="ID 입력" name="id">
          </div>
          <div class="form-group">
            <label for="exampleInputPassword1">Password</label>
            <input class="form-control" id="exampleInputPassword1" type="password" placeholder="비밀번호 입력" name="pwd">
          </div>
          <div class="form-group">
            <div class="form-check">
              <label class="form-check-label">
                <input class="form-check-input" type="checkbox"> Remember Password</label>
            </div>
          </div>
          <a class="btn btn-primary btn-block" id="loginsubmit">Login</a>
          <div id="loginsubmit2"></div>
        </form>
       
       
        <div class="text-center">
       <!--    <a class="d-block small mt-3" href="register.html">Register an Account</a> -->
           <a class="nav-link" data-toggle="modal" data-target="#forgot">
            <i class="fa fa-fw fa-sign-out"></i>ID,PWD를 잊으셨너요?</a>
        </div>
      </div>
    </div>
  </div>
  
  <!--forgot model  -->
  <div class="modal fade" id="forgot" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">서버 관리 연락처</h5>
            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">닫기</span>
            </button>
          </div>
          <div class="modal-body">010-xxx-xxxx로 연락 부탁드립니다. (서버팀: 곽지훈)</div>

        </div>
      </div>
    </div>
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
</body>


<script>
$("#loginsubmit").on("click",function(){
	$("#adminlogin").submit();
})
var a = "check"+"${result}";
if (a !="check"){
	alert("${result }")
}


</script>

</html>
    