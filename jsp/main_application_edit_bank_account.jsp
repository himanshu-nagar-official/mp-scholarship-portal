<!--Page Encoding - Unicode-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--Page Imports-->
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.Date"%>
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

	if(applicant_id==null||student_name==null)
	{ 
		//Redirect to Student Login Page
		response.sendRedirect("slogin.jsp");
		return; 
	}

	//Scheme Id Local Variable Declaration
	String scheme_id = request.getParameter("scheme_id");

	//Get Web Application Path
	String applicationPath = request.getServletContext().getRealPath("");

	//Get Student Photo Path
	String photoPath = applicationPath+"/uploads/images/student_photos/"+applicant_id+".png";

	//Creating Student Photo File Object
	File student_photo = new File(photoPath);

	//Get Student Bank Passbook Image Path
	String studentBankPassbookPath = applicationPath+"/uploads/images/student_bank_passbook/"+applicant_id+".png";

	//Creating Student Bank Passbook Image File Object
	File student_bank_passbook = new File(studentBankPassbookPath);

	//Local Variables Declaration for Student High School Details
	String bank_name = "";
	String branch = "";
	String ifsc_code = "";
	String account_number = "";
	String student_category = "";

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
			student_category = rs.getString("student_category");
			bank_name = rs.getString("bank_name");
			branch = rs.getString("branch");
			ifsc_code = rs.getString("ifsc_code");
			account_number = rs.getString("account_number");
			if(bank_name==null)
				bank_name = "";
			if(branch==null)
				branch = "";
			if(ifsc_code==null)
				ifsc_code = "";
			if(account_number==null)
				account_number = "";
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

					  <li class="nav-item link-active border-bottom border-white">
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
						<div class="card-header">
							Bank Account Details
						</div>
						<div class="card-body text-center">
					  		<div class="alert alert-primary text-center">
								<h6>
									Instructions: Please Enter Bank Account Details and upload a scan copy of your bank passbook from here, the format should be JPG/JPEG Or PNG and it should not be more than 100 KB.
								</h6>
							</div>

							<hr>

							<!--If Bank Account Details Stored Successfully Show Modal-->
							<%
								if(request.getAttribute("message")!=null)
								{
							%>
									<!-- Modal -->
									<div id="bank_account_details_modal" class="modal fade" role="dialog" data-backdrop="static" data-keyboard="false">
									  <div class="modal-dialog">

									    <!-- Modal content-->
									    <div class="modal-content">
									      <div class="modal-header alert alert-success">
									        <div class="modal-title text-center">Message : Bank Account Details</div>
									        <button type="button" class="close" data-dismiss="modal">&times;</button>
									      </div>
									      <div class="modal-body">
									        <div class="alert alert-primary text center mt-2 mb-2">Success : ${requestScope.message}</div>
									      </div>
									      <div class="modal-footer">
									        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									      </div>
									    </div>

									  </div>
									</div>
									<script type="text/javascript">
										$("#bank_account_details_modal").modal();
									</script>
							<%
								}
							%>

                			<form method="post" onsubmit="return validateFormData()" action="Upload_Edit_Bank_Account" enctype="multipart/form-data">
                				<table class="table table-bordered">
                					<!--Bank Name Input Text Box-->
                					<tr>
                						<td class="text-right">
                							<label class="form-label" for="bank_name">Bank Name:</label>
                						</td>
                						<td class="text-left">
											<input class="form-control mb-3" type="text" id="bank_name" name="bank_name" placeholder="Bank Name" onkeyup="return bankNameValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off" value="<%= bank_name %>">
                						</td>
                					</tr>

                					<tr>
                						<td colspan="2">
                							<p id="bank_name_check"></p>
                						</td>
                					</tr>

                					<!--Branch Input Text Box-->
                					<tr>
                						<td class="text-right">
                							<label class="form-label" for="branch">Branch:</label>
                						</td>
                						<td class="text-left">
											<input class="form-control mb-3" type="text" id="branch" name="branch" placeholder="Branch" onkeyup="return branchValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off" value="<%= branch %>">
                						</td>
                					</tr>

                					<tr>
                						<td colspan="2">
                							<p id="branch_check"></p>
                						</td>
                					</tr>

                					<!--IFSC Code Input Text Box-->
                					<tr>
                						<td class="text-right">
                							<label class="form-label" for="ifsc_code">IFSC Code:</label>
                						</td>
                						<td class="text-left">
											<input class="form-control mb-3" type="text" id="ifsc_code" name="ifsc_code" placeholder="IFSC Code" onkeyup="return ifscCodeValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off" value="<%= ifsc_code %>">
                						</td>
                					</tr>

                					<tr>
                						<td colspan="2">
                							<p id="ifsc_code_check"></p>
                						</td>
                					</tr>

                					<!--Account Number Input Text Box-->
                					<tr>
                						<td class="text-right">
                							<label class="form-label" for="account_number">Account Number:</label>
                						</td>
                						<td class="text-left">
											<input class="form-control mb-3" type="text" id="account_number" name="account_number" placeholder="Account Number" onkeyup="return accountNumberValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off" value="<%= account_number %>">
                						</td>
                					</tr>

                					<tr>
                						<td colspan="2">
                							<p id="account_number_check"></p>
                						</td>
                					</tr>

                					<tr>
                						<td class="text-right">
                							<label class="form-label" for="photo">Upload Bank Account Passbook:</label>
                						</td>
                						<td class="text-left">
											<input onchange="studentBankPassbookValidation()" id="photo" type="file" name="bank_passbook" accept="image/*"><br>
                						</td>
                					</tr>

                					<tr>
                						<td colspan="2">
                							<p id="photo_message"></p>
                						</td>
                					</tr>
                				</table>

	                        	<input type="hidden" name="scheme_id" value="<%=scheme_id%>">

	                        	<input class="btn btn-success mt-2" type="submit" name="upload_bank_account_details" value="Save My Bank Account Details">
                        	</form>

                        	<%
						  		if(student_bank_passbook.exists())
						  		{
						  	%>
	                        	<img class="img-fluid mt-3 border" src="../uploads/images/student_bank_passbook/<%=applicant_id%>.png?photoCache=<%=photoCache%>" alt="Photo" width="200" height="250"><br>
	                        	<button class="btn btn-info mt-4" onclick="openStudentBankPassbook()">View Bank Passbook</button>

	                        	<!-- Modal -->
								<div id="student_bank_passbook_open" class="modal fade" role="dialog" data-backdrop="static" data-keyboard="false">
								  <div class="modal-dialog">

								    <!-- Modal content-->
								    <div class="modal-content">
								      <div class="modal-header">
								        <div class="modal-title text-center">Bank Passbook</div>
								        <button type="button" class="close" data-dismiss="modal">&times;</button>
								      </div>
								      <div class="modal-body">
								        <img class="img-fluid mt-3" src="../uploads/images/student_bank_passbook/<%=applicant_id%>.png?photoCache=<%=photoCache%>" alt="Photo" width="1000" height="1000">
								      </div>
								      <div class="modal-footer">
								        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
								      </div>
								    </div>

								  </div>
								</div>
								<script type="text/javascript">
									function openStudentBankPassbook()
									{
										$("#student_bank_passbook_open").modal();
									}
								</script>
                        	<%
						  		}
						  	%>
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
		<script src="../js/main_application_edit_bank_account.js"></script>	
	</body>
</html>