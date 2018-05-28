<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-more.js"></script>
<script src="https://code.highcharts.com/modules/solid-gauge.js"></script>
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<div id="container" style="height: 300px;">
</div>


<script>
$(function() {

	  var rawData = 30,
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

	  Highcharts.chart('container', {
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
	      max: 100,
	      lineWidth: 2,
	      lineColor: 'white',
	      tickInterval: 10,
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


</script>