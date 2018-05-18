<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
      <!-- Example DataTables Card-->
      <div class="card mb-3">
        <div class="card-header">
          <i class="fa fa-table"></i>Current Buses in service.</div>
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
              <thead>
                <tr>
                  <th>BUS FLATENUM<th>
                  <th>Driver Name</th>
                  <th>Bus Number</th>
                  <th>Location(lat)</th>
				  <th>Location(lon)</th>
                  <th>Total Service Time</th>                 
                </tr>
              </thead>
              <tfoot>
                <tr>
                 <th>BUS FLATENUM<th>
                 <th>Driver Name</th>
                  <th>Bus Number</th>
                  <th>Location(lat)</th>
				  <th>Location(lon)</th>
                  <th>Bus Type</th>                 
                </tr>
              </tfoot>
              <tbody>
               <c:forEach items="${allbus }" var="bus">
               <tr>
              	 <td><span class="dirveridx" id="bidx${bus.BUSIDX }">${bus.PLATENUM }</span><td>
                  	<td>${bus.DRIVERIDX }</td>
                 	<td>${bus.NUM }</td>
                 	<td>${bus.LAT}</td>
                  	<td>${bus.LON}</td>
                  <td>${bus.BUSTYPE }</td>
               </tr>
               </c:forEach>              
              </tbody>
            </table>
          </div>
        </div>
        <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
      </div>
     <script>
      $('.dirveridx').click(function(){
    	  var id = $(this).attr('id')
    	  id = id.slice(4)    	  
    	  window.location.href="dash.do?busidx="+id
    	  
      })   
      
     </script>