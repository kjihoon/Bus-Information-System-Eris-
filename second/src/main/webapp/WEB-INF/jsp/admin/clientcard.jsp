<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<style>
body, html {
    height: 100%;
    margin: 0;
        /* The image used */
    background-image: url("../img/cardback.png");

    /* Full height */
    height: 100%; 

    /* Center and scale the image nicely */
    background-position: center;
    background-repeat: no-repeat;
     background-attachment: fixed;
    background-size: cover;
}

.alert-danger{
background-color: rgba( 255, 31, 0, 0.3 );
border :rgba( 255, 31, 0, 0.3 );
}
.alert-info{
background-color: rgba( 192,192,192, 0.3 );
border :rgba( 255, 31, 0, 0.3 );
color: black;
}
.alert i{
font-size:20px;
}
.alerttime{
 float:right;
}
.div p{
margin:auto;

}
.msg{
text-align:center;
}
</style>

</head>
<body>

<div class="container">
	<h1 style="color:white;">blank</h1>
  <div class="msgsection"></div>
</div>

</body>
<script>
$(document).ready(function(){
	aa();	
	card_ajax()
	

})

function card_ajax(){
	$.ajax({			
        url:'clientcard.do?busidx=5',
        success:function(data){
        	var a = JSON.parse(data);
        	addcard(a.msg)
         },
        error:function(){
           alert("fail")
        }
     });
    setTimeout("card_ajax()",3000);
}


var a=1;
function aa(){
	if (a==1){
		$(".importancemsg").css('color','rgb( 230, 31, 0');
		a=2
	}else{
		$(".importancemsg").css('color','black');
		a=1
	}
	setTimeout("aa()",1000)
}

