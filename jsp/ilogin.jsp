<!--Page Encoding - Unicode-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--Check if Student or Institute Logged in or not-->
<%
	String applicant_id =(String)session.getAttribute("applicant_id");
	String student_name =(String)session.getAttribute("student_name");
	if(applicant_id!=null && student_name!=null)
	{ 
		response.sendRedirect("sdashboard.jsp");
		return; 
	}
	String ins_code =(String)session.getAttribute("ins_code");
	String ins_name =(String)session.getAttribute("ins_name");
	if(ins_code!=null && ins_name!=null)
	{ 
		response.sendRedirect("idashboard.jsp");
		return; 
	}
%>

<!--HTML 5 Document Starting-->
<!DOCTYPE html>
<html lang="en">
	<head>
		<!--Title of Webpage-->
		<title>Institute Login</title>
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
		<link rel="stylesheet" type="text/css" href="../css/ilogin.css">
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

		<div class="container-fluid text-center">
			<!--If any message available in http request-->
			<% 
				if(!(request.getAttribute("message")==null))
				{
			%>
					<!--Show Message-->
					<div class="container mt-3">
						<div class="alert alert-danger alert-dismissible fade show text-center">
							<button type="button" class="close" data-dismiss="alert">&times;</button>
							<strong>${requestScope.message}</strong>
						</div>
					</div>
			<%
				}
			%>

			<div class="row mt-3 mb-3">
				<div class="col-md-12">
					<!--Login Form-->
					<form action="Institute_Login" id="ilogin-form" class="login-form pl-4 pr-4" method="post" onsubmit="return validateFormData()">
						<img class="img-fluid mt-2" src="../static/images/logo.png" alt="MP State Scholarship Logo">
						<hr>
						<h3>Institute Login</h3>
						<img src="../static/images/institute-icon.png" class="img-fluid avatar rounded-circle mb-2" alt="Login Avatar" width="100" height="100">

						<!--Institute Id Text Box-->
						<input class="form-control mb-3" type="text" id="ins_code" name="ins_code" placeholder="Institute Id" onkeyup="instituteIdValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off" maxlength="5">
						<!--Client Side Validation Error for Institute Id-->
						<p id="institute_id_check"></p>

						<!--Institute Password Text Box-->
						<div class="input-group mb-3">
							<input type="password" class="form-control" id="ins_password" name="ins_password" placeholder="Institute Password" onkeyup="institutePasswordValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off" maxlength="15">
							<div class="input-group-append">
								<span class="input-group-text eye_icon"><i id="eye_icon" class="fas fa-eye" onclick="showPassword();"></i></span>
							</div>
						</div>
						<!--Client Side Validation Error for Student Password-->
						<p id="institute_password_check"></p>

						<!--Login Button-->
						<input class="btn btn-block btn-success mb-2" type="submit" name="login" value="Login">
					</form>
				</div>
			</div>
		</div>

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
		<script src="../js/ilogin.js"></script>
	</body>
</html>