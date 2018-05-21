<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <script src="https://cdn.pubnub.com/sdk/javascript/pubnub.4.19.0.min.js"></script>
    <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" /> -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" />
        
        
        
    <c:choose>

	    <c:when test="${busInfo.SERVICE !='1'}">
	    	 <ol class="breadcrumb">
		        <li class="breadcrumb-item">
		          <a href="#">버스 고유번호: ${busInfo.BUSIDX }</a>
		        </li>
		        <li class="breadcrumb-item active">:${busInfo.NUM }버스는 현재 운행중이 아닙니다.</li>
     		 </ol>
	    </c:when>

	    <c:otherwise>
	     <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="#">버스 고유번호: ${busInfo.BUSIDX }</a>
        </li>
        <li class="breadcrumb-item active">:${busInfo.NUM }버스  ${busInfo.DRIVERIDX }기사님 운행 중</li>
      </ol>
<div class="row">
   <!-- Present Location -->
   <div class="col-lg-8">
    <div class="card mb-3">
	        <div class="card-header">
	          <i class="fa fa-area-chart"></i> 현재 버스 위치  <!--dirveridx 기사님 이름으로 데체  -->
	    	</div>
 		<!-- style="width:600px;height:400px" -->
 			<div id="map-canvas" class="card-body" style="height:450px"></div>
 		</div>
 	</div>
 	<div class="col-lg-4">
        <!-- Example Notifications Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bell-o"></i> ${busInfo.NUM } - 고객 메세지</div>
            <div class="list-group list-group-flush small">
              
              <a class="list-group-item list-group-item-action" href="#">
                <div class="media">
                  <img class="d-flex mr-3 rounded-circle" src="http://placehold.it/45x45" alt="">
                  <div class="media-body">
                    <strong>David Miller</strong>posted a new article to
                    <strong>David Miller Website</strong>.
                    <div class="text-muted smaller">Today at 5:43 PM - 5m ago</div>
                  </div>
                </div>
              </a>
              
              
              <a class="list-group-item list-group-item-action" href="#">
                <div class="media">
                  <img class="d-flex mr-3 rounded-circle" src="http://placehold.it/45x45" alt="">
                  <div class="media-body">
                    <strong>Samantha King</strong>sent you a new message!
                    <div class="text-muted smaller">Today at 4:37 PM - 1hr ago</div>
                  </div>
                </div>
              </a>
              
              <a class="list-group-item list-group-item-action" href="#">
                <div class="media">
                  <img class="d-flex mr-3 rounded-circle" src="http://placehold.it/45x45" alt="">
                  <div class="media-body">
                    <strong>Jeffery Wellings</strong>added a new photo to the album
                    <strong>Beach</strong>.
                    <div class="text-muted smaller">Today at 4:31 PM - 1hr ago</div>
                  </div>
                </div>
              </a>
              
              
              <a class="list-group-item list-group-item-action" href="#">
                <div class="media">
                  <img class="d-flex mr-3 rounded-circle" src="http://placehold.it/45x45" alt="">
                  <div class="media-body">
                    <i class="fa fa-code-fork"></i>
                    <strong>Monica Dennis</strong>forked the
                    <strong>startbootstrap-sb-admin</strong>repository on
                    <strong>GitHub</strong>.
                    <div class="text-muted smaller">Today at 3:54 PM - 2hrs ago</div>
                  </div>
                </div>
              </a>
              <a class="list-group-item list-group-item-action" href="#">View all activity...</a>
            </div>
            <div class="card-footer small text-muted" name="updatetime"></div>
          </div>                     
        </div>        
</div>


	   <!-- Area Chart-->
<div class="row">
<div class="col-lg-8">
 		
 	
 	
 	
      <div class="card mb-3">
        <div class="card-header">
        	<i class="fa fa-area-chart"></i> 실시간 버스 온도 - Temperature</div>
        <div class="card-body">
        	<canvas id="tempChart" width="100%" height="30"></canvas>
        </div>
        	<div class="card-footer small text-muted" name="updatetime"></div>
      </div> 
      
      <div class="card mb-3">
        <div class="card-header">
        	<i class="fa fa-area-chart"></i> 실시간 버스 습도 - Humid</div>
        <div class="card-body">
        	<canvas id="humidChart" width="100%" height="30"></canvas>
        </div>
        	<div class="card-footer small text-muted" name="updatetime"></div>
      </div>
      </div>
</div>
	    
	    </c:otherwise>
    </c:choose>    
        
        
        

           
<script>

