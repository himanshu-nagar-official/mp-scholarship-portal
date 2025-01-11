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
	Boolean student_logged_in = false;
	if(applicant_id!=null&&student_name!=null)
	{ 
		student_logged_in = true; 
	}
%>

<!--HTML 5 Document Starting-->
<!DOCTYPE html>
<html lang="en">
	<head>
		<!--Title of Webpage-->
		<title>Search Student Record</title>
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
		      		<%
			      		if(!student_logged_in)
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
			    	<%
			    		if(student_logged_in)
			    		{
			    	%>
					    	<ul class="nav navbar-nav ml-auto">
					    		<!--Logout-->
			      				<li class="nav-item logout-link">
				        			<a class="nav-link" href="Student_Logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
				      			</li>
					    	</ul>
			    	<%
			    		}
			    	%>
		  	</div>
		</nav>

		<%
			if(student_logged_in)
    		{
		%>
				<div class="container-fluid mt-2 mb-2">
					<h5>Welcome, <strong><%=student_name%>(<%=applicant_id%>)</strong></h5>
					<hr>
				</div>
		<%
			}
		%>

		<!--Search Student Record Heading & Instructions-->
		<div class="container mt-4 mb-0">
			<div class="alert alert-primary text-left mb-0">
				Search Student Record<br>
				Help: You can Find Student Record and Other Details of Student.
			</div>
		</div>
		<!--Search Student Record Form-->
		<div class="container mt-0">
			<form name="search_student_record" class="border pr-2 pl-2 mb-2">
				<div class="form-row">
					<!--Student Name Input Text Box-->
					<div class="col-md-6">
						<label class="form-label float-left" for="student_name">Student Name</label>
						<input class="form-control mb-3" type="text" id="student_name" name="student_name" placeholder="Student Name" onkeyup="return studentNameValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off">
						<!--Client Side Validation Error for Student Name-->
						<p id="student_name_check" class="text-danger"></p>
					</div>

					<!--Student Gender Input Select Box-->
					<div class="col-md-6">
						<label class="form-label float-left" for="student_gender">Gender</label>
						<select class="form-control mb-3" id="student_gender" name="student_gender" onchange="studentGenderValidation();">
							<option value="">--Select Gender--</option>
							<option value="Male">Male</option>
							<option value="Female">Female</option>
							<option value="Other">Other</option>
						</select>
						<!--Client Side Validation Error for Student Gender-->
						<p id="student_gender_check" class="text-danger"></p>
					</div>
				</div>

				<!--Aadhaar Number or Email Id in Student Record Search-->
				<div class="form-row">
					<div class="col-md-6">
						<div class="custom-control custom-radio custom-control-inline float-left">
							<input type="radio" class="custom-control-input" id="aadhaar_number" name="search_criteria" value="Aadhaar Number" onclick="switchAadhaarEmail();" checked>
						    <label class="custom-control-label" for="aadhaar_number">Aadhaar Number</label>
						</div>
						<div class="custom-control custom-radio custom-control-inline float-left">
						    <input type="radio" class="custom-control-input" id="email_id" name="search_criteria" value="Email Id" onclick="switchAadhaarEmail();">
						    <label class="custom-control-label" for="email_id">Email Id</label>
						</div>
					</div>
				</div>
				<div class="form-row mt-2">
					<!--Student Aadhaar Number Input Text Box-->
					<div class="col-md-6" id="aadhaarNumberDiv">
						<label class="form-label float-left" for="aadhaar1">Aadhaar Number</label>
						<input type="hidden" class="form-control mb-3" id="student_aadhaar" name="student_aadhaar" onkeyup="studentAadhaarValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false">
						<div class="input-group">
						  <input id="aadhaar1" type="text" class="form-control text-center" onkeyup="studentAadhaarValidation();" maxlength="4" placeholder="XXXX" style="letter-spacing: 10px;">
						  <b style="font-size: 25px;">-</b>
						  <input id="aadhaar2" type="text" class="form-control text-center" onkeyup="studentAadhaarValidation();" maxlength="4" placeholder="XXXX" style="letter-spacing: 10px;">
						  <b style="font-size: 25px;">-</b>
						  <input id="aadhaar3" type="text" class="form-control text-center" onkeyup="studentAadhaarValidation();" maxlength="4" placeholder="XXXX" style="letter-spacing: 10px;">
						</div>
						<!--Client Side Validation Error for Aadhaar Number-->
						<p id="student_aadhaar_check" class="text-danger"></p>
					</div>
					<!--Student Email Id Input Text Box-->
					<div class="col-md-6" id="emailIdDiv" style="display: none;">
						<label class="form-label float-left" for="student_email">Email Id</label>
						<input type="text" class="form-control mb-3" id="student_email" name="student_email" placeholder="Email Id" onkeyup="studentEmailValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off">
						<!--Client Side Validation Error for Student Email-->
						<p id="student_email_check" class="text-danger"></p>
					</div>
				</div>
			</form>
		</div>

		<div class="container text-center mb-4">
			<!--Send Student Data Button-->
			<button id="search_student_btn" class="btn btn-primary" onclick="send_student_data()">
				<span id="loading_spinner" class=""></span>
				Search
			</button>
			<!--Error Division-->
			<div id="error" class=""></div>
		</div>

		<!--Search Student Record Modal-->
		<div class="modal fade" id="search_student_record_modal" role="dialog" data-backdrop="static" data-keyboard="false">
		    <div class="modal-dialog modal-xl">
		    	<!-- Modal content-->
		    	<div class="modal-content">
			        <div class="modal-header">
			        	<h6 class="modal-title">Student Registration Details<span id="ins_name_heading"></span></h6>
			        	<button type="button" class="close" data-dismiss="modal">&times;</button>
			        </div>
			        <div class="modal-body">
		        		<img onerror="this.src='../static/images/image-not-available.jpg'" src="" alt="Student Photo" id="student_photo" class="img-fluid rounded-circle border border-dark mx-auto d-block mb-2" width="200" height="200">
		        		<div class="table-responsive">
		        			<table class="table table-bordered">
			        			<tr>
			        				<th>Applicant Id:</th>
			        				<td id="applicant_id_body"></td>
			        				<th>Student Name:</th>
			        				<td id="student_name_body"></td>
			        			</tr>
			        			<tr>
			        				<th>Father Name:</th>
			        				<td id="father_name_body"></td>
			        				<th>Date of Birth:</th>
			        				<td id="student_dob_body"></td>
			        			</tr>
			        			<tr>
			        				<th>Student Category:</th>
			        				<td id="student_category_body"></td>
			        				<th>State:</th>
			        				<td id="student_state_body"></td>
			        			</tr>
			        			<tr>
			        				<th>District:</th>
			        				<td id="student_district_body"></td>
			        				<th>Pincode:</th>
			        				<td id="student_pincode_body"></td>
			        			</tr>
			        			<tr>
			        				<th>Address:</th>
			        				<td id="student_address_body" colspan="3"></td>
			        			</tr>
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
		<script src="../js/search_student_record.js"></script>
	</body>
</html>