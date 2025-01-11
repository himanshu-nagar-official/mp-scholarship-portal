<!--Page Encoding - Unicode-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--If Unauthorized Access-->
<%
	//If Hash Key or Message is null in request Parameter
	if(request.getAttribute("hash_key")==null||request.getAttribute("message")==null)
	{
		response.sendRedirect("sforgot_password.jsp");
		return;
	}
%>

<!--HTML 5 Document Starting-->
<!DOCTYPE html>
<html lang="en">
	<head>
		<!--Title of Webpage-->
		<title>Forgot Password - Student</title>
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
	      			<!--Login Page Links-->
	      			<li class="nav-item dropdown">
			      		<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			 			<i class="fa fa-sign-in-alt"></i> Login</a>
				      	<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
				      	<!--Student Login Page Link-->
				        	<a class="dropdown-item" href="../jsp/slogin.jsp"><i class="fa fa-user-graduate"></i> Student Login</a>
				        	<!--Institute Login Page Link-->
				        	<a class="dropdown-item" href="ilogin.jsp"><i class="fa fa-university"></i> Institute Login</a>
				      	</div>
			    	</li>
		    	</ul>
		  	</div>
		</nav>

		<!--Message & New Password Creation-->
		<div class="container mt-0 text-center">
			<!--If any message available in http request-->
			<% 
				if(!(request.getAttribute("message")==null))
				{
			%>
						<!--Show Message-->
						<div class="container mt-3">
							<div class="alert alert-success">
								<strong>${requestScope.message}</strong>
							</div>
						</div>
			<%
				}
			%>

			<!--Create New Password Form-->
			<form action="Student_Forgot_Password" method="post" onsubmit="return validateFormData()" class="border pr-2 pl-2 mb-4">
				<div class="row">
					<div class="col-md-3"></div>
					<div class="col-md-6">
						<!--New Password Input Text Box-->
						<label class="form-label float-left" for="student_password">New Password:</label>
						<div class="input-group mb-3">
							<input type="password" class="form-control" id="student_password" name="student_password" placeholder="New Password" onkeyup="studentPasswordValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off" maxlength="15">
							<div class="input-group-append">
								<span class="input-group-text eye_icon"><i id="eye_icon" class="fas fa-eye" onclick="showPassword();"></i></span>
							</div>
						</div>
						<!--Client Side Validation Error for New Password-->
						<p id="student_password_check"></p>

						<!--Confirm New Password Input Text Box-->
						<label class="form-label float-left" for="student_confirm_password">Confirm New Password:</label>
						<div class="input-group mb-3">
							<input type="password" class="form-control" id="student_confirm_password" name="student_confirm_password" placeholder="Confirm New Password" onkeyup="studentConfirmPasswordValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off" maxlength="15">
							<div class="input-group-append">
								<span class="input-group-text eye_icon"><i id="eye_icon_confirm" class="fas fa-eye" onclick="showConfirmPassword();"></i></span>
							</div>
						</div>
						<!--Client Side Validation Error for Confirm New Password-->
						<p id="student_confirm_password_check"></p>

						<!--Hash Key Input Hidden Box-->
						<input type="hidden" name="hash_key" id="hash_key" value="${requestScope.hash_key}">

						<!--Create New Password Button-->
						<input type="submit" name="create_password" class="btn btn-success mt-2 mb-2" value="Create New Password">
					</div>
				</div>
			</form>
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
		<script src="../js/screate_np_fp.js"></script>
	</body>
</html>