function addcard(msg){
	if(msg==1){
		$(".msgsection").prepend(    		
	    		"<div class='alert alert-info' name='tempdown'>"+
			    "<div style='font-size:17px;'>"+
			    "<i class='fa fa-comments-o'></i>"+
			   "<strong>¿äÃ»(½Â°´)</strong>"+
			  "<div class='alerttime'>hh:mm</div>"+
			  "<div class='msg'> <p><img class='tempdown'>½Â°´ÀÌ <span style='font-size:130%;'>¿ÂµµÇÏ°­</span> ¿äÃ»À» ÇÏ¿´½À´Ï´Ù.</p></div>"+
			   "</div>"+
			  "</div>"
	    		);
	    $(".tempdown").attr('src',"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAJsSURBVGhD7ZlNaxNRFIazs+u6EgoKZtHaxpaYuUk3TueOhYIbddk/UcWFILgSXCv+hW78oLabppRWikIhSJNW00naGa10o6DF0pvaXcZ7wxFyx2NJQsmcGfLAC6X3ncN7uJ+QRI8eEWNrd3egWPWeF6vuR6VS1X32wfl6AYajwUbZTcrw30tVz9flflNjYKOPnIm3/zbxV+4y2GhTcJzzxYpbx5vwfDVWLu/3g50um443gjXQLOUBO122Kl4KC98s5QE7XbBGXiytaVp8V7DBTheskaezc5peLb+/A3a6YI0srK1rWi1sXAc7XWK9R2IzI7HZI5E8tdx8fjzYSFDKA3a67D95PLUz/8ZvljOna+/hg9tgp4uwc6mazfxmrQ8OatrJXKW/R7BGSqlhTR5L3wQ7XbBGglIesNMFa+TAzGj6xXNpsNMl1nukMDSkyWWjt8BOl1jvkaAi20hsllZsNnvkjt9DK31ZBl8JNoJo5cTMXoLPaCEsxmvcOEBC4+Lsp7CzE/A5DY6t7DXB2TEa+BQ1vrHYKJQJF980+4Rt7GFBW5Fs5nN9KnkOyoWH4MZ9LGA7ks3chXLhIdd6BQvXlrjhQLlwODRzSTRYBwr1FBM8O4mF6kSqFpTtPnKTT2OhOpGqBWW7z5nOiJ25AWW7D9zkaLB2FfpNfyanlm1sQ7nwEDa7h4drXXKJzkC58FC3srwUv2ABW5RH4mZX1CaNsU7fWurZD2VooF6y6kWLBf6PfhxZBs2fF9TJI58br+W+qSPBG4Kxl7+t8YvwGV2EZQzLk+iRXDp5OUuflBp/y/8dcXYFbD160CeR+AOQp3IUiA92hwAAAABJRU5ErkJggg==");
	}else if(msg==2){
	    $(".msgsection").prepend(
	    		"<div class='alert alert-info' name='tempup'>"+
			    "<div style='font-size:17px;'>"+
			    "<i class='fa fa-comments-o'></i>"+
			   "<strong>¿äÃ»(½Â°´)</strong>"+
			  "<div class='alerttime'>hh:mm</div>"+
			  "<div class='msg'> <p><img class='tempup'>½Â°´ÀÌ <span style='font-size:130%;'>¿Âµµ»ó½Â</span> ¿äÃ»À» ÇÏ¿´½À´Ï´Ù.</p></div>"+
			   "</div>"+
			  "</div>"
	    		);
	    $(".tempup").attr('src',"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAOBSURBVGhD7VpdSBRRGDWCHuqlt956qdcgeq0oop2Z/ZEk0CKkoLDEINFe7CXD0J2ZddMs2iUjoaTM6sEeLItI192ZWVvRzP5Q09gWIyIrtd1Z3Z3uZ3fBn+u2Ezh7ozlwYJn5zuEcZ+7M7sUcE38AK0jbWKfksruCHXYh2MHwsgjH8Gn6YXH1r7OLSgvLS8ni6wOqq31MAxY3vYzBMZuo3HZUhtbicTqRXzm4xuGSfQcv9apdw5Pa6LfkAnYOTWpwDmbyW1tXYxl9YHm5PO9Cj9oXiS0pkSKc2+cOxi1OqQzLKIOmrUK31OdGX4RYYD6vdkU0u6CMgwar6QFTI21GV0Tr/Rglhp/PUDiqwSwn+jf9VlMES7W0HcKNTCSI4ecTZmAWNFhODzhe3gHhSMED76e0h4MTCwizjChxWE4P0hUp9PTNBV9MrkYuwXJ6kK4IiXNFkAbL6YFZhDakK2Iu9mzgv7i1SDSLrDRg4UK4xYt6OcIsnYsdLVwIp4d0LnZcxBtKZESzyEqD4eUivUWYan8RltMDzinlLldE7JzUqh5PLCDMsnx3AZbTg9Tjl1Rkf8M/+GYnFSFxrgjNL0RSaBLNIiuNdEWWW+xUf40nFTEXu9GAjWuroEj76nrjpNAkwixoQIttsgvYjOYExZ9XH1Lr/VFiaBJhFjRWkZINbdiMtrmC8bpA5iVSBI1dDMZZp1yK7bKDXXXP1qOrEa1o+0QMmgkr2sY18AAvbGs8GKdy3FHbo3pCs8SQmRC0DnePyvHSMWxrPGxi8GlJ80iSFFAPT9wcTlpdyhNsazxQkfCZB39/W6UItyZ4YVvjgd4F8aqOr8RwengOeYAXtjUenKj8ONv+hRhOD8HDKsjfsa3xQI/dodP3I8RweggeNpfyFtsaDwsvNxR6X6mkcHp4yDugMoJ0EdsaD/Qi280KcsLtmyYGzIS1vikNPFhB2YltswOrqASOXHszQwqZCQ83vp5BHt3YLnuwiP6t6C+qlt8L636flN0NJ5E2ZnVKW7BddsHUyAfQ4zNReudD0kMIvJgwc6plLAkalpfo2klhhICD5ZWfBVdexM6jX4De54QS6Bj8Oiy43K+iKzHNOhU7ltOFvXz3RnS/N8M/z+S6e2JHm97Nnrw1qgHhM3wvY9A5TpRvwCyW0Ys91fIG2HlE9KBij4DwGY7BOTxmYilycn4BqoaxwRFlZRYAAAAASUVORK5CYII=")	

	}else if (msg==3){
	    $(".msgsection").prepend(
	    		"<div class='alert alert-info' name='speeddown'>"+
			    "<div style='font-size:17px;'>"+
			    "<i class='fa fa-comments-o'></i>"+
			   "<strong>¿äÃ»(½Â°´)</strong>"+
			  "<div class='alerttime'>hh:mm</div>"+
			  "<div class='msg'> <p><img class='speeddown'>½Â°´ÀÌ <span style='font-size:130%;'>¼Óµµ°¨¼Ò</span> ¿äÃ»À» ÇÏ¿´½À´Ï´Ù.</p></div>"+
			   "</div>"+
			  "</div>"
	    		);
	    $(".speeddown").attr('src',"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAVcSURBVGhD7Zl3qHM1HEDr3nvg9hMV98YJ7o0oirgnKoIDB04UJ6K4Ebcf+pe4FfcW996oqLhx4d57npM0vrTv3ra37XtfwR44kKTtbZPcm/zya23IkCFD/rfMgOvhoXg+3oD31b0TL8eTcFtcCAeKWXBfvB//wH/q/o7v4xv4Ir6DP2F6Xd/EM3AZnGTMi+fh9+iP+gQvxp1xUZwSi5gDN8Lj8Cn8C/38g7ghjhtT47H4A/ojbsWNcXLshoXxFPwS7dC9uDiOKUvjC5hGcCXsFzPjCfhz3QNxTNgSnYXvcA8bOsQFYLFY7Ahn41F0sK7BabFv7IN/4uvY7kcdjVvHYuBUdAASjvwVOH+oFePz5SJgZx5CP9Mzu6PPwiM4mw1tcIV6NhYDF6E/KLELWl8n1Frj7eV3extPb0O3rI/OxJNYNirP4+mxGDgLXXoTW+FVsRg4G52haUKtVlsSv8W1Q200+6Edd0+azIaqOPWf4bs4uw0lXInuH0uEWq02K64Zi4XMjavEYuA29OFeMNSKSbfZ4aFWkdvxF1wx1EZwiteNxYAdfg5XCLXq+EAfHIuBBXDZWPyPKfAB/A0rbZ7boSNwTKg1sj36mg9xv7EDn+PjodaI+4235GPY0S3mivE2vopT2dCEr1+HdmaCDX3kJvwKy/anw9Dv3SbU2rAb+uYdQq0YO5Pf5/3C26rVsjwdfoQvhVobnkaDuTzkcGaeQEOJGW3oIwace8ZiA5uhq2W+J8kR6ECXrXIBHyTf5KaW48N2I/ra9Tb0CZ9Br3lpqI3gHmO7gegaNmTMib+im2opRqRewCkuwuh0rVjsmdQJl18D0RyPBntj2ezfgV+gA1zIw/haLI4pqRMu8c2d6ARvRz+/Wqg14QPslBlS5ByPd6FrfdEqVpUqnXBjnYgOsOeYxHLoNQojZHdmX9w/1EYwRHCl8LVeT3JVZ8JTp4PrrTSTDXW8pWy/LNSaMEz3SzwkFZGPSBW83q54MlbphLjclgWLHqHvicVG0v7RHJL0woXoNZMmILp5JoowIn45FhtJUWZ+zPRWOC0WK+OtkM7jySOxG5ZHQxNXs4Qz6/loFC53fln+HPiQO4XdYJhu0Jl35CDshjTIhvwJO+LGPQrjF99sXiphTPVpLHbFAZhSREYM3UYFaZGYL9QiHoeficVG0m5q8izhgelvzFeMqpg2MsQv3bw6wJ3f2c2vYWDrZjoKc1F2xAgzYQxkW792824x/5UHiu5nzrSnzUI8Ed4ci4FF0I6cGGqTBk+nHrdNwSZWRX9XUbAZ8FxsDJMfXFwZCpe5JjxweQtU0RFtl1RI28LmoRYxt2xbaSLPMMQ3rBxqESNh25qj0GYcsa8r+h62On+IobxRsCFUwoyOuYRSvKj33iWhFpkLf8RbQm18MTfgIBrvJcziuz/lmZtCPHd4Ns7TP2eiF9wk1NpjdHBUiXthJ7hCmSPz6JtvhGZUXEmXCrUWmCn3R+epFzv1Ifo3QavUUMLR8hpFfoOdJNvMA/t+s5wJ4z1zYHeHWht80M1imOPNN6BN0dXDSLSTPcGsZJEpMdeKLdDvMrLIF55z0dlYPdQ6wA3MZ+XqUBvBvxMcJZNyvWxwrXBj9g+ht9BkX8Jkh527NtQqYO/90YdgPirnoO3uqn1JLmfsiO7grmbmsRIus3bM52UeGzrBM4Dru3uHP1i9gNlENdfryNj+cb2tH3pdbxuv+0G9Td3HUrt/BhksttsKAhegHzTIS39kDpJpD2p70HsF7cSgshM6O23/b/Sw763jEmcYP2i6y7vPmdVviQ+wnfFA5V/Kg6bhyQY4ZMj4UKv9C1Rlt7KW0lZzAAAAAElFTkSuQmCC")

	}else if (msg==4){
		 $(".msgsection").prepend(
	    		 "<div class='alert alert-danger' name='adminmsg'>"+
	    		    "<div style='font-size:17px;'>"+
	    		    "<i class='fa fa-exclamation-triangle'></i>"+
	    		   "<strong>±ä±Þ(½Â°´)</strong>"+
	    		  "<div class='alerttime'>hh:mm</div>"+
	    		   "<div class='msg'><p class='importancemsg'><img class='alertmsg'>msg</p></div>"+
	    		   "</div>"+
	    		  "</div>"
	    		);
	    $(".alertmsg").attr('src',"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAALUSURBVGhD7Zg9axRRFIb3b4idIIh2JnfWYi2cWTSKBAULFVOIioqCiFioWBhREMEqjQQLay3UwkL/guAPCBIEiRALde98xY9c71nO4brLye7MvXd2ZzUvPDCcfQfOw+wkN2ls5n9JJwx2yih4JSORyTBYi8PgbRJOBfjxZKTTbrbiSHTiKFB/o4XyJAyOYK3eQQnZL0HA06m9zDAJotYyRSWIWsqUlSBqJWMrQdRCxlWCGKuMLwliLDK+JYiRylQlQYxEpoxEen5OrS0u9AAzrttPpTJln0R+77bqD8y4LkclMjZfp/zuLVzfBGZcdyO8yti+E9nNq7i+Ccy47iC8yLi82Nn1y7i+Ccy47jCcZFwkgOzKOVzfBGZctwhWMq4SQHphDtc3gRnXLUopGR8SQHr2BK5vAjOuW4ZCMr4kgOTkLK5vAjOuW5aBMt/bze367+pv3I02JMcP4/omMOO6NnRl2mIa1zeRoXjK3WBLMhvi+iYw47r2iDe4vomMxDJftuTQXlzfBGZs1xL4Dw2ub6LtlriyC/3hOm4Iieub6OECX7ZH5Tkq6OhrruNEKJ7j+ibxgd1b9Au0wt5gyXos0UJ1r7mONfoHU2f/1A5cvzdyn9ilC6vsjRasf1lFDS2ir7mOHULCrwpcm49PGTiSwPmqi8PxpJcCEhTfT8YfJSQoXmTaTZVeOq2yaxdVfLDFdwpjIUFxkplpqV/v3+Ebot+RlU8qOXWU7w7FQYJiK5M/uIMKJj9ePGO7g/EgQbGRyR/dx/VNfr5+yXY3xqMEpawMnKt+f1xGBf3Vkh2VnilzjK9AglL6yeizVT5/Q+UP51VybIbvsFQoQXH6AVCIEUhQqpMZoQTFv8wYJCj+ZMYoQXGXqYEExV6mRhKU8jI1lKAUl6mxBGW4zARIUEBGRsFnRuTrxEhQknDPVhmKx/oJLMkw+KCvn2TR9Db8eDP/eBqNP0aPUTEL5Io4AAAAAElFTkSuQmCC")
		
	}else if(msg==5){
		
	}else if(msg==7){
		$(".msgsection").prepend(
	    		 "<div class='alert alert-danger' name='adminmsg'>"+
	    		    "<div style='font-size:17px;'>"+
	    		    "<i class='fa fa-exclamation-triangle'></i>"+
	    		   "<strong>±ä±Þ(°ü¸®ÀÚ)</strong>"+
	    		  "<div class='alerttime'>hh:mm</div>"+
	    		   "<div class='msg'><p class='importancemsg'><img class='alertmsg'>"+msg+"</p></div>"+
	    		   "</div>"+
	    		  "</div>"
	    		);
	    $(".alertmsg").attr('src',"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAALUSURBVGhD7Zg9axRRFIb3b4idIIh2JnfWYi2cWTSKBAULFVOIioqCiFioWBhREMEqjQQLay3UwkL/guAPCBIEiRALde98xY9c71nO4brLye7MvXd2ZzUvPDCcfQfOw+wkN2ls5n9JJwx2yih4JSORyTBYi8PgbRJOBfjxZKTTbrbiSHTiKFB/o4XyJAyOYK3eQQnZL0HA06m9zDAJotYyRSWIWsqUlSBqJWMrQdRCxlWCGKuMLwliLDK+JYiRylQlQYxEpoxEen5OrS0u9AAzrttPpTJln0R+77bqD8y4LkclMjZfp/zuLVzfBGZcdyO8yti+E9nNq7i+Ccy47iC8yLi82Nn1y7i+Ccy47jCcZFwkgOzKOVzfBGZctwhWMq4SQHphDtc3gRnXLUopGR8SQHr2BK5vAjOuW4ZCMr4kgOTkLK5vAjOuW5aBMt/bze367+pv3I02JMcP4/omMOO6NnRl2mIa1zeRoXjK3WBLMhvi+iYw47r2iDe4vomMxDJftuTQXlzfBGZs1xL4Dw2ub6LtlriyC/3hOm4Iieub6OECX7ZH5Tkq6OhrruNEKJ7j+ibxgd1b9Au0wt5gyXos0UJ1r7mONfoHU2f/1A5cvzdyn9ilC6vsjRasf1lFDS2ir7mOHULCrwpcm49PGTiSwPmqi8PxpJcCEhTfT8YfJSQoXmTaTZVeOq2yaxdVfLDFdwpjIUFxkplpqV/v3+Ebot+RlU8qOXWU7w7FQYJiK5M/uIMKJj9ePGO7g/EgQbGRyR/dx/VNfr5+yXY3xqMEpawMnKt+f1xGBf3Vkh2VnilzjK9AglL6yeizVT5/Q+UP51VybIbvsFQoQXH6AVCIEUhQqpMZoQTFv8wYJCj+ZMYoQXGXqYEExV6mRhKU8jI1lKAUl6mxBGW4zARIUEBGRsFnRuTrxEhQknDPVhmKx/oJLMkw+KCvn2TR9Db8eDP/eBqNP0aPUTEL5Io4AAAAAElFTkSuQmCC")
		
	}
}




</script>

</html>
