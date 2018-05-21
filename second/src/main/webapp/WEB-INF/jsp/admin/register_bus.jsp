<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<body class="bg-dark">
  <div class="container">
    <div class="card card-register mx-auto mt-5">
      <div class="card-header"><strong>���� ���</strong></div>
      <div class="card-body">
        <form action="registerbusimp.do" method="post" id="busregform">
          <div class="form-group">          
            <div class="form-row">
              <div class="col-md-6">
                <label for="regbusnum">���� ��ȣ</label>
                <input class="form-control" id="regbusnum" type="text" name="NUM" aria-describedby="nameHelp" placeholder="���� ��ȣ �Է�">
              </div>
              <div class="col-md-6">
                <label for="regbusplatenum">���� ��ȣ</label>
                <input class="form-control" id="regbusplatenum" type="text" name="PLATENUM" aria-describedby="nameHelp" placeholder="���� ��ȣ �Է�">
              </div>
            </div>
          <br>
            <div class="form-row">
              <div class="col-md-6">
                <label for="regbusyear">���� ����</label>
                <input class="form-control" id="regbusyear" type="text" name="YEAR" aria-describedby="nameHelp" placeholder="YYYY/MM">
              </div>             
              <div class="col-md-6">
                <label for="regbusenergy">���� ���� Ÿ��</label>
                <input class="form-control" id="regbusenergy" type="text" name="BUSENERGY" aria-describedby="nameHelp" placeholder="���� Ÿ�� �Է�">
              </div>
            </div>
          <br>          
          <div class="form-row">
         	<div class="col-md-6">
                <label for="regbustype">���� Ÿ��</label>
                <input class="form-control" id="regbustype" type="text" name="BUSTYPE" aria-describedby="nameHelp" placeholder="���� Ÿ�� �Է�">
            </div> 
          </div>
          <br>
           <div class="form-row">
              <div class="col-md-6">
                <label for="checkadminid">������ ID</label>
                <input class="form-control" id="checkadminid" type="text" name="id" aria-describedby="nameHelp" placeholder="ID �Է�" value="${adminInfo.ID }">
              </div>             
              <div class="col-md-6">
                <label for="checkadminpwd">������ PWD</label>
                <input class="form-control" id="checkadminpwd" type="password" name="pwd" aria-describedby="nameHelp" placeholder="******">
              </div>
            </div>
            <br>  
          <a class="btn btn-primary btn-block" id="busregsubmit">���</a>
         </div>
        </form>
      </div>
    </div>
  </div>
  <script>
  $("#busregsubmit").click(function(){
	  $("#busregform").submit();
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
