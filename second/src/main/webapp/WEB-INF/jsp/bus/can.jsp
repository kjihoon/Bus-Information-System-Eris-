<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
   <!-- Styles -->
<style>
#chartdiv {
	width	: 100%;
	height	: 500px;
}														
</style>

<!-- Resources -->
<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
<script src="https://www.amcharts.com/lib/3/gauge.js"></script>
<script src="https://www.amcharts.com/lib/3/themes/light.js"></script>
<script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
<link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css" type="text/css" media="all" />

<!-- Chart code -->
<script>
var chart = AmCharts.makeChart( "chartdiv", {
  "theme": "light",
  "type": "gauge",
  "axes": [ {
    "axisColor": "#67b7dc",
    "axisThickness": 3,
    "endValue": 240,
    "gridInside": false,
    "inside": false,
    "radius": "100%",
    "valueInterval": 20,
    "tickColor": "#67b7dc"
  }, {
    "axisColor": "#fdd400",
    "axisThickness": 3,
    "endValue": 160,
    "radius": "80%",
    "valueInterval": 20,
    "tickColor": "#fdd400"
  } ],
  "arrows": [ {
    "color": "#67b7dc",
    "innerRadius": "20%",
    "nailRadius": 0,
    "radius": "85%"
  } ],
  "export": {
    "enabled": true
  }
} );

$(document).ready(function(){	 
	speed_ajax()
});

function speed_ajax() {
	$.ajax({			
        url:'speed.do?busidx=${busidx}',
        success:function(data){
        	
        	var a = JSON.parse(data);
        	chart.arrows[ 0 ].setValue(a.vehiclespeed);
         },
        error:function(){
           alert("fail")
        }
     });
    setTimeout("speed_ajax()",1000);
}


 </script>

<!-- HTML -->
<div id="chartdiv"></div>		