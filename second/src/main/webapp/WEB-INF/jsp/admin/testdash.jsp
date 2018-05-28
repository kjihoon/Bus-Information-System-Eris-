<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <script src="https://cdn.pubnub.com/sdk/javascript/pubnub.4.19.0.min.js"></script>
   <!--  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" /> -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" />
	<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-more.js"></script>
<script src="https://code.highcharts.com/modules/solid-gauge.js"></script>
    
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



<div class="row">
  <div class="col-lg-4">
    <div class="card mb-3">
	        <div class="card-header">
	          <i class="fa fa-area-chart"></i> 현재 온도(℃ )  <!--dirveridx 기사님 이름으로 데체  -->
	    	</div>
			<div class="card-body">
 				<div id="container1" style="height: 250px;"></div>
 			</div>
 		</div>
 	</div>
 	
 	<div class="col-lg-4">
    <div class="card mb-3">
	        <div class="card-header">
	          <i class="fa fa-area-chart"></i> 현재 습도(%) <!--dirveridx 기사님 이름으로 데체  -->
	    	</div>
 		<!-- style="width:600px;height:400px" -->
 			<div class="card-body">
 			  <div id="container2" style="height: 250px;"></div>
 			</div>		
 			
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
	    	window.lat =parseFloat(a.lat);
	    	window.lng =parseFloat(a.lng);
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
  publishKey:   'pub-c-4d4844fb-e278-44eb-8a7e-8e161843c86d',
  subscribeKey: 'sub-c-ec8c7622-6242-11e8-80c7-9a3bcc13c56f'
});
pubnub.subscribe({channels: [pnChannel]});
pubnub.addListener({message:redraw});

setInterval(function() {
  pubnub.publish({channel:pnChannel, message:circlePoint(new Date().getTime()/1000)});
}, 2000);
</script>
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&key=AIzaSyC7MakjzVGHvfEHSH0Mz0n-PhcG3zfAA1w&callback=initialize"></script>


  

<script>

$(document).ready(function(){
	 
	display_ajax()
});
function display_ajax(){
	$.ajax({			
        url:'temperature.do?busidx=${busidx}',
        success:function(data){
        	var a = JSON.parse(data);
        	display(a);
         },
        error:function(){
           alert("fail")
        }
     });
    setTimeout("display_ajax()",2000);
}

function display(input){
	$(function() {

		  var rawData = input.temp,
		    data = getData(rawData);

		  function getData(rawData) {
		    var data = [],
		      start = Math.round(Math.floor(rawData / 10) * 10);
		    data.push(rawData);
		    for (i = start; i > 0; i -= 10) {
		      data.push({
		        y: i
		      });
		    }
		    return data;
		  }

		  Highcharts.chart('container1', {
		    chart: {
		      type: 'solidgauge',
		      marginTop: 10
		    },
		    
		    title: {
		      text: ''
		    },
		    
		    subtitle: {
		      text: rawData,
		      style: {
		        'font-size': '60px'
		      },
		      y: 200,
		      zIndex: 7
		    },

		    tooltip: {
		      enabled: false
		    },

		    pane: [{
		      startAngle: -120,
		      endAngle: 120,
		      background: [{ // Track for Move
		        outerRadius: '100%',
		        innerRadius: '80%',
		        backgroundColor: Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0.3).get(),
		        borderWidth: 0,
		        shape: 'arc'
		      }],
		      size: '120%',
		      center: ['50%', '65%']
		    }, {
		      startAngle: -120,
		      endAngle: 120,
		      size: '95%',
		      center: ['50%', '65%'],
		      background: []
		    }],

		    yAxis: [{
		      min: 0,
		      max: 40,
		      lineWidth: 2,
		      lineColor: 'white',
		      tickInterval: 4,
		      labels: {
		        enabled: false
		      },
		      minorTickWidth: 0,
		      tickLength: 50,
		      tickWidth: 5,
		      tickColor: 'white',
		      zIndex: 6,
		      stops: [
		        [0, '#fff'],
		        [0.101, '#0f0'],
		        [0.201, '#2d0'],
		        [0.301, '#4b0'],
		        [0.401, '#690'],
		        [0.501, '#870'],
		        [0.601, '#a50'],
		        [0.701, '#c30'],
		        [0.801, '#e10'],
		        [0.901, '#f03'],
		        [1, '#f06']
		      ]
		    }, {
		      linkedTo: 0,
		      pane: 1,
		      lineWidth: 5,
		      lineColor: 'white',
		      tickPositions: [],
		      zIndex: 6
		    }],
		    
		    series: [{
		      animation: false,
		      dataLabels: {
		        enabled: false
		      },
		      borderWidth: 0,
		      color: Highcharts.getOptions().colors[0],
		      radius: '100%',
		      innerRadius: '80%',
		      data: data
		    }]
		  });
		});

	$(function() {

		  var rawData = input.humid,
		    data = getData(rawData);

		  function getData(rawData) {
		    var data = [],
		      start = Math.round(Math.floor(rawData / 10) * 10);
		    data.push(rawData);
		    for (i = start; i > 0; i -= 10) {
		      data.push({
		        y: i
		      });
		    }
		    return data;
		  }

		  Highcharts.chart('container2', {
		    chart: {
		      type: 'solidgauge',
		      marginTop: 10
		    },
		    
		    title: {
		      text: ''
		    },
		    
		    subtitle: {
		      text: rawData,
		      style: {
		        'font-size': '60px'
		      },
		      y: 200,
		      zIndex: 7
		    },

		    tooltip: {
		      enabled: false
		    },

		    pane: [{
		      startAngle: -120,
		      endAngle: 120,
		      background: [{ // Track for Move
		        outerRadius: '100%',
		        innerRadius: '80%',
		        backgroundColor: Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0.3).get(),
		        borderWidth: 0,
		        shape: 'arc'
		      }],
		      size: '120%',
		      center: ['50%', '65%']
		    }, {
		      startAngle: -120,
		      endAngle: 120,
		      size: '95%',
		      center: ['50%', '65%'],
		      background: []
		    }],

		    yAxis: [{
		      min: 0,
		      max: 60,
		      lineWidth: 2,
		      lineColor: 'white',
		      tickInterval: 6,
		      labels: {
		        enabled: false
		      },
		      minorTickWidth: 0,
		      tickLength: 50,
		      tickWidth: 5,
		      tickColor: 'white',
		      zIndex: 6,
		      stops: [
		        [0, '#fff'],
		        [0.101, '#0f0'],
		        [0.201, '#2d0'],
		        [0.301, '#4b0'],
		        [0.401, '#690'],
		        [0.501, '#870'],
		        [0.601, '#a50'],
		        [0.701, '#c30'],
		        [0.801, '#e10'],
		        [0.901, '#f03'],
		        [1, '#f06']
		      ]
		    }, {
		      linkedTo: 0,
		      pane: 1,
		      lineWidth: 5,
		      lineColor: 'white',
		      tickPositions: [],
		      zIndex: 6
		    }],
		    
		    series: [{
		      animation: false,
		      dataLabels: {
		        enabled: false
		      },
		      borderWidth: 0,
		      color: Highcharts.getOptions().colors[0],
		      radius: '100%',
		      innerRadius: '80%',
		      data: data
		    }]
		  });
		});
}

</script>
  