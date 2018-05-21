<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<textarea id="textareaid"></textarea>
<a href="#" onclick="insertAtCaret('textareaid', 'text to insert');return false;">Click Here to Insert</a>
</body>

<script>
function insertAtCaret(areaId, text) {
	  var txtarea = document.getElementById(areaId);
	  if (!txtarea) {
	    return;
	  }

	  var scrollPos = txtarea.scrollTop;
	  var strPos = 0;
	  var br = ((txtarea.selectionStart || txtarea.selectionStart == '0') ?
	    "ff" : (document.selection ? "ie" : false));
	  if (br == "ie") {
	    txtarea.focus();
	    var range = document.selection.createRange();
	    range.moveStart('character', -txtarea.value.length);
	    strPos = range.text.length;
	  } else if (br == "ff") {
	    strPos = txtarea.selectionStart;
	  }

	  var front = (txtarea.value).substring(0, strPos);
	  var back = (txtarea.value).substring(strPos, txtarea.value.length);
	  txtarea.value = front + text + back;
	  strPos = strPos + text.length;
	  if (br == "ie") {
	    txtarea.focus();
	    var ieRange = document.selection.createRange();
	    ieRange.moveStart('character', -txtarea.value.length);
	    ieRange.moveStart('character', strPos);
	    ieRange.moveEnd('character', 0);
	    ieRange.select();
	  } else if (br == "ff") {
	    txtarea.selectionStart = strPos;
	    txtarea.selectionEnd = strPos;
	    txtarea.focus();
	  }

	  txtarea.scrollTop = scrollPos;
	}


</script>
</html>