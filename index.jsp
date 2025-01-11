<!--Page Encoding - Unicode-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--Check if Student Logged in or not-->
<%
	//Get Session Attributes - Applicant Id & Student Name
	String applicant_id =(String)session.getAttribute("applicant_id");
	String student_name =(String)session.getAttribute("student_name");

	String ins_code =(String)session.getAttribute("ins_code");
	String ins_name =(String)session.getAttribute("ins_name");

	//Create New Boolean Type Local Variable to check if logged in or not
	Boolean student_logged_in = false;

	//Create New Boolean Type Local Variable to check if logged in or not
	Boolean institute_logged_in = false;

	//Check if Institute Id & Institute Name are Available
	if(ins_code!=null && ins_name!=null)
	{ 
		//Change the Value of institute_logged_in to true if logged in
		institute_logged_in = true;
	}

	//Check if Applicant Id & Student Name are Available
	if(applicant_id!=null&&student_name!=null)
	{ 
		//Change the Value of student_logged_in to true if logged in
		student_logged_in = true; 
	}
%>

<!--HTML 5 Document Starting-->
<!DOCTYPE html>
<html lang="en">
	<head>
		<!--Title of Webpage-->
		<title>Madhya Pradesh Scholarship Portal</title>
		<!--Favicon-->
		<link rel="icon" type="image/png" href="static/images/favicon.png">
		<!--Unicode Encoding-->
		<meta charset="UTF-8">
		<!--For Responsive Web Page-->
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<!--Bootstrap CSS Linking-->
		<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="css/bootstrap-grid.css">
		<link rel="stylesheet" type="text/css" href="css/bootstrap-reboot.css">
		<!--Fontawesome CSS Linking-->
		<link rel="stylesheet" type="text/css" href="fontawesome/css/all.css">
		<!--User Defined CSS Linking-->
		<link rel="stylesheet" type="text/css" href="css/common.css">
		<link rel="stylesheet" type="text/css" href="css/index.css">
		<!--jQuery Imports-->
		<script src="js/jquery-3.5.1.slim.js"></script>
		<!--Bootstrap JavaScript Imports-->
		<script src="js/popper.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
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
					<script src="js/date-time.js"></script>	
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
					<a href="index.jsp"><img class="img-fluid" src="static/images/logo.png" alt="MP State Scholarship Portal Logo"></a>	
				</div>
				<!--If Student and Institute not Logged In Show Inline Common Login Form-->
				<%
					if((!student_logged_in)&&(!institute_logged_in))
					{
				%>
						<!--Inline Login Form-->
						<div class="ml-auto my-auto d-none d-lg-block">
				    		<form class="form-inline" action="jsp/Inline_Common_Login" method="post" name="inline_login_form" onsubmit="return validateInlineCommonLogin()">
				    			<!--User Id Input Text Box-->
								<div class="form-group mr-2">
									<div class="input-group input-group-sm">
										<div class="input-group-prepend">
								    		<div class="input-group-text"><i class="fas fa-id-badge"></i></div>
								    	</div>
							    		<input type="text" class="form-control text-primary bg-white" id="user_id" name="user_id" placeholder="Applicant/Institute Id" onkeyup="userIdValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off">
									</div>
							  	</div>
							  	<!--Password Input Text Box-->
							  	<div class="form-group mr-2">
									<div class="input-group input-group-sm">
							    		<input type="password" class="form-control text-primary bg-white" id="password" name="password" placeholder="Password" onkeyup="passwordValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off">
							    		<div class="input-group-append">
											<span class="input-group-text eye_icon"><i id="eye_icon" class="fas fa-eye" onclick="showPassword();"></i></span>
										</div>
									</div>
							  	</div>
							  	<!--Login Type Select Box-->
						    	<select name="login_type" id="login_type" class="form-control form-control-sm mr-2 bg-white text-danger" onchange="loginTypeValidation();">
						    		<option value="">--Select Type--</option>
						    		<option value="Student">Student</option>
						    		<option value="Institute">Institute</option>
						    	</select>
								<!--Login Button-->
								<input class="btn btn-sm btn-success mr-2" type="submit" name="login" value="Login">
							</form>
				    	</div>
		    	<%
		    		}
		    	%>
			</div>
		</div>

		<!--Navigation Bar-->
		<nav class="navbar navbar-expand-lg sticky-top">
			<!--Navbar Branding-->
			<a href="index.jsp" class="navbar-brand ml-2">Madhya Pradesh Scholarship Portal</a>
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
		        		<a class="nav-link" href="index.jsp"><i class="fas fa-home"></i> Home</a>
		      		</li>
		      		<!--If Student Logged in Show Dashboard Link-->
		      		<%
			      		if(student_logged_in)
						{
					%>
				      		<!--Student Dashboard Page Link-->
			      			<li class="nav-item">
			        			<a class="nav-link" href="jsp/sdashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
			      			</li>
	      			<%
	      				}
	      			%>
	      			<!--If Institute Logged in Show Dashboard Link-->
		      		<%
			      		if(institute_logged_in)
						{
					%>
				      		<!--Institute Dashboard Page Link-->
			      			<li class="nav-item">
			        			<a class="nav-link" href="jsp/idashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
			      			</li>
	      			<%
	      				}
	      			%>
	      			<!--If Student and Institute not Logged in Show Login Links-->
		      		<%
			      		if((!student_logged_in)&&(!institute_logged_in))
						{
					%>
				      		<!--Login Page Links-->
				      		<li class="nav-item dropdown">
						      	<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					 			<i class="fa fa-sign-in-alt"></i> Login</a>
						    	<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
						      		<!--Student Login Page Link-->
						        	<a class="dropdown-item" href="jsp/slogin.jsp"><i class="fa fa-user-graduate"></i> Student Login</a>
						        	<!--Institute Login Page Link-->
						        	<a class="dropdown-item" href="jsp/ilogin.jsp"><i class="fa fa-university"></i> Institute Login</a>
						      	</div>
					    	</li>
				    <%	
					    }
				    %>
		    	</ul>
		    	<!--If Student Logged in Show Logout Link-->
		    	<%
		    		if(student_logged_in)
		    		{
		    	%>
				    	<ul class="nav navbar-nav ml-auto">
				    		<!--Logout Link-->
		      				<li class="nav-item logout-link">
			        			<a class="nav-link" href="jsp/Student_Logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
			      			</li>
				    	</ul>
		    	<%
		    		}
		    	%>
		    	<!--If Institute Logged in Show Logout Link-->
		    	<%
		    		if(institute_logged_in)
		    		{
		    	%>
				    	<ul class="nav navbar-nav ml-auto">
				    		<!--Logout Link-->
		      				<li class="nav-item logout-link">
			        			<a class="nav-link" href="jsp/Institute_Logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
			      			</li>
				    	</ul>
		    	<%
		    		}
		    	%>
		  	</div>
		</nav>

		<!--Slideshow-->
		<div id="slideshow-home" class="carousel slide" data-ride="carousel" data-interval="3500">
			<!-- Indicators -->
		 	<ul class="carousel-indicators">
		    	<li data-target="#slideshow-home" data-slide-to="0" class="active"></li>
		    	<li data-target="#slideshow-home" data-slide-to="1"></li>
		    	<li data-target="#slideshow-home" data-slide-to="2"></li>
		    	<li data-target="#slideshow-home" data-slide-to="3"></li>
		    	<li data-target="#slideshow-home" data-slide-to="4"></li>
		  	</ul>
		  	<!-- The slideshow -->
		  	<div class="carousel-inner">
		    	<div class="carousel-item active">
		      		<img class="img-fluid" src="static/images/slider1.jpg" alt="MJSPY" width="800" height="300">
		    	</div>
		    	<div class="carousel-item">
		      		<img class="img-fluid" src="static/images/slider2.jpg" alt="GKBY" width="800" height="300">
		    	</div>
		    	<div class="carousel-item">
		      		<img class="img-fluid" src="static/images/slider3.jpg" alt="MMVY" width="800" height="300">
		    	</div>
		    	<div class="carousel-item">
		      		<img class="img-fluid" src="static/images/slider4.jpg" alt="PKY" width="800" height="300">
		    	</div>
		    	<div class="carousel-item">
		      		<img class="img-fluid" src="static/images/slider5.jpg" alt="PMSY" width="800" height="300">
		    	</div>
		  	</div>
		  	<!-- Left and right controls -->
		  	<a class="carousel-control-prev" href="#slideshow-home" data-slide="prev">
		    	<span class="carousel-control-prev-icon"></span>
		  	</a>
		  	<a class="carousel-control-next" href="#slideshow-home" data-slide="next">
		    	<span class="carousel-control-next-icon"></span>
		  	</a>
		</div>

		<!--COVID-19 Precaution Marquee-->
		<div class="container-fluid bg-dark">
			<div class="row">
				<div class="col-md-2">
					<h6 class="text-danger d-inline"><span><i class="fas fa-viruses"></i></span>  Reduce Risk of COVID-19 : </h6>	
				</div>
				<div class="col-md-10">
					<marquee>
						<h6 class="text-light d-inline">   <span><i class="fas fa-star"></i></span> Clean hands with soap & water or alcohol-based hand rub.</h6>
						<h6 class="text-light d-inline">   <span><i class="fas fa-star"></i></span> Cover nose & mouth when coughing and sneezing with tissue or flexed elbow.</h6>
						<h6 class="text-light d-inline">   <span><i class="fas fa-star"></i></span> Avoid close contact with anyone with cold or flu-like symptoms.</h6>
						<h6 class="text-light d-inline">   <span><i class="fas fa-star"></i></span> Avoid touching your eyes, nose and mouth.</h6>
						<h6 class="text-light d-inline">    <span><i class="fas fa-star"></i></span> Avoid unprotected contact with live wild or farm animals.</h6>
					</marquee>		
				</div>
			</div>
		</div>

		<!--Student Logged In Division-->
		<%
			if(student_logged_in)
    		{
		%>
				<!--Print Student Name & Applicant Id-->
				<div class="container-fluid mt-2 mb-2">
					<h5>Welcome, <strong><%=student_name%>(<%=applicant_id%>)</strong></h5>
					<hr>
				</div>
		<%
			}
		%>

		<!--Institute Logged In Division-->
		<%
			if(institute_logged_in)
    		{
		%>
				<!--Print Institute Name & Institute Code-->
				<div class="container-fluid mt-2 mb-2">
					<h5>Welcome, <strong><%=ins_name%>(<%=ins_code%>)</strong></h5>
					<hr>
				</div>
		<%
			}
		%>

		<!--Important Instructions-->
		<div class="container">
			<div class="card-deck mt-3">
				<div class="card bg-white shadow student-corner-card">
					<div class="card-body student-corner-card-body">
						<img src="static/images/important-instructions-icon.png" class="img-fluid mx-auto d-block rounded-circle card-icon" alt="Important Instructions Icon">
						<h4 class="mb-2 text-center text-danger">Important Instructions</h4>
						<img src="static/images/sub-heading-line.png" class="img-fluid mx-auto d-block" alt="Sub Heading Line"><br>
						<marquee direction="up" scrollamount="2">
							<h5 class="text-primary"><i class="fas fa-hand-point-right text-danger"></i>  Please Register on the Portal & then Login & Fill up the Scholarship Form.</h5>
							<hr>
							<h5 class="text-primary"><i class="fas fa-hand-point-right text-danger"></i>  Please fill all the information in the Scholarship Form & Registration Form carefully.</h5>
							<hr>
							<h5 class="text-primary"><i class="fas fa-hand-point-right text-danger"></i> You can check scholarship form approval status from track application status.</h5>
						</marquee>
					</div>
				</div>
			</div>
		</div>

		<!--Services Corner-->
		<div class="container mt-4 mb-4">
			<h3 class="text-primary text-center mb-2">Services Corner</h3>
			<img src="static/images/heading-line.png" class="img-fluid mx-auto d-block" alt="Heading Line"> 
			<div class="card-deck mt-3">
				<!--Student Corner-->
				<div class="card bg-white shadow student-corner-card">
					<div class="card-body student-corner-card-body">
						<img src="static/images/student-icon.png" class="img-fluid mx-auto d-block rounded-circle card-icon" alt="Student Icon">
						<h4 class="mb-2 text-center">Student Corner</h4>
						<img src="static/images/sub-heading-line.png" class="img-fluid mx-auto d-block" alt="Sub Heading Line"><br>
						<a class="corner-links" href="jsp/sregistration.jsp"><h5><i class="fas fa-hand-point-right text-danger"></i>  Register Yourself</h5></a>
						<hr>
						<a class="corner-links" href="jsp/slogin.jsp"><h5><i class="fas fa-hand-point-right text-danger"></i>  Student Login</h5></a>
						<hr>
						<a class="corner-links" href="jsp/search_student_record.jsp"><h5><i class="fas fa-hand-point-right text-danger"></i>  Search Student Record</h5></a>
						<hr>
						<a class="corner-links" href="jsp/sforgot_password.jsp"><h5><i class="fas fa-hand-point-right text-danger"></i>  Forgot Password</h5></a>
						<hr>
						<a class="corner-links" href="jsp/find_institutes.jsp"><h5><i class="fas fa-hand-point-right text-danger"></i>  Institutes & Courses</h5></a>
						<hr>
						<a class="corner-links" href="jsp/find_courses.jsp"><h5><i class="fas fa-hand-point-right text-danger"></i>  Courses of Institutes</h5></a>
					</div>
				</div>

				<!--Fill Application Form-->
				<div class="card bg-white shadow student-corner-card">
					<div class="card-body student-corner-card-body">
						<img src="static/images/apply-form-icon.png" class="img-fluid mx-auto d-block rounded-circle card-icon" alt="Apply Form Icon">
						<h4 class="mb-2 text-center">Fill Application Form</h4>
						<img src="static/images/sub-heading-line.png" class="img-fluid mx-auto d-block" alt="Sub Heading Line"><br>
						<a class="corner-links" href="jsp/pms_scheme_dashboard.jsp?scheme_id=pms"><h5><i class="fas fa-hand-point-right text-danger"></i>  Fill Post Matric Scholarship Application Form</h5></a>
						<hr>
						<a class="corner-links" href="jsp/mmvy_scheme_dashboard.jsp?scheme_id=mmvy"><h5><i class="fas fa-hand-point-right text-danger"></i>  Fill MMVY Scholarship Application Form</h5></a>
						<hr>
						<a class="corner-links" href="jsp/mmjky_scheme_dashboard.jsp?scheme_id=mmjky"><h5><i class="fas fa-hand-point-right text-danger"></i>  Fill MMJKY Scholarship Application Form</h5></a>
						<hr>
						<a class="corner-links" href="jsp/pk_scheme_dashboard.jsp?scheme_id=pk"><h5><i class="fas fa-hand-point-right text-danger"></i>  Fill Pratibha Kiran Scholarship Application Form</h5></a>
						<hr>
						<a class="corner-links" href="jsp/gkb_scheme_dashboard.jsp?scheme_id=gkb"><h5><i class="fas fa-hand-point-right text-danger"></i>  Fill Gaon Ki Beti Scholarship Application Form</h5></a>
					</div>
				</div>
			</div>
		</div>

		<div class="container mt-4 mb-4">
			<div class="card-deck mt-3">
				<!--Institute Corner-->
				<div class="card bg-white shadow student-corner-card">
					<div class="card-body student-corner-card-body">
						<img src="static/images/institute-icon.png" class="img-fluid mx-auto d-block rounded-circle card-icon" alt="Institute Icon">
						<h4 class="mb-2 text-center">Institute Corner</h4>
						<img src="static/images/sub-heading-line.png" class="img-fluid mx-auto d-block" alt="Sub Heading Line"><br>
						<a class="corner-links" href="jsp/ilogin.jsp"><h5><i class="fas fa-hand-point-right text-danger"></i>  Institute Login</h5></a>
						<hr>
						<a class="corner-links" href="jsp/find_institutes.jsp"><h5><i class="fas fa-hand-point-right text-danger"></i>  Find Your Institute Code</h5></a>
						<hr>
						<a class="corner-links" href="jsp/find_courses.jsp"><h5><i class="fas fa-hand-point-right text-danger"></i>  Running Courses</h5></a>
					</div>
				</div>

				<!--Track Application Status-->
				<div class="card bg-white shadow student-corner-card">
					<div class="card-body student-corner-card-body">
						<img src="static/images/eye-icon.png" class="img-fluid mx-auto d-block rounded-circle card-icon" alt="Track Application Eye Icon">
						<h4 class="mb-2 text-center">Track Application Status</h4>
						<img src="static/images/sub-heading-line.png" class="img-fluid mx-auto d-block" alt="Sub Heading Line"><br>
						<a class="corner-links" href="jsp/track_application.jsp"><h5><i class="fas fa-hand-point-right text-danger"></i>  Track Post Matric Scholarship Application Status</h5></a>
						<hr>
						<a class="corner-links" href="jsp/track_application.jsp"><h5><i class="fas fa-hand-point-right text-danger"></i>  Track MMVY Scholarship Application Status</h5></a>
						<hr>
						<a class="corner-links" href="jsp/track_application.jsp"><h5><i class="fas fa-hand-point-right text-danger"></i>  Track MMJKY Scholarship Application Status</h5></a>
						<hr>
						<a class="corner-links" href="jsp/track_application.jsp"><h5><i class="fas fa-hand-point-right text-danger"></i>  Track Pratibha Kiran Scholarship Application Status</h5></a>
						<hr>
						<a class="corner-links" href="jsp/track_application.jsp"><h5><i class="fas fa-hand-point-right text-danger"></i>  Track Gaon Ki Beti Scholarship Application Status</h5></a>
					</div>
				</div>
			</div>
		</div>

		<!--Footer-->
		<!-- Footer - Upper -->
		<div class="container-fluid footer-upper text-center">
			<div class="row pt-2 pb-2">
				<!--Digital India Logo-->
				<div class="col-md-3 text-center">
					<img src="static/images/digitalindia.png" class="img-fluid" alt="Digital India Logo">
				</div>
				<!--Footer Note-->
				<div class="col-md-6 text-center">
					<h6 class="text-light">The system is operated by the concerned officials and officers of the department as per the Instructions/orders. Data, contents, processes are fully managed and updated by the department officials.</h6>
				</div>
				<!--UPC Logo-->
				<div class="col-md-3 text-center">
					<img src="static/images/upc-logo.png" class="img-fluid upc-logo" alt="UPC Logo">
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
		<script src="js/common.js"></script>
		<script src="js/index.js"></script>	
	</body>
</html>