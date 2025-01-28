<!--Page Encoding - Unicode-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--Page Imports-->
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.*"%>
<%@ page import="java.lang.Math"%>
<%@ page import="com.utils.db.DBConnection" %>

<!--Check if Student or Institute Logged in or not-->
<%
	String ins_code =(String)session.getAttribute("ins_code");
	String ins_name =(String)session.getAttribute("ins_name");
	if(ins_code!=null && ins_name!=null)
	{ 
		response.sendRedirect("idashboard.jsp");
		return; 
	}
	//Get Session Attributes - Applicant Id & Student Name
	String applicant_id =(String)session.getAttribute("applicant_id");
	String student_name =(String)session.getAttribute("student_name");
	Boolean application_already_registered = false;

	//Check if Applicant Id & Student Name are Available
	if(applicant_id==null||student_name==null)
	{ 
		//Redirect to Student Login Page
		response.sendRedirect("slogin.jsp");
		return; 
	}

	Date date_academic_year = new Date();
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy");
	String current_year = formatter.format(date_academic_year);
	formatter = new SimpleDateFormat("MM");
	String current_month = formatter.format(date_academic_year);
	String academic_year_val = "";
	if(Integer.valueOf(current_month)<=6)
	{
	  	int previous_year = Integer.valueOf(current_year)-1;
	  	String sliced_previous_year = String.valueOf(previous_year).substring(2,4);
	  	academic_year_val = String.valueOf(previous_year + "-" +(Integer.valueOf(sliced_previous_year)+1));
	}
	else
	{
	  	String sliced_current_year = String.valueOf(current_year).substring(2,4);
	  	academic_year_val = String.valueOf(String.valueOf(current_year) + "-" +(Integer.valueOf(sliced_current_year)+1));
	}

	//Get Web Application Path
	String applicationPath = request.getServletContext().getRealPath("");

	//Get Student Photo Path
	String photoPath = applicationPath+"/uploads/images/student_photos/"+applicant_id+".png";

	//Creating Student Photo File Object
	File student_photo = new File(photoPath);

	//Local Variables Declaration for Student Profile Data
	String student_father_name = "";
	String student_dob = "";
	String student_gender = "";
	String student_category = "";
	String student_religion = "";
	String student_email = "";
	String student_aadhaar = "";

	boolean pre_data_filling_done = true;

	//Scheme Id Local Variable Declaration
	String scheme_id = request.getParameter("scheme_id");

	//Try to Establish Database Connectivity  
	try
	{  
		//Create Connection Object
		Connection con = null;

		//Try to open Database Connection
		con = DBConnection.getConnection();

		//If Connection is Successfully Established
		if(con != null && !con.isClosed())
		{
			//Create SQL Query Local Variable
			String qry = "select * from students where applicant_id='"+applicant_id+"'";
			//Execute Select Query & Get Results
			PreparedStatement ps = con.prepareStatement(qry);  
			ResultSet rs = ps.executeQuery();
			rs.next();
			student_father_name = rs.getString("student_father_name");
			student_dob = rs.getString("student_dob");
			student_gender = rs.getString("student_gender");
			student_category = rs.getString("student_category");
			student_religion = rs.getString("student_religion");
			student_email = rs.getString("student_email");
			student_aadhaar = rs.getString("student_aadhaar");

			pre_data_filling_done = true;

			if(scheme_id.equals("pms"))
			{
				if(!student_photo.exists())
				{
					pre_data_filling_done = false;
				}
				else if(rs.getBinaryStream("caste_certificate")==null)
				{
					pre_data_filling_done = false;
				}
				else if(rs.getBinaryStream("high_school_marksheet")==null)
				{
					pre_data_filling_done = false;
				}
				else if(rs.getBinaryStream("income_certificate")==null)
				{
					pre_data_filling_done = false;
				}
				else if(rs.getBinaryStream("bank_passbook")==null)
				{
					pre_data_filling_done = false;
				}
			}
			else if(scheme_id.equals("mmvy"))
			{
				if(!student_photo.exists())
				{
					pre_data_filling_done = false;
				}
				else if(rs.getBinaryStream("high_school_marksheet")==null)
				{
					pre_data_filling_done = false;
				}
				else if(rs.getBinaryStream("higher_secondary_marksheet")==null)
				{
					pre_data_filling_done = false;
				}
				else if(rs.getBinaryStream("income_certificate")==null)
				{
					pre_data_filling_done = false;
				}
				else if(rs.getBinaryStream("bank_passbook")==null)
				{
					pre_data_filling_done = false;
				}
			}
			else if(scheme_id.equals("mmjky"))
			{
				if(!student_photo.exists())
				{
					pre_data_filling_done = false;
				}
				else if(rs.getBinaryStream("sambal_card")==null)
				{
					pre_data_filling_done = false;
				}
				else if(rs.getBinaryStream("high_school_marksheet")==null)
				{
					pre_data_filling_done = false;
				}
				else if(rs.getBinaryStream("income_certificate")==null)
				{
					pre_data_filling_done = false;
				}
				else if(rs.getBinaryStream("bank_passbook")==null)
				{
					pre_data_filling_done = false;
				}
			}
			else if(scheme_id.equals("gkb"))
			{
				if(!student_photo.exists())
				{
					pre_data_filling_done = false;
				}
				else if(rs.getBinaryStream("high_school_marksheet")==null)
				{
					pre_data_filling_done = false;
				}
				else if(rs.getBinaryStream("higher_secondary_marksheet")==null)
				{
					pre_data_filling_done = false;
				}
				else if(rs.getBinaryStream("income_certificate")==null)
				{
					pre_data_filling_done = false;
				}
				else if(rs.getBinaryStream("bank_passbook")==null)
				{
					pre_data_filling_done = false;
				}
			}
			else if(scheme_id.equals("pk"))
			{
				if(!student_photo.exists())
				{
					pre_data_filling_done = false;
				}
				else if(rs.getBinaryStream("high_school_marksheet")==null)
				{
					pre_data_filling_done = false;
				}
				else if(rs.getBinaryStream("higher_secondary_marksheet")==null)
				{
					pre_data_filling_done = false;
				}
				else if(rs.getBinaryStream("income_certificate")==null)
				{
					pre_data_filling_done = false;
				}
				else if(rs.getBinaryStream("bank_passbook")==null)
				{
					pre_data_filling_done = false;
				}
			}

			qry = "select * from application where applicant_id='"+applicant_id+"' and academic_year='"+academic_year_val+"'";
			ps = con.prepareStatement(qry);  
			rs = ps.executeQuery();
			if(rs.next())
			{
				application_already_registered = true;	
			}
			else
			{
				application_already_registered = false;	
			}
		}
		//If Database Connectivity Failed
		else
		{
			//Give Response to Client Return Error
			out.print("Database Connection Not Established");
		}	
	}
	catch(Exception e)
	{
		//Give Response to Client Return Error
		out.print("Problem While Finding Student Data : "+ e);
	}

	//Create Current Time Object in Milliseconds
	Date date = new Date();
    long timeMilli = date.getTime();
    //Store Current Time in String Object
    String timeMillisecond = String.valueOf(timeMilli);

    //Generate a random number
    String random = String.valueOf(Math.random());

    //Concate Time & Random Number String and Create Photo Cache Variable
    String photoCache = timeMillisecond + random;	
%>

<!--HTML 5 Document Starting-->
<!DOCTYPE html>
<html lang="en">
	<head>
		<!--Title of Webpage-->
		<title>Scholarship Application</title>
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
		<!--Date Picker CSS Linking-->
		<link rel="stylesheet" type="text/css" href="../css/daterangepicker.css">
		<!--User Defined CSS Linking-->
		<link rel="stylesheet" type="text/css" href="../css/common.css">
		<link rel="stylesheet" type="text/css" href="../css/main_application_profile.css">
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
		    	<ul class="nav navbar-nav navbar-left">
	    			<!--Home Page Link-->
	      			<li class="nav-item">
	        			<a class="nav-link" href="../index.jsp"><i class="fas fa-home"></i> Home</a>
	      			</li>
	      			<!--Student Dashboard Page Link-->
	      			<li class="nav-item">
	        			<a class="nav-link" href="sdashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
	      			</li>
		    	</ul>
		    	<ul class="nav navbar-nav ml-auto">
		    		<!--Logout Link-->
      				<li class="nav-item logout-link">
	        			<a class="nav-link" href="Student_Logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
	      			</li>
		    	</ul>
		  	</div>
		</nav>

		<!--Print Student Name & Applicant Id-->
		<div class="container-fluid mt-2 mb-2">
			<h5>Welcome, <strong><%=student_name%>(<%=applicant_id%>)</strong></h5>
			<hr>
		</div>

		<div class="container-fluid mb-4">
			<div class="row">
				<div class="col-md-2 mb-4">
					<ul class="nav border border-dark flex-column">
					  <li class="text-center">
					  	<!--If Student Photo Available-->
					    <%
					  		if(student_photo.exists())
					  		{
					  	%>
					  			<img class="img-fluid" src="../uploads/images/student_photos/<%=applicant_id%>.png?photoCache=<%=photoCache%>" alt="Photo" width="300" height="300">
					  	<%
					  		}
					  	//If Student Photo Not Available	
					  		else
					  		{
					  	%>
							    <img class="img-fluid" src="../static/images/avatar.gif" alt="Photo" width="300" height="300">
					    <%
					    	}
					    %>
					  </li>

					  <li class="nav-item border-bottom border-white">
					    <a class="nav-link" href="main_application_profile.jsp?scheme_id=<%=scheme_id%>">Home</a>
					  </li>

					  <li class="nav-item border-bottom border-white">
					    <a class="nav-link" href="main_application_upload_student_photo.jsp?scheme_id=<%=scheme_id%>">Upload Photo</a>
					  </li>

					  <li class="nav-item border-bottom border-white">
					    <a class="nav-link" href="main_application_update_voter_id.jsp?scheme_id=<%=scheme_id%>">Update Voter Id</a>
					  </li>

					  <%
					  	if(student_category.equals("Other Backward Class (OBC)")||student_category.equals("Scheduled Caste (SC)")||student_category.equals("Scheduled Tribe (ST)"))
					  	{
					  %>
						  <li class="nav-item border-bottom border-white">
						    <a class="nav-link" href="main_application_upload_caste_certificate.jsp?scheme_id=<%=scheme_id%>">Upload Caste Certificate</a>
						  </li>
					  <%
					  	}
					  %>

					  <%
					  	if(scheme_id.equals("mmjky"))
					  	{
					  %>
						  <li class="nav-item border-bottom border-white">
						    <a class="nav-link" href="main_application_upload_sambal_card.jsp?scheme_id=<%=scheme_id%>">Upload Sambal Card</a>
						  </li>
					  <%
				  	    }
					  %>

					  <li class="nav-item border-bottom border-white">
					    <a class="nav-link" href="main_application_upload_high_school.jsp?scheme_id=<%=scheme_id%>">Upload High School (10th Board Details)</a>
					  </li>

					  <%
					  	if(scheme_id.equals("mmvy")||scheme_id.equals("gkb")||scheme_id.equals("pk"))
					  	{
					  %>
						  <li class="nav-item border-bottom border-white">
						    <a class="nav-link" href="main_application_upload_higher_secondary.jsp?scheme_id=<%=scheme_id%>">Upload Higher Secondary (12th Board Details)</a>
						  </li>
					  <%
				  	    }
					  %>

					  <li class="nav-item border-bottom border-white">
					    <a class="nav-link" href="main_application_upload_ic_fr_lm.jsp?scheme_id=<%=scheme_id%>">Upload Income Certificate/Fees Receipt/Last Marksheet</a>
					  </li>

					  <li class="nav-item border-bottom border-white">
					    <a class="nav-link" href="main_application_edit_bank_account.jsp?scheme_id=<%=scheme_id%>">Edit Bank Account</a>
					  </li>

					  <li class="nav-item link-active border-bottom border-white">
					    <a class="nav-link" href="main_application_register.jsp?scheme_id=<%=scheme_id%>">Register Application for Scholarship</a>
					  </li>

					  <li class="nav-item">
					    <a class="nav-link" href="main_application_dashboard.jsp?scheme_id=<%=scheme_id%>">Application Dashboard</a>
					  </li>
					</ul>
				</div>

				<div class="col-md-10">
					<div class="card">
						<div class="card-header">
							Online Application For Scholarship
						</div>
						<%	
							if(!pre_data_filling_done)
							{
						%>
								<div class="card-body text-center">
							  		<div class="alert alert-warning">
										<h6>
											Dear <strong><%= student_name %></strong><br>
											Please Upload & Submit your Basic Details given above before filling Scholarship Application Form.
										</h6>
									</div>
								</div>
						<%
							}
							else if(!application_already_registered)
							{
						%>	
							<div class="card-body">
						  		<div class="alert alert-primary">
									<h6>
										Dear <strong><%= student_name %></strong><br>
										Welcome to Madhya Pradesh Scholarship Portal, Please enter all details and register your application. After successfull submission of the application, You can Lock the Application and then it's ready for further processing at Institute.
									</h6>
								</div>

								<hr>

								<table class="table table-bordered">
									<tr>
										<td colspan="4">
											<div class="alert alert-primary">
												<h6>
													Your Personal Details as per Registration
												</h6>
											</div>
										</td>
									</tr>
									<tr>
										<td>Your Name:</td>
										<td><b><%= student_name %></b></td>
										<td>Father's Name:</td>
										<td><b><%= student_father_name %></b></td>
									</tr>
									<tr>
										<td>Date of Birth:</td>
										<td><b><%= student_dob %></b></td>
										<td>Gender:</td>
										<td><b><%= student_gender %></b></td>
									</tr>
									<tr>
										<td>Category:</td>
										<td><b><%= student_category %></b></td>
										<td>Religion:</td>
										<td><b><%= student_religion %></b></td>
									</tr>
									<tr>
										<td>Aadhaar Number:</td>
										<td colspan="3"><b><%= student_aadhaar %></b></td>
									</tr>
									<tr>
										<td>Email Address:</td>
										<td colspan="3"><b><%= student_email %></b></td>
									</tr>
									<form action="Main_Application_Registration" method="post" onsubmit="return validateFormData()">
										<tr>
											<td colspan="4"><b>Scholarship Scheme & Academic Year</b></td>
										</tr>
										<tr>
											<td>Academic Year:</td>
											<td>
												<input class="form-control" type="text" id="academic_year" name="academic_year" placeholder="Academic Year" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off" readonly>
											</td>

											<script type="text/javascript">
												  var date_object = new Date();
												  var current_year = date_object.getFullYear();
												  var current_month = date_object.getMonth();
												  if(current_month<=5)
												  {
												  	var previous_year = (current_year-1).toString();
												  	var sliced_previous_year = previous_year.slice(2);
												  	var academic_year_val = previous_year + "-" +(parseInt(sliced_previous_year)+1).toString();
												  	document.getElementById('academic_year').value = academic_year_val;
												  }
												  else
												  {
												  	var sliced_current_year = current_year.toString().slice(2);
												  	var academic_year_val = current_year.toString() + "-" +(parseInt(sliced_current_year)+1).toString();
												  	document.getElementById('academic_year').value = academic_year_val;
												  }
											</script>

											<td>Scholarship Scheme:</td>
											<td>
												<input class="form-control" type="text" id="scholarship_scheme" name="scholarship_scheme" placeholder="Scholarship Year" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off" readonly>
											</td>

											<script type="text/javascript">
												var scheme_id = "<%= scheme_id %>";
												var scholarship_scheme = document.getElementById('scholarship_scheme');
												if(scheme_id=="pms")
													scholarship_scheme.value = "Post Metric Scholarship";
												else if(scheme_id=="mmvy")
													scholarship_scheme.value = "Mukhyamantri Medhavi Vidhyarthi Yojna";
												else if(scheme_id=="mmjky")
													scholarship_scheme.value = "Mukyamantri Jan Kalyan Yojna";
												else if(scheme_id=="gkb")
													scholarship_scheme.value = "Gaon Ki Beti";
												else if(scheme_id=="pk")
													scholarship_scheme.value = "Pratibha Kiran";
											</script>
										</tr>
										<tr>
											<td colspan="4">
												<div class="alert alert-primary">
													<h6>
														Enter Your College (Institute)'s College Code - <a href="find_institutes.jsp" target="_blank">Know Your College/Institute Code</a>
													</h6>
												</div>	
											</td>
										</tr>
										<tr>
											<td>
												Institute Code:
											</td>
											<td>
												<input class="form-control" type="text" id="institute_code" name="institute_code" placeholder="Institute Code" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off">
											</td>
											<td>
												Re-Type Institute Code:
											</td>
											<td>
												<input class="form-control" type="text" id="re_institute_code" name="re_institute_code" placeholder="Institute Code" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off" onkeyup="send_ins_data()">
											</td>
										</tr>
										<tr>
											<td colspan="4">
												<div id="institute_data_div" class="alert alert-primary" style="display: none;">
													<table>
														<tr>
															<td>Institute Name:</td>
															<td id="ins_name_fill"></td>
															<td>Institute Type:</td>
															<td id="ins_type_fill"></td>
														</tr>
														<tr>
															<td>Line Department:</td>
															<td id="ins_dep_fill"></td>
															<td>District:</td>
															<td id="ins_dis_fill"></td>
														</tr>
													</table>
												</div>
												<div id="institute_data_error_div" class="alert alert-danger text-center" style="display: none;">
													<h6 id="institute_data_error"></h6>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="4">
												<div class="alert alert-primary">
													<h6>
														Enter Your Course (Branch)'s Code - <a href="find_courses.jsp" target="_blank">Know Your Course/Branch Code</a>
													</h6>
												</div>	
											</td>
										</tr>
										<tr>
											<td>
												Course Code:
											</td>
											<td>
												<input class="form-control" type="text" id="course_code" name="course_code" placeholder="Course Code" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off">
											</td>
											<td>
												Re-Type Course Code:
											</td>
											<td>
												<input class="form-control" type="text" id="re_course_code" name="re_course_code" placeholder="Course Code" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off" onkeyup="send_cou_data()">
											</td>
										</tr>
										<tr>
											<td colspan="4">
												<div id="course_data_div" class="alert alert-primary" style="display: none;">
													<table>
														<tr>
															<td>Course:</td>
															<td id="cou_fill"></td>
															<td>Branch:</td>
															<td id="bra_fill"></td>
														</tr>
													</table>
												</div>
												<div id="course_data_error_div" class="alert alert-danger text-center" style="display: none;">
													<h6 id="course_data_error"></h6>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="4">
												<div class="alert alert-primary">
													<h6>
														Application Details
													</h6>
												</div>	
											</td>
										</tr>
										<tr>
											<td>
												Course Year:
											</td>
											<td>
												<select class="form-control" id="course_year" name="course_year" onchange="courseYearValidation();">
													<option value="">--Select Course Year--</option>
													<option value="First Year">First Year</option>
													<option value="Second Year">Second Year</option>
													<option value="Third Year">Third Year</option>
													<option value="Fourth Year">Fourth Year</option>
												</select>
											</td>
											<td>
												Admission Date for Academic Year:
											</td>
											<td>
												<input class="form-control" type="text" placeholder="DD/MM/YYYY" name="admission_date" id="admission_date" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off">
											</td>
										</tr>
										<tr>
											<td>
												Enrollment Date:
											</td>
											<td>
												<input class="form-control" type="text" placeholder="DD/MM/YYYY" name="enrollment_date" id="enrollment_date" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off">
											</td>
											<td>
												Enrollment/Roll No:
											</td>
											<td>
												<input class="form-control" type="text" id="enrollment_number" name="enrollment_number" placeholder="Enrollment/Roll No" onkeyup="return enrollmentNumberValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off">
											</td>
										</tr>
										<tr>
											<td>
												Disability Status:
											</td>
											<td>
												<select class="form-control" id="disability_status" name="disability_status" onchange="disabilityStatusValidation();">
													<option value="">--Select Disability Status--</option>
													<option value="No, I am not Disabled">No, I am not Disabled</option>
													<option value="Blind">Blind</option>
													<option value="Hearing Impairment">Hearing Impairment</option>
													<option value="Leprosy Cured">Leprosy Cured</option>
													<option value="Mentally Retardation">Mentally Retardation</option>
													<option value="Severely Handicapped">Severely Handicapped</option>
													<option value="Locomoter Disability">Locomoter Disability</option>
												</select>
											</td>
											<td colspan="2"></td>
										</tr>
										<tr>
											<td colspan="4">
												<div class="alert alert-primary">
													<h6>
														Details of Counselling for Admission
													</h6>
												</div>	
											</td>
										</tr>
										<tr>
											<td>
												Admission Type:
											</td>
											<td>
												<select class="form-control" id="admission_type" name="admission_type" onchange="admissionTypeValidation();">
													<option value="">--Select Admission Type--</option>
													<option value="Centralized Counselling">Centralized Counselling</option>
													<option value="College Level Counselling">College Level Counselling</option>
													<option value="Direct Admission">Direct Admission</option>
													<option value="Payment Seat">Payment Seat</option>
												</select>
											</td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td>
												Counselling Id:
											</td>
											<td>
												<input class="form-control" type="text" id="counselling_id" name="counselling_id" placeholder="Counselling Id" onkeyup="return counsellingIdValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off">
											</td>
											<td>
												Counselling Date:
											</td>
											<td>
												<input class="form-control" type="text" placeholder="DD/MM/YYYY" name="counselling_date" id="counselling_date" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off">
											</td>
										</tr>
										<tr>
											<td colspan="4">
												<div class="alert alert-primary">
													<h6>
														Your Last Exam Information
													</h6>
												</div>	
											</td>
										</tr>
										<tr>
											<td>
												Exam Name:
											</td>
											<td>
												<input class="form-control" type="text" id="exam_name" name="exam_name" placeholder="Exam Name" onkeyup="return examNameValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off">
											</td>
											<td>
												Exam Date:
											</td>
											<td>
												<input class="form-control" type="text" placeholder="DD/MM/YYYY" name="exam_date" id="exam_date" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off">
											</td>
										</tr>
										<tr>
											<td>
												School/Institute:
											</td>
											<td>
												<input class="form-control" type="text" id="school_institute" name="school_institute" placeholder="School/Institute" onkeyup="return schoolInstituteValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off">
											</td>
											<td>
												Total Marks:
											</td>
											<td>
												<input class="form-control" type="text" id="last_total_marks" name="last_total_marks" placeholder="Total Marks" onkeyup="return lastTotalMarksValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off">
											</td>
										</tr>
										<tr>
											<td>
												Obtained Marks:
											</td>
											<td>
												<input class="form-control" type="text" id="last_obtained_marks" name="last_obtained_marks" placeholder="Obtained Marks" onkeyup="return lastObtainedMarksValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off">
											</td>
											<td>
												Percentage:
											</td>
											<td>
												<input class="form-control" type="text" id="last_percentage" name="last_percentage" placeholder="Percentage" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off" readonly>
											</td>
										</tr>
										<tr>
											<td>
												Result:
											</td>
											<td>
												<input class="form-control" type="text" id="last_result" name="last_result" placeholder="Result" onkeyup="return lastResultValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off">
											</td>
											<td colspan="2">
												
											</td>
										</tr>
										<tr>
											<td colspan="4">
												<div class="alert alert-primary">
													<h6>
														Father/Mother Occupation Details
													</h6>
												</div>	
											</td>
										</tr>
										<tr>
											<td>
												Father Occupation:
											</td>
											<td>
												<select class="form-control" id="father_occupation" name="father_occupation" onchange="fatherOccupationValidation();">
													<option value="">--Select Father Occupation--</option>
													<option value="Central Govt. Service">Central Govt. Service</option>
													<option value="Central Govt. Public Sector">Central Govt. Public Sector</option>
													<option value="State Govt.">State Govt.</option>
													<option value="State Govt. Public Sector">State Govt. Public Sector</option>
													<option value="Private Service">Private Service</option>
													<option value="Own Business/Shop">Own Business/Shop</option>
													<option value="Farmer/Agriculture">Farmer/Agriculture</option>
													<option value="Construction Worker">Construction Worker</option>
													<option value="Father is no more">Father is No More</option>
												</select>
											</td>
											<td>
												Mother Occupation:
											</td>
											<td>
												<select class="form-control" id="mother_occupation" name="mother_occupation" onchange="motherOccupationValidation();">
													<option value="">--Select Mother Occupation--</option>
													<option value="Central Govt. Service">Central Govt. Service</option>
													<option value="Central Govt. Public Sector">Central Govt. Public Sector</option>
													<option value="State Govt.">State Govt.</option>
													<option value="State Govt. Public Sector">State Govt. Public Sector</option>
													<option value="Private Service">Private Service</option>
													<option value="Own Business/Shop">Own Business/Shop</option>
													<option value="Farmer/Agriculture">Farmer/Agriculture</option>
													<option value="Construction Worker">Construction Worker</option>
													<option value="House Wife">House Wife</option>
													<option value="Mother is No More">Mother is No More</option>
												</select>
											</td>
										</tr>
										<tr>
											<td>
												Annual Family Income:
											</td>
											<td>
												<input class="form-control" type="text" id="annual_family_income" name="annual_family_income" placeholder="Annual Family Income" onkeyup="return annualFamilyIncomeValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off">
											</td>
											<td colspan="2">
												
											</td>
										</tr>
										<tr>
											<td>
												Income Certificate Issued By:
											</td>
											<td>
												<input class="form-control" type="text" id="ic_issued_by" name="ic_issued_by" placeholder="Income Certificate Issued By" onkeyup="return icIssuedByValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off">
											</td>
											<td>
												Income Certificate Date:
											</td>
											<td>
												<input class="form-control" type="text" placeholder="DD/MM/YYYY" name="income_certificate_date" id="income_certificate_date" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off">
											</td>
										</tr>
										<tr>
											<td colspan="4"><b>Save All Above Details</b></td>
										</tr>
										<input type="hidden" name="scheme_id" value="<%=scheme_id%>">
										<tr>
											<td colspan="4" class="text-center">
												<input type="submit" class="btn btn-lg btn-success" value="Register/Update Application">
											</td>
										</tr>
									</form>
								</table>
							</div>
						<%	
							}
							else
							{
						%>
								<div class="card-body text-center">
							  		<div class="alert alert-warning">
										<h6>
											Dear <strong><%= student_name %></strong><br>
											Scholarship Application Form is already submitted for this Academic Year, Please Visit Application Dashboard.
										</h6>
									</div>
									<a class="btn btn-lg btn-primary mt-1 mb-1" href="main_application_dashboard.jsp?scheme_id=<%=scheme_id%>" role="button">Go To Application Dashboard</a>
								</div>
						<%
							}
						%>
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
		<script src="../js/main_application_register.js"></script>	
	</body>
</html>