<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE HTML>
<!--
	Astral by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>Astral by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="../driverBoot/css/main.css" />
		<noscript><link rel="stylesheet" href="../driverBoot/css/noscript.css" /></noscript>
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
		   <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	</head>
	<body>

		<!-- Wrapper-->
			<div id="wrapper">

				<!-- Nav -->
					<nav id="nav">
						<a href="#me" class="icon fa-home active"><span>My Page</span></a>
						<a href="#work" class="icon fa-folder"><span>Work</span></a>
						<a href="#contact" class="icon fa-envelope"><span>Contact</span></a>
						<a href="#" class="icon fa-twitter"><span>Twitter</span></a>
					</nav>

				<!-- Main -->
					<div id="main">

						<!-- Me -->
							<article id="me" class="panel">
								<header>
									<h1>${driverInfo.NAME }</h1>
									<p>기사님 (접속 시간: ${dirverInfo.currtime })</p>
								</header>
								<a href="#work" class="jumplink pic">
									<span class="arrow icon fa-chevron-right"><span>See my work</span></span>
									<img src="../images/me.jpg" alt="" />
								</a>
							</article>

						<!-- Work -->
							<article id="work" class="panel">
								<header>
									<h2>Work</h2>
								</header>
								<p>
									Phasellus enim sapien, blandit ullamcorper elementum eu, condimentum eu elit.
									Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia
									luctus elit eget interdum.
								</p>
								<section>
									<div class="row">
										<div class="4u 12u$(mobile)">
											<a href="#" class="image fit"><img src="../images/pic01.jpg" alt=""></a>
										</div>
										<div class="4u 12u$(mobile)">
											<a href="#" class="image fit"><img src="../images/pic02.jpg" alt=""></a>
										</div>
										<div class="4u$ 12u$(mobile)">
											<a href="#" class="image fit"><img src="../images/pic03.jpg" alt=""></a>
										</div>
										<div class="4u 12u$(mobile)">
											<a href="#" class="image fit"><img src="../images/pic04.jpg" alt=""></a>
										</div>
										<div class="4u 12u$(mobile)">
											<a href="#" class="image fit"><img src="../images/pic05.jpg" alt=""></a>
										</div>
										<div class="4u$ 12u$(mobile)">
											<a href="#" class="image fit"><img src="../images/pic06.jpg" alt=""></a>
										</div>
										<div class="4u 12u$(mobile)">
											<a href="#" class="image fit"><img src="../images/pic07.jpg" alt=""></a>
										</div>
										<div class="4u 12u$(mobile)">
											<a href="#" class="image fit"><img src="../images/pic08.jpg" alt=""></a>
										</div>
										<div class="4u$ 12u$(mobile)">
											<a href="#" class="image fit"><img src="../images/pic09.jpg" alt=""></a>
										</div>
										<div class="4u 12u$(mobile)">
											<a href="#" class="image fit"><img src="../images/pic10.jpg" alt=""></a>
										</div>
										<div class="4u 12u$(mobile)">
											<a href="#" class="image fit"><img src="../images/pic11.jpg" alt=""></a>
										</div>
										<div class="4u$ 12u$(mobile)">
											<a href="#" class="image fit"><img src="../images/pic12.jpg" alt=""></a>
										</div>
									</div>
								</section>
							</article>

						<!-- Contact -->
							<article id="contact" class="panel">
								<header>
									<h2>Contact Me</h2>
								</header>
								<form action="#" method="post">
									<div>
										<div class="row">
											<div class="6u 12u$(mobile)">
												<input type="text" name="name" placeholder="Name" />
											</div>
											<div class="6u$ 12u$(mobile)">
												<input type="text" name="email" placeholder="Email" />
											</div>
											<div class="12u$">
												<input type="text" name="subject" placeholder="Subject" />
											</div>
											<div class="12u$">
												<textarea name="message" placeholder="Message" rows="8"></textarea>
											</div>
											<div class="12u$">
												<input type="submit" value="Send Message" />
											</div>
										</div>
									</div>
								</form>
							</article>

					</div>

				<!-- Footer -->
					<div id="footer">
						<ul class="copyright">
							<li>&copy; Untitled.</li><li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
						</ul>
					</div>

			</div>

		<!-- Scripts -->
			<script src="../driverBoot/js/jquery.min.js"></script>
			<script src="../driverBoot/js/skel.min.js"></script>
			<script src="../driverBoot/js/skel-viewport.min.js"></script>
			<script src="../driverBoot/js/util.js"></script>
			<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
			<script src="../driverBoot/js/main.js"></script>

	</body>
</html>