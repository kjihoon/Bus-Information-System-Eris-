<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<head>
	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    <script src="https://cdn.pubnub.com/sdk/javascript/pubnub.4.19.0.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" />
</head>

  <h1>Present Bus Location</h1>
  <div id="map-canvas" style="width:600px;height:400px"></div> 



<script>





window.lat =37;
window.lng =127;
function circlePoint(time) {

	//radom number »ý¼º  lat,lon
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
  <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCWeKRv1aUXjjhW8FelJWw4FLH6rIzU5eA
  &callback=initMap"  type="text/javascript"></script>