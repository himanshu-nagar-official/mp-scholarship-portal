<!--Page Encoding - Unicode-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--Page Imports-->
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.lang.Math"%>

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
	String student_mobile = "";
	String student_email = "";
	String student_aadhaar = "";
	String student_samagra = "";

	//Scheme Id Local Variable Declaration
	String scheme_id = request.getParameter("scheme_id");

	//Check if Applicant Id & Student Name are Available
	if(applicant_id==null||student_name==null)
	{ 
		//Redirect to Student Login Page
		response.sendRedirect("slogin.jsp");
		return; 
	}

	//Try to Establish Database Connectivity  
	try
	{  
		//Create Connection Type Object
		Connection con = null;

		//Create MySQL Database Connection Parameters Local Variables
		String url = "jdbc:mysql://localhost:3309/mp-scholarship-portal";
		String uid = "root";
		String pass = "poly";
		String driver = "com.mysql.jdbc.Driver";

		//Try to open Database Connection
		Class.forName(driver);
		con = DriverManager.getConnection(url,uid,pass);

		//If Connection is Successfully Established
		if(!con.isClosed())
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
			student_mobile = rs.getString("student_mobile");
			student_email = rs.getString("student_email");
			student_aadhaar = rs.getString("student_aadhaar");
			student_samagra = rs.getString("student_samagra");		
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
		<!--User Defined CSS Linking-->
		<link rel="stylesheet" type="text/css" href="../css/common.css">
		<link rel="stylesheet" type="text/css" href="../css/main_application_profile.css">
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

					  <li class="nav-item link-active border-bottom border-white">
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

					  <li class="nav-item border-bottom border-white">
					    <a class="nav-link" href="main_application_register.jsp?scheme_id=<%=scheme_id%>">Register Application for Scholarship</a>
					  </li>

					  <li class="nav-item">
					    <a class="nav-link" href="main_application_dashboard.jsp?scheme_id=<%=scheme_id%>">Application Dashboard</a>
					  </li>
					</ul>
				</div>

				<div class="col-md-10">
					<div class="card">
						<!--Profile Heading With Student Name-->
						<div class="card-header">
							Profile : <%=student_name%>
						</div>
						<div class="card-body">
							<!--Aadhaar Number Precautions-->
					  		<div class="alert alert-primary text-center blink_me">
								<h6>
									Please enter and verify Aadhaar Number with precautions. THE AADHAAR (TARGETED DELIVERY OF FINANCIAL AND OTHER SUBSIDIES, BENEFITS AND SERVICES) ACT, 2016 - Entering / using or verifying the wrong or someone else's Aadhaar number is an offense punishable as per Chapter 4 of Aadhaar Act, 2014. According to the Aadhaar Act, 2014, for such an offense, there is a provision of imprisonment for three years or punishable with ten thousand rupees. Incorrect or any other person's Aadhaar number is entered / used or verified, the application will be canceled without any information.
								</h6>
							</div>

							<!--Student Profile Data-->
							<div class="table-responsive">
								<table class="table table-bordered mb-0">
									<tbody>
										<tr>
											<td class="text-right w-25">Applicant ID :</td>
											<td class="text-left w-75" colspan="3"><%=applicant_id%></td>
										</tr>
										<tr>
											<td class="text-right w-25">Student Name :</td>
											<td class="text-left w-25"><%=student_name%></td>
											<td class="text-right w-25">Father Name :</td>
											<td class="text-left w-25"><%=student_father_name%></td>
										</tr>
										<tr>
											<td class="text-right w-25">Date of Birth :</td>
											<td class="text-left w-25"><%=student_dob%></td>
											<td class="text-right w-25">Gender :</td>
											<td class="text-left w-25"><%=student_gender%></td>
										</tr>
										<tr>
											<td class="text-right w-25">Category :</td>
											<td class="text-left w-25"><%=student_category%></td>
											<td class="text-right w-25">Religion :</td>
											<td class="text-left w-25"><%=student_religion%></td>
										</tr>
										<tr>
											<td class="text-right w-25">Mobile Number :</td>
											<td class="text-left w-25"><%=student_mobile%></td>
											<td class="text-right w-25">E-Mail Address :</td>
											<td class="text-left w-25"><%=student_email%></td>
										</tr>
										<tr>
											<td class="text-right w-25">Aadhaar Number :</td>
											<td class="text-left w-25" colspan="3"><%=student_aadhaar%></td>
										</tr>
									</tbody>
								</table>
							</div>

							<!--Student Samagra Id-->
							<div class="alert alert-primary text-center mt-0 mb-0">
								<h6>
									SAMAGRA Details
								</h6>
							</div>
							<table class="table table-bordered mb-0 mt-0">
								<tbody>
									<tr>
										<td class="text-right w-25">Samagra ID :</td>
										<td class="text-left w-75" colspan="3"><%=student_samagra%></td>
									</tr>
								</tbody>
							</table>
						</div>
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