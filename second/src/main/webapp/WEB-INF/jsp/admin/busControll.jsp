<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<style>
body {
  background-color: #1abc9c;
}

.arrows {
  position: relative;
  position: absolute;
  top: 50%;
  left: 50%;
  width: 80px;
  height: 80px;
  transform: translate(-50%, -50%);
}

.arrows:before {
  content: '';
  position: absolute;
  width: 100%;
  height: 100%;
  border-left: 26.66667px solid rgba(0, 0, 0, 0.7);
  border-bottom: 26.66667px solid rgba(0, 0, 0, 0.7);
  transform: translate(26.66667px, 106.66667px) rotate(-45deg);
  animation: arrows 1.5s linear infinite;
}

.arrows:after {
  content: '';
  position: absolute;
  width: 100%;
  height: 100%;
  border-left: 26.66667px solid rgba(0, 0, 0, 0.7);
  border-bottom: 26.66667px solid rgba(0, 0, 0, 0.7);
  transform: translate(53.33333px, 0px) rotate(-45deg);
  animation: arrows 1.5s linear infinite -0.75s;
}

@keyframes arrows {
  0% {
    border-left: 26.66667px solid transparent;
    border-bottom: 26.66667px solid transparent;
    transform: translate(-13.33333px, -53.33333px) rotate(-45deg);
  }
  10%, 90% {
    border-left: 26.66667px solid transparent;
    border-bottom: 26.66667px solid transparent;
  }
  50% {
    border-left: 26.66667px solid rgba(0, 0, 0, 0.7);
    border-bottom: 26.66667px solid rgba(0, 0, 0, 0.7);
    transform: translate(-13.33333px, 0px) rotate(-45deg);
  }
  100% {
    border-left: 26.66667px solid transparent;
    border-bottom: 26.66667px solid transparent;
    transform: translate(-13.33333px, 53.33333px) rotate(-45deg);
  }
}
</style>
<body>
<div class="arrows"></div>



</body>
</html>