//init location (seoul center 37.541° 126.986°)
window.lat =37.541;
window.lng =126.986;
function circlePoint(time) {
	var a=null;
	$.ajax({

		url:'location.do?busidx=${busidx}',
		async: false,
	    success:function(data){
	    	a = JSON.parse(data);
	    	window.lat =a.lat;
	    	window.lng =a.lng;
	    },
	    error:function(){
	  	       alert("fail")
	  	} 
	});
  return {lat:window.lat, lng:window.lng};
};
var map;
var mark;
var initialize = function() {
  map  = new google.maps.Map(document.getElementById('map-canvas'), {center:{lat:lat,lng:lng},zoom:12});
  mark = new google.maps.Marker({position:{lat:lat, lng:lng}, map:map});
};
window.initialize = initialize;

var redraw = function(payload) {
  lat = payload.message.lat;
  lng = payload.message.lng;
  map.setCenter({lat:lat, lng:lng, alt:0});
  mark.setPosition({lat:lat, lng:lng, alt:0});
};

var pnChannel = "map-channel";
var pubnub = new PubNub({
  publishKey:   'pub-c-c4d820e4-5291-4529-ab4e-883bbe172f89',
  subscribeKey: 'sub-c-88b6c428-5a44-11e8-85c6-a6b0a876dba1'
});
pubnub.subscribe({channels: [pnChannel]});
pubnub.addListener({message:redraw});

setInterval(function() {
  pubnub.publish({channel:pnChannel, message:circlePoint(new Date().getTime()/1000)});
}, 2000);
 
</script>
<script>

$(document).ready(function(){
	updateData();
});
function updateData(){
    $.ajax({
        url:'temperature.do?busidx=${busidx}',
        success:function(data){
        	var a = JSON.parse(data);
        	display(a.list);
         },
        error:function(){
           alert("fail")
        }
     });
    setTimeout("updateData()",10000);
}
var ctx = document.getElementById("tempChart");
var ctx2 = document.getElementById("humidChart");

function display(input){
	var myLineChart = new Chart(ctx, {
		  type: 'line',
		  data: {
		    labels: ["11:02", "11:03", "11:04", "11:05", "11:06", "11:07", "11:08", "11:09", "11:10", "11:11", "11:12", "11:13", "11:14"],
		    datasets: [{
		      label: "온도",
		      lineTension: 0.3,
		      backgroundColor: "rgba(255, 0, 0, 0.2)",
		      borderColor: "rgba(255, 0, 0,1)",
		      pointRadius: 5,
		      pointBackgroundColor: "rgba(255, 0, 0,1)",
		      pointBorderColor: "rgba(255,255,255,0.8)",
		      pointHoverRadius: 5,
		      pointHoverBackgroundColor: "rgba(255, 0, 0,1)",
		      pointHitRadius: 20,
		      pointBorderWidth: 2,
		      data:input,
		    }],
		  },
		  options: {
		    scales: {
		      xAxes: [{
		        time: {
		          unit: 'date'
		        },
		        gridLines: {
		          display: false
		        },
		        ticks: {
		          maxTicksLimit: 7
		        }
		      }],
		      yAxes: [{
		        ticks: {
		          min: 0,
		          max: 30,
		          maxTicksLimit: 5
		        },
		        gridLines: {
		          color: "rgba(0, 0, 0, .125)",
		        }
		      }],
		    },
		    legend: {
		      display: false
		    }
		  }
		});
	
	
	var myLineChart2 = new Chart(ctx2, {
		  type: 'line',
		  data: {
		    labels: ["11:02", "11:03", "11:04", "11:05", "11:06", "11:07", "11:08", "11:09", "11:10", "11:11", "11:12", "11:13", "11:14"],
		    datasets: [{
		      label: "습도",
		      lineTension: 0.3,
		      backgroundColor: "rgba(2,117,216,0.2)",
		      borderColor: "rgba(2,117,216,1)",
		      pointRadius: 5,
		      pointBackgroundColor: "rgba(2,117,216,1)",
		      pointBorderColor: "rgba(255,255,255,0.8)",
		      pointHoverRadius: 5,
		      pointHoverBackgroundColor: "rgba(2,117,216,1)",
		      pointHitRadius: 20,
		      pointBorderWidth: 2,
		      data:input,
		    }],
		  },
		  options: {
		    scales: {
		      xAxes: [{
		        time: {
		          unit: 'date'
		        },
		        gridLines: {
		          display: false
		        },
		        ticks: {
		          maxTicksLimit: 7
		        }
		      }],
		      yAxes: [{
		        ticks: {
		          min: 0,
		          max: 30,
		          maxTicksLimit: 5
		        },
		        gridLines: {
		          color: "rgba(0, 0, 0, .125)",
		        }
		      }],
		    },
		    legend: {
		      display: false
		    }
		  }
		});
	
}


</script>
  <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&key=AIzaSyB5ipWIhIaIqQkGI69cV3QZE2WvLjqzTkk
  &callback=initialize"></script>
        