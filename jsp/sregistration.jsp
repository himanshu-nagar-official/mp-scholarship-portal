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
	if(applicant_id!=null && student_name!=null)
	{ 
		response.sendRedirect("sdashboard.jsp");
		return; 
	}
%>

<!--HTML 5 Document Starting-->
<!DOCTYPE html>
<html lang="en">
	<head>
		<!--Title of Webpage-->
		<title>Student Registration</title>
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
		<!--Date Picker CSS Linking-->
		<link rel="stylesheet" type="text/css" href="../css/daterangepicker.css">
		<!--Fontawesome CSS Linking-->
		<link rel="stylesheet" type="text/css" href="../fontawesome/css/all.css">
		<!--User Defined CSS Linking-->
		<link rel="stylesheet" type="text/css" href="../css/common.css">
		<link rel="stylesheet" type="text/css" href="../css/sregistration.css">
		<!--jQuery Imports-->
		<script src="../js/jquery-3.5.1.slim.js"></script>
		<!--Bootstrap JavaScript Imports-->
		<script src="../js/popper.min.js"></script>
		<script src="../js/bootstrap.min.js"></script>
		<!--Date Picker JavaScript Imports-->
		<script src="../js/moment.min.js"></script>
		<script src="../js/daterangepicker.min.js"></script>
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

		<!--Message & Student Registration-->
		<div class="container text-center mt-4 mb-4">
			<!--If any message available in http request-->
			<% 
				if(!(request.getAttribute("message")==null))
				{
			%>
					<!--Show Message-->
					<div class="alert alert-danger alert-dismissible fade show text-center">
						<button type="button" class="close" data-dismiss="alert">&times;</button>
						<strong>${requestScope.message}</strong>
					</div>
			<%
				}
			%>

			<!--Student Registration Form-->
			<form action="Student_Registration" method="post" class="registration-form pl-4 pr-4" onsubmit="return validateFormData()">
				<img class="img-fluid mt-2" src="../static/images/logo.png" alt="MP State Scholarship Logo">
				<hr>
				<h3>Student Registration</h3>
				<img src="../static/images/avatar.gif" class="img-fluid avatar rounded-circle mb-2" alt="Login Avatar">
				<div class="form-row">
					<!--Student Name Input Text Box-->
					<div class="col-md-6">
						<label class="form-label float-left" for="student_name">Student Name</label>
						<input class="form-control mb-3" type="text" id="student_name" name="student_name" placeholder="Student Name" onkeyup="return studentNameValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off">
						<!--Client Side Validation Error for Student Name-->
						<p id="student_name_check" class="text-danger"></p>
					</div>

					<!--Student Father Name Input Text Box-->
					<div class="col-md-6">
						<label class="form-label float-left" for="father_name">Father Name</label>
						<input class="form-control mb-3" type="text" id="father_name" name="student_father_name" placeholder="Father Name" onkeyup="return fatherNameValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off">
						<!--Client Side Validation Error for Student Father Name-->
						<p id="father_name_check" class="text-danger"></p>
					</div>
				</div>

				<div class="form-row">
					<!--Student Date of Birth Date Picker-->
					<div class="col-md-6">
						<label class="form-label float-left" for="student_dob">Date of Birth</label>
						<input class="form-control" type="text" placeholder="DD/MM/YYYY" name="student_dob" id="student_dob" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off">
						<!--Client Side Validation Error for Student Date of Birth-->
						<p id="student_dob_check" class="text-danger"></p>
					</div>

					<!--Student Gender Input Radio Buttons-->
					<div class="col-md-6">
						<label class="form-label w-100 float-left text-left mb-3">Gender</label>
						<div class="custom-control custom-radio custom-control-inline float-left">
							<input type="radio" class="custom-control-input" id="male" name="student_gender" value="Male" onclick="return genderValidation();" checked>
						    <label class="custom-control-label" for="male">Male</label>
						</div>
						<div class="custom-control custom-radio custom-control-inline float-left">
						    <input type="radio" class="custom-control-input" id="female" name="student_gender" value="Female" onclick="return genderValidation();">
						    <label class="custom-control-label" for="female">Female</label>
						</div>
						<div class="custom-control custom-radio custom-control-inline float-left">
						    <input type="radio" class="custom-control-input" id="other" name="student_gender" value="Other" onclick="return genderValidation();">
						    <label class="custom-control-label" for="other">Other</label>
						</div>
						<!--Client Side Validation Error for Student Gender-->
						<p id="gender_check" class="text-danger"></p>
					</div>
				</div>

				<div class="form-row">
					<!--Student Category Input Select Box-->
					<div class="col-md-6">
						<label class="form-label float-left" for="student_category">Category</label>
						<select class="form-control mb-3" id="student_category" name="student_category" onchange="studentCategoryValidation();">
							<option value="">--Select Category--</option>
							<option value="General">General</option>
							<option value="Economically Weaker Section">Economically Weaker Section</option>
							<option value="Other Backward Class (OBC)">Other Backward Class (OBC)</option>
							<option value="Scheduled Caste (SC)">Scheduled Caste (SC)</option>
							<option value="Scheduled Tribe (ST)">Scheduled Tribe (ST)</option>
						</select>
						<!--Client Side Validation Error for Student Category-->
						<p id="student_category_check" class="text-danger"></p>
					</div>

					<!--Student Religion Input Select Box-->
					<div class="col-md-6">
						<label class="form-label float-left" for="student_religion">Religion</label>
						<select class="form-control mb-3" id="student_religion" name="student_religion" onchange="studentReligionValidation();">
							<option value="">--Select Religion--</option>
							<option value="Hindu">Hindu</option>
							<option value="Jain">Jain</option>
							<option value="Sikh">Sikh</option>
							<option value="Buddh">Buddh</option>
							<option value="Christian">Christian</option>
							<option value="Muslim">Muslim</option>
						</select>
						<!--Client Side Validation Error for Student Religion-->
						<p id="student_religion_check" class="text-danger"></p>
					</div>
				</div>

				<div class="form-row">
					<!--Student Mobile Input Text Box-->
					<div class="col-md-6">
						<label class="form-label float-left" for="student_mobile">Mobile Number</label>
						<input type="text" class="form-control mb-3" id="student_mobile" name="student_mobile" placeholder="Mobile Number" onkeyup="studentMobileValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off" maxlength="10" minlength="10">
						<!--Client Side Validation Error for Student Mobile-->
						<p id="student_mobile_check" class="text-danger"></p>
					</div>

					<!--Student Email Id Input Text Box-->
					<div class="col-md-6">
						<label class="form-label float-left" for="student_email">Email Id</label>
						<input type="text" class="form-control mb-3" id="student_email" name="student_email" placeholder="Email Id" onkeyup="studentEmailValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off">
						<!--Client Side Validation Error for Student Email-->
						<p id="student_email_check" class="text-danger"></p>
					</div>
				</div>

				<div class="form-row">
					<!--Student Aadhaar Number Input Text Box-->
					<div class="col-md-6">
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

					<!--Student Samagra Id Input Text Box-->
					<div class="col-md-6">
						<label class="form-label float-left" for="student_samagra">Samagra Id</label>
						<input type="text" class="form-control mb-3" id="student_samagra" name="student_samagra" placeholder="Samagra Id" onkeyup="studentSamagraValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false"  maxlength="9" minlength="9">
						<!--Client Side Validation Error for Student Samagra Id-->
						<p id="student_samagra_check" class="text-danger"></p>
					</div>
				</div>

				<div class="form-row">
					<!--Student Area Input Select Box-->
					<div class="col-md-6">
						<label class="form-label float-left" for="student_area">Area</label>
						<select class="form-control mb-3" id="student_area" name="student_area" onchange="studentAreaValidation();">
							<option value="">--Select Area--</option>
							<option value="Urban">Urban</option>
							<option value="Rural">Rural</option>
						</select>
						<!--Client Side Validation Error for Student Area-->
						<p id="student_area_check" class="text-danger"></p>
					</div>

					<!--Student State Input Select Box-->
					<div class="col-md-6">
						<label class="form-label float-left" for="student_state">State</label>
						<select class="form-control mb-3" id="student_state" name="student_state" onchange="studentStateValidation();">
							<option value="">--Select State--</option>
							<option value="Andhra Pradesh">Andhra Pradesh</option>
							<option value="Andaman and Nicobar Islands">Andaman and Nicobar Islands</option>
							<option value="Arunachal Pradesh">Arunachal Pradesh</option>
							<option value="Assam">Assam</option>
							<option value="Bihar">Bihar</option>
							<option value="Chandigarh">Chandigarh</option>
							<option value="Chhattisgarh">Chhattisgarh</option>
							<option value="Dadar and Nagar Haveli">Dadar and Nagar Haveli</option>
							<option value="Daman and Diu">Daman and Diu</option>
							<option value="Delhi">Delhi</option>
							<option value="Lakshadweep">Lakshadweep</option>
							<option value="Puducherry">Puducherry</option>
							<option value="Goa">Goa</option>
							<option value="Gujarat">Gujarat</option>
							<option value="Haryana">Haryana</option>
							<option value="Himachal Pradesh">Himachal Pradesh</option>
							<option value="Jammu and Kashmir">Jammu and Kashmir</option>
							<option value="Jharkhand">Jharkhand</option>
							<option value="Karnataka">Karnataka</option>
							<option value="Kerala">Kerala</option>
							<option value="Madhya Pradesh">Madhya Pradesh</option>
							<option value="Maharashtra">Maharashtra</option>
							<option value="Manipur">Manipur</option>
							<option value="Meghalaya">Meghalaya</option>
							<option value="Mizoram">Mizoram</option>
							<option value="Nagaland">Nagaland</option>
							<option value="Odisha">Odisha</option>
							<option value="Punjab">Punjab</option>
							<option value="Rajasthan">Rajasthan</option>
							<option value="Sikkim">Sikkim</option>
							<option value="Tamil Nadu">Tamil Nadu</option>
							<option value="Telangana">Telangana</option>
							<option value="Tripura">Tripura</option>
							<option value="Uttar Pradesh">Uttar Pradesh</option>
							<option value="Uttarakhand">Uttarakhand</option>
							<option value="West Bengal">West Bengal</option>
						</select>
						<!--Client Side Validation Error for Student State-->
						<p id="student_state_check" class="text-danger"></p> 	
					</div>
				</div>

				<div class="form-row">
					<!--Student District Input Text Box-->
					<div class="col-md-6">
						<label class="form-label float-left" for="student_district">District</label>
						<input type="text" class="form-control mb-3" id="student_district" name="student_district" placeholder="District" onkeyup="studentDistrictValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false">
						<!--Client Side Validation Error for Student District-->
						<p id="student_district_check" class="text-danger"></p> 	
					</div>

					<!--Student Pincode Input Text Box-->
					<div class="col-md-6">
						<label class="form-label float-left" for="student_pincode">Pincode</label>
						<input type="text" class="form-control mb-3" id="student_pincode" name="student_pincode" placeholder="Pincode" onkeyup="studentPincodeValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false"  maxlength="6" minlength="6">
						<!--Client Side Validation Error for Student Pincode-->
						<p id="student_pincode_check" class="text-danger"></p>
					</div>
				</div>

				<div class="form-row">
					<!--Student Password Input Password Box-->
					<div class="col-md-6">
						<label class="form-label float-left" for="student_password">Password</label>
						<div class="input-group">
							<input type="password" class="form-control" id="student_password" name="student_password" placeholder="Password" onkeyup="studentPasswordValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off" minlength="8" maxlength="15">
							<div class="input-group-append">
								<span class="input-group-text eye_icon"><i id="eye_icon" class="fas fa-eye" onclick="showPassword();"></i></span>
							</div>
						</div>
						<!--Client Side Validation Error for Student Password-->
						<p id="student_password_check" class="text-danger"></p> 	
					</div>

					<!--Student Address Textarea-->
					<div class="col-md-6">
						<label class="form-label float-left" for="student_address">Address</label>
						<textarea class="form-control mb-3" id="student_address" name="student_address" placeholder="Address" onkeyup="studentAddressValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off" minlength="3"></textarea>
						<!--Client Side Validation Error for Student Address-->
						<p id="student_address_check" class="text-danger"></p>
					</div>
				</div>

				<!--Registration Button-->
				<input class="btn btn-lg btn-primary mb-2 mt-2" type="submit" name="register" value="Register">	
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
		<script src="../js/sregistration.js"></script>
	</body>
</html>