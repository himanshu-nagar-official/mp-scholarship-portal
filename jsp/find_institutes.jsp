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
		<title>Find Institutes & Courses</title>
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
		<!--Datatables CSS Linking-->
		<link rel="stylesheet" type="text/css" href="../css/dataTables.bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="../css/fixedHeader.bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="../css/responsive.bootstrap.min.css">
		<!--Fontawesome CSS Linking-->
		<link rel="stylesheet" type="text/css" href="../fontawesome/css/all.css">
		<!--User Defined CSS Linking-->
		<link rel="stylesheet" type="text/css" href="../css/common.css">
		<!--jQuery Imports-->
		<script src="../js/jquery-3.5.1.js"></script>
		<!--Datatables Imports-->
		<script src="../js/jquery.dataTables.min.js"></script>
		<script src="../js/dataTables.bootstrap4.min.js"></script>
		<script src="../js/dataTables.fixedHeader.min.js"></script>
		<script src="../js/dataTables.responsive.min.js"></script>
		<script src="../js/responsive.bootstrap.min.js"></script>
		<!--Bootstrap JavaScript Imports-->
		<script src="../js/popper.min.js"></script>
		<script src="../js/bootstrap.min.js"></script>
		<script src="../js/moment.min.js"></script>
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

		<!--Find Institutes Heading & Instructions-->
		<div class="container mt-4 mb-0">
			<div class="alert alert-primary text-left mb-0">
				Find Institute(s), Institutes Codes<br>
				Help: You can Find Institute Code and Other Details of Institute.
			</div>
		</div>
		<!--Find Institutes Form-->
		<div class="container mt-0">
			<form name="ins_data" class="border pr-2 pl-2 mb-2">
				<div class="row">
					<!--Institute State Select Box-->
					<div class="col-md-6">
						Institute State:
						<select class="form-control mb-2" name="ins_sta" disabled>
							<option value="Madhya Pradesh">Madhya Pradesh</option>
						</select>
					</div>
					<!--Institute Department Select Box-->
					<div class="col-md-6">
						Department:
						<select class="form-control mb-2" name="ins_dep">
							<option value="All Department">-- All Department --</option>
							<option value="Directorate of Technical Education">Directorate of Technical Education</option>
							<option value="Higher Education">Higher Education</option>
							<option value="Directorate of Skill Development">Directorate of Skill Development</option>
							<option value="Directorate of Medical Education">Directorate of Medical Education</option>
						</select>
					</div>
				</div>
				<div class="row">
					<!--Institute District Select Box-->
					<div class="col-md-6">
						Institute District:
						<select class="form-control mb-2" name="ins_dis">
							<option value="">-- Select --</option>
							<option value="Agar Malwa">Agar Malwa</option>
							<option value="Alirajpur">Alirajpur</option>
							<option value="Anuppur">Anuppur</option>
							<option value="Ashoknagar">Ashoknagar</option>
							<option value="Badwani">Badwani</option>
							<option value="Balaghat">Balaghat</option>
							<option value="Betul">Betul</option>
							<option value="Bhind">Bhind</option>
							<option value="Bhopal">Bhopal</option>
							<option value="Burhanpur">Burhanpur</option>
							<option value="Chhatarpur">Chhatarpur</option>
							<option value="Chhindwara">Chhindwara</option>
							<option value="Damoh">Damoh</option>
							<option value="Datia">Datia</option>
							<option value="Dewas">Dewas</option>
							<option value="Dhar">Dhar</option>
							<option value="Dindori">Dindori</option>
							<option value="Guna">Guna</option>
							<option value="Gwalior">Gwalior</option>
							<option value="Harda">Harda</option>
							<option value="Hoshangabad">Hoshangabad</option>
							<option value="Indore">Indore</option>
							<option value="Jabalpur">Jabalpur</option>
							<option value="Jhabua">Jhabua</option>
							<option value="Katni">Katni</option>
							<option value="Khandwa">Khandwa</option>
							<option value="Khargone">Khargone</option>
							<option value="Mandla">Mandla</option>
							<option value="Mandsaur">Mandsaur</option>
							<option value="Morena">Morena</option>
							<option value="Narsinghpur">Narsinghpur</option>
							<option value="Neemuch">Neemuch</option>
							<option value="Niwari">Niwari</option>
							<option value="Panna">Panna</option>
							<option value="Raisen">Raisen</option>
							<option value="Rajgarh">Rajgarh</option>
							<option value="Ratlam">Ratlam</option>
							<option value="Rewa">Rewa</option>
							<option value="Sagar">Sagar</option>
							<option value="Satna">Satna</option>
							<option value="Sehore">Sehore</option>
							<option value="Seoni">Seoni</option>
							<option value="Shahdol">Shahdol</option>
							<option value="Shajapur">Shajapur</option>
							<option value="Sheopur">Sheopur</option>
							<option value="Shivpuri">Shivpuri</option>
							<option value="Sidhi">Sidhi</option>
							<option value="Singrauli">Singrauli</option>
							<option value="Tikamgarh">Tikamgarh</option>
							<option value="Ujjain">Ujjain</option>
							<option value="Umaria">Umaria</option>
							<option value="Vidisha">Vidisha</option>
						</select>
					</div>
					<!--Institute Name Input Text Box-->
					<div class="col-md-6 mb-2">
						Institute Name:
						<input class="form-control" value="" type="text" name="ins_name" placeholder="Starting 10 Char Of Inst. Name" maxlength="10">
					</div>
				</div>
				<div class="row">
					<!--Institute Code Input Text Box-->
					<div class="col-md-6 mb-2">
						Institute Code(Optional):
						<input class="form-control" value="" type="text" name="ins_code" placeholder="Institute Code" maxlength="5">
					</div>
				</div>
			</form>
		</div>

		<div class="container text-center mb-4">
			<!--Send Institute Data Button-->
			<button id="show_institute_btn" class="btn btn-primary" onclick="send_ins_data()">
				<span id="loading_spinner" class=""></span>
				Show Institutes
			</button>
			<!--Error Division-->
			<div id="error" class=""></div>
		</div>

		<!--Institute Received Data Table-->
		<div class="container-fluid pr-4 pl-4 mb-4">
			<div class="table-responsive">
				<table id="institute_table" class="table table-bordered table-striped nowrap" style="width: 100%"></table>
			</div>
		</div>

		<!--Institutes & Courses Mapping Modal-->
		<div class="modal fade" id="institutes_courses_modal" role="dialog" data-backdrop="static" data-keyboard="false">
		    <div class="modal-dialog modal-xl">
		    	<!-- Modal content-->
		    	<div class="modal-content">
			        <div class="modal-header">
			        	<h6 class="modal-title">Course (Branch) names & Codes and Details for <span id="ins_name_heading"></span></h6>
			        	<button type="button" class="close" data-dismiss="modal">&times;</button>
			        </div>
			        <div class="modal-body">
			        	<div class="alert alert-info">
			        		Help: This page displays list and codes of recognized courses, branches and their codes running in corresponding Institute. Please note down the code of your institute.It will be required at the time of submitting the application
			        	</div>
		        		<table class="table table-bordered">
		        			<tr>
		        				<td>Institute Code:</td>
		        				<td id="ins_code_body"></td>
		        				<td>Institute:</td>
		        				<td id="ins_name_body"></td>
		        			</tr>
		        			<tr>
		        				<td>District:</td>
		        				<td id="ins_district_body"></td>
		        				<td>Address:</td>
		        				<td id="ins_address_body"></td>
		        			</tr>
		        		</table>
		        		<p id="message" class="text-center"></p>
		        		<div class="table-responsive">
							<table id="courses_mapping_table" class="table table-bordered table-striped">
							</table>
						</div>
			        </div>
			        <div class="modal-footer">
			        	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			        </div>
		    	</div>
			</div>
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
		<script src="../js/find_institutes.js"></script>
		<script src="../js/find_courses_mapping.js"></script>
	</body>
</html>