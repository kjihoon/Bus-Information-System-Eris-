<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
      <!-- Example DataTables Card-->
      <div class="card mb-3">
        <div class="card-header">
          <i class="fa fa-table"></i>���� ��Ȳ</div>
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
              <thead>
                <tr>
                  <th>���� ������ȣ(IDX)</th>
                  <th>���� ��ȣ</th>
                  <th>���� ��ȣ</th>
                  <th>������ ��</th>                  
                  <th>�� ��ġ(lat)</th>
				  <th>�� ��ġ(lon)</th>
                  <th>���� ����</th>             
                </tr>
              </thead>
              <tfoot>
                <tr>
                 <th>���� ������ȣ(IDX)</th>
                 <th>���� ��ȣ</th>
                 <th>���� ��ȣ</th>
                 <th>������ ��</th>                  
                  <th>�� ��ġ(lat)</th>
				  <th>�� ��ġ(lon)</th>
                  <th>���� ����</th>   
                </tr>
              </tfoot>
              <tbody>
               <c:forEach items="${allbus }" var="bus">
               <tr>
               		<td class="dirveridx" name="bidx${bus.BUSIDX }">${bus.BUSIDX }</td>
              	    <td class="dirveridx" name="bidx${bus.BUSIDX }">${bus.NUM }</td>
                 	<td class="dirveridx" name="bidx${bus.BUSIDX }">${bus.PLATENUM }</td>
                 	<td class="dirveridx" name="bidx${bus.BUSIDX }">${bus.DRIVERIDX }</td>
                 	<td class="dirveridx" name="bidx${bus.BUSIDX }">${bus.LAT}</td>
                  	<td class="dirveridx" name="bidx${bus.BUSIDX }">${bus.LON}</td>
                  <td class="dirveridx" name="bidx${bus.BUSIDX }">${bus.SERVICE }</td>
               </tr>
               </c:forEach>              
              </tbody>
            </table>
          </div>
        </div>
        <div class="card-footer small text-muted" name="updatetime"></div>
      </div>
     <script>
      $('.dirveridx').click(function(){
    	  var id = $(this).attr('name')
    	  id = id.slice(4)    	  
    	  window.location.href="dash.do?busidx="+id
    	  
      })   
	
    
     </script>