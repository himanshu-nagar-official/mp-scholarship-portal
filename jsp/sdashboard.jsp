<!--Page Encoding - Unicode-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--Check if Student or Institute Logged in or not-->
<%
	String ins_code =(String)session.getAttribute("ins_code");
	String ins_name =(String)session.getAttribute("ins_name");
	if(ins_code!=null && ins_name!=null)
	{ 
		response.sendRedirect("idashboard.jsp");
		return; 
	}
	String applicant_id =(String)session.getAttribute("applicant_id");
	String student_name =(String)session.getAttribute("student_name");
	if(applicant_id==null||student_name==null)
	{ 
		response.sendRedirect("slogin.jsp");
		return; 
	}
%>

<!--HTML 5 Document Starting-->
<!DOCTYPE html>
<html lang="en">
	<head>
		<!--Title of Webpage-->
		<title>Student Dashboard</title>
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
		<link rel="stylesheet" type="text/css" href="../css/sdashboard.css">
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
		    	<ul class="nav navbar-nav navbar-left">
	    			<!--Home Page Link-->
	      			<li class="nav-item">
	        			<a class="nav-link" href="../index.jsp"><i class="fas fa-home"></i> Home</a>
	      			</li>
	      			<!--Student Dashboard Page Link-->
	      			<li class="nav-item link-active">
	        			<a class="nav-link" href="sdashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
	      			</li>
		    	</ul>
		    	<ul class="nav navbar-nav ml-auto">
		    		<!--Logout-->
      				<li class="nav-item logout-link">
	        			<a class="nav-link" href="Student_Logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
	      			</li>
		    	</ul>
		  	</div>
		</nav>

		<div class="container-fluid mt-2 mb-2">
			<h5>Welcome, <strong><%=student_name%>(<%=applicant_id%>)</strong></h5>
			<hr>
		</div>

		<div class="container mt-4 mb-4">
			<div class="row">
				<div class="col-md-4">
					<div class="card border-dark text-light mb-3 shadow">
						<div class="card-header bg-primary border-dark"><h5>Apply for Post Metric Scholarship</h5></div>
						<div class="card-body text-dark">
					    	<p class="card-text">Post Metric Scholarship for SC, ST, OBC & for Nomadic/Semi-Nomadic / De-Notified tribes.</p>
					  	</div>
					  	<div class="card-footer bg-transparent border-dark text-primary"><a class="apply-view-links" href="pms_scheme_dashboard.jsp?scheme_id=pms">Apply Online/View Application</a></div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="card border-dark text-light mb-3 shadow">
						<div class="card-header bg-info border-dark"><h5>Apply for MMVY Scholarship</h5></div>
						<div class="card-body text-dark">
					    	<p class="card-text">Mukhyamantri Medhavi Vidhyarthi Yojna Scholarship for students who are meritorius.</p>
					  	</div>
					  	<div class="card-footer bg-transparent border-dark text-primary"><a class="apply-view-links" href="mmvy_scheme_dashboard.jsp?scheme_id=mmvy">Apply Online/View Application</a></div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="card border-dark text-light mb-3 shadow">
						<div class="card-header bg-danger border-dark"><h5>Apply for MMJKY Scholarship</h5></div>
						<div class="card-body text-dark">
					    	<p class="card-text">Mukyamantri Jan Kalyan Yojna Scholarship for applicant who are eligible for the scheme.</p>
					  	</div>
					  	<div class="card-footer bg-transparent border-dark text-primary"><a class="apply-view-links" href="mmjky_scheme_dashboard.jsp?scheme_id=mmjky">Apply Online/View Application</a></div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-2">
			
				</div>
				<div class="col-md-4">
					<div class="card border-dark text-light mb-3 shadow">
						<div class="card-header bg-warning border-dark"><h5>Gaon Ki Beti</h5></div>
						<div class="card-body text-dark">
					    	<p class="card-text">Scheme is for Girls who have passed her 12th Exam with 60% or above and is a resident of RURAL Areas of Madhya Pradesh.</p>
					  	</div>
					  	<div class="card-footer bg-transparent border-dark text-primary"><a class="apply-view-links" href="gkb_scheme_dashboard.jsp?scheme_id=gkb">Apply Online/View Application</a></div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="card border-dark text-light mb-3 shadow">
						<div class="card-header bg-success border-dark"><h5>Pratibha Kiran</h5></div>
						<div class="card-body text-dark">
					    	<p class="card-text">Scheme is for Girls who have passed her 12th Exam with 60% or above and is resident of URBAN Areas of Madhya Pradesh..</p>
					  	</div>
					  	<div class="card-footer bg-transparent border-dark text-primary"><a class="apply-view-links" href="pk_scheme_dashboard.jsp?scheme_id=pk">Apply Online/View Application</a></div>
					</div>
				</div>
				<div class="col-md-2">
			
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
	</body>
</html>