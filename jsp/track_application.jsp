<!--Page Encoding - Unicode-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--Check if Student or Institute Logged in or not-->
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
		<title>Track Scholarship Application</title>
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
		<script src="../js/jquery-3.5.1.js"></script>
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
	      			<!--If Student Logged in Show Dashboard Link-->
	      			<%
			      		if(student_logged_in)
						{
					%>
				      		<!--Student Dashboard Page Link-->
			      			<li class="nav-item">
			        			<a class="nav-link" href="sdashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
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
			        			<a class="nav-link" href="idashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
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
							        	<a class="dropdown-item" href="slogin.jsp"><i class="fa fa-user-graduate"></i> Student Login</a>
							        	<!--Institute Login Page Link-->
							        	<a class="dropdown-item" href="ilogin.jsp"><i class="fa fa-university"></i> Institute Login</a>
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
				        			<a class="nav-link" href="Student_Logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
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
				        			<a class="nav-link" href="Institute_Logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
				      			</li>
					    	</ul>
			    	<%
			    		}
			    	%>
		  	</div>
		</nav>

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

		<!--Track Scholarship Application Heading & Instructions-->
		<div class="container mt-4 mb-0">
			<div class="alert alert-primary text-left mb-0">
				Track Scholarship Application Status<br>
				Help: You can Track Scholarship Application Status by entering Application Id.
			</div>
		</div>
		<!--Track Scholarship Application-->
		<div class="container mt-0">
			<form name="application_id_form" class="border pr-2 pl-2 mb-2">
				<div class="row">
					<!--Institute Name Input Text Box-->
					<div class="col-md-12 mb-2">
						Application Id:
						<input class="form-control" value="" type="text" name="application_id" placeholder="Application Id" maxlength="6">
					</div>
				</div>
			</form>
		</div>

		<div class="container text-center mb-4">
			<!--Track Application Status Button-->
			<button id="track_application_status" class="btn btn-success" onclick="send_application_data()">
				<span id="loading_spinner" class=""></span>
				Track Scholarship Application
			</button>
			<!--Error Division-->
			<div id="error" class=""></div>
		</div>

		<!--Loading Data Division-->
		<div class="loading_modal" id="loading_modal"></div>

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
		<script src="../js/track_application.js"></script>
	</body>
</html>