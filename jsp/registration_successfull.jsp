<% //Page Imports - Util & IO %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>
<!--Page Encoding - Unicode-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--If Unauthorized Access-->
<%
	//If Student Name is null in request Parameter
	if(request.getAttribute("student_name")==null)
	{
		response.sendRedirect("sregistration.jsp");
		return;
	}
%>

<!--HTML 5 Document Starting-->
<!DOCTYPE html>
<html lang="en">
	<head>
		<!--Title of Webpage-->
		<%
			//If Registration Successfull Message
			if(request.getAttribute("message")==null)
			{
		%>
				<title>Registration Successfull</title>
		<%
			}
			//If Forgot Password Successfull Message
			else
			{
		%>
				<title>Forgot Password Successfull</title>
		<%
			}
		%>
		<!--Favicon-->
		<link rel="icon" type="image/png" href="../static/images/favicon.png">
		<!--Unicode Encoding-->
		<meta charset="UTF-8">
		<!--For Responsive Web Page-->
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<!--Bootstrap CSS Linking-->
		<link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="../css/bootstrap-grid.css">
		<link rel="stylesheet" type="text/css" href="../css/bootstrap-reboot.css">
		<!--Fontawesome CSS Linking-->
		<link rel="stylesheet" type="text/css" href="../fontawesome/css/all.css">
		<!--User Defined CSS Linking-->
		<link rel="stylesheet" type="text/css" href="../css/common.css">
		<link rel="stylesheet" type="text/css" href="../css/registration_successfull.css">
		<!--jQuery Imports-->
		<script src="../js/jquery-3.5.1.slim.js"></script>
		<!--Bootstrap JavaScript Imports-->
		<script src="../js/popper.min.js"></script>
		<script src="../js/bootstrap.min.js"></script>
	</head>
	<body>
		<!--Header-->
		<!-- Header - 1 -->
		<div class="container-fluid text-center bg-primary">
			<div class="row">
				<!--Live Date, Day & Time Section-->
				<div class="col-md-4 my-auto">
					<span class="clock-icon"><i class="far fa-clock fa-spin"></i></span>
					<span id="dTime" class="dTime"></span>
					<script src="../js/date-time.js"></script>	
				</div>
				<!--For Blank Space-->
				<div class="col-md-4 my-auto">
						
				</div>
				<!--Language Switching Button-->
				<div class="col-md-4 my-auto">
					<a class="btn btn-sm btn-warning mt-1 mb-1" data-toggle="tooltip" title="हिन्दी में अनुवाद करें" href="#" role="button">हिन्दी</a>	
				</div>	
			</div>
		</div>

		<!-- Header - 2 -->
		<div class="container-fluid header text-center">
			<div class="row">
				<!--MP State Scholarship Logo & Link to Home Page-->
				<div class="col-md-4 my-auto">
					<a href="../index.jsp"><img class="img-fluid" src="../static/images/logo.png" alt="MP State Scholarship Portal Logo"></a>	
				</div>
			</div>
		</div>

		<!--Navigation Bar-->
		<nav class="navbar navbar-expand-lg sticky-top">
			<!--Navbar Branding-->
			<a href="../index.jsp" class="navbar-brand ml-2">Madhya Pradesh Scholarship Portal</a>
			<!--Toggle Button-->	
		  	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
		  		<!--Hamburger Button Design-->
		    	<svg class="hamburger-button" viewBox="0 0 100 80" width="40" height="40">
			  		<rect width="100" height="20" rx="8"></rect>
			  		<rect y="30" width="100" height="20" rx="8"></rect>
			  		<rect y="60" width="100" height="20" rx="8"></rect>
				</svg>
		  	</button>
		  	<!--Navigation Bar Links-->
		  	<div class="collapse navbar-collapse" id="navbarNavDropdown">
		    	<ul class="navbar-nav">
	    			<!--Home Page Link-->
	      			<li class="nav-item link-active">
	        			<a class="nav-link" href="../index.jsp"><i class="fas fa-home"></i> Home</a>
	      			</li>
		    	</ul>
		  	</div>
		</nav>

		<!--User Controls-->
		<div class="container text-right">
			<!--Print Button-->
			<img onclick="ClickHereToPrint()" class="img-fluid rounded-circle mt-2 print-btn" src="../static/images/printer-icon.jpg" alt="Print" width="80" height="80" data-toggle="tooltip" title="Print">
			<!--Login Page Link-->
			<a href="slogin.jsp"><img class="img-fluid rounded-circle mt-2" src="../static/images/login-icon.png" alt="Login" width="80" height="80" data-toggle="tooltip" title="Login"></a>
		</div>

		<!--Registration Details-->
		<div id="printSection" class="container mt-4 mb-4">
			<%
				//If Registration Successfull Message
				if(request.getAttribute("message")==null)
				{
			%>
					<!--Registration Successfull Message-->
					<div class="alert alert-warning text-center">
						Congratulations !!! <strong>${requestScope.student_name}</strong> You are successfully registered on Portal. Please note down your User ID & Password carefully. You will need it for availing various services being provided by the scholarship portal.
					</div>
			<%
				}
				//If Forgot Password Successfull Message
				else
				{
			%>
					<!--Forgot Password Successfull Message-->
					<div class="alert alert-warning text-center">
						Congratulations !!! <strong>${requestScope.student_name}</strong> Your password has been changed. Please note down your User ID & Password carefully. You will need it for availing various services being provided by the scholarship portal
					</div>
			<%
				}
			%>

			<!--User ID & Password Details-->
			<div class="table-responsive">
				<table class="table table-bordered">
					<thead>
						<th colspan="2"></th>
					</thead>
					<tbody>
						<tr>
							<!--User ID-->
							<td class="text-right w-50"><h4>Your User ID :</h4></td>
							<td class="text-left w-50"><h4 class="highlight">${requestScope.applicant_id}</h4></td>
						</tr>
						<tr>
							<!--Password-->
							<td class="text-right w-50"><h4>Password :</h4></td>
							<td class="text-left w-50"><h4 class="highlight">${requestScope.student_password}</h4></td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
					</tbody>
				</table>
			</div>

			<hr>

			<!--Instructions-->
			<div class="alert alert-primary">
				<h6 class="text-success text-center">Using USER-ID/PASSWORD, Students will be able to LOG-IN to the Madhya Pradesh Scholarship Portal and Avail following Services Apply online for various schemes Scholarship that have been made available online.</h6>
				<hr>
				<p class="text-danger">
					<i class="far fa-check-circle"></i> Register Your Application,with PROPER Branch Code and Institute Code.<br>
					<i class="far fa-check-circle"></i> You have to Upload Your 10th Board Mark sheet and Caste certificate photocopy.<br>
					<i class="far fa-check-circle"></i> Edit the scholarship applications till they are not locked and sent to institute for further processing<br>
					<i class="far fa-check-circle"></i> Upload caste and income certificates, photograph etc required for the scholarship<br>
					<i class="far fa-check-circle"></i> Print the application format to be submitted to the institute along with the supporting documents<br>
					<i class="far fa-check-circle"></i> Track the status of their application<br>
				</p>
			</div>
		</div>

		<!--Print iframe-->
		<iframe id="ifrmPrint" src="#" style="width: 0px;height: 0px;"></iframe>

		<!--Footer-->
		<!-- Footer - Upper -->
		<div class="container-fluid footer-upper text-center">
			<div class="row pt-2 pb-2">
				<!--Digital India Logo-->
				<div class="col-md-3 text-center">
					<img src="../static/images/digitalindia.png" class="img-fluid" alt="Digital India Logo">
				</div>
				<!--Footer Note-->
				<div class="col-md-6 text-center">
					<h6 class="text-light">The system is operated by the concerned officials and officers of the department as per the Instructions/orders. Data, contents, processes are fully managed and updated by the department officials.</h6>
				</div>
				<!--UPC Logo-->
				<div class="col-md-3 text-center">
					<img src="../static/images/upc-logo.png" class="img-fluid upc-logo" alt="UPC Logo">
				</div>
			</div>
		</div>

		<!-- Footer - Lower -->
		<div class="container-fluid footer-lower text-center bg-primary">
			<div class="row text-light mx-auto">
				<!--Browser Recommendation-->
				<div class="col-md-4 text-center mt-1">
					<p>Best Viewed in Google Chrome, Microsoft Edge & Safari</p>
				</div>
				<!--Copyright Info.-->
				<div class="col-md-4 text-center mt-1">
					<p>Copyright &copy; 2021, Madhya Pradesh Scholarship Portal</p>
				</div>
				<!--Designer & Developer Name-->
				<div class="col-md-4 text-center mt-1">
					<p>Designed & Developed By Himanshu Nagar</p>
				</div>
			</div>
		</div>
		
		<!--User Defined JavaScript Imports-->
		<script src="../js/common.js"></script>
		<script src="../js/registration_successfull.js"></script>
	</body>
</html>