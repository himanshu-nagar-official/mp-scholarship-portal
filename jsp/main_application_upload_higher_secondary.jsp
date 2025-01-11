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

	//Get Student Higher Secondary Marksheet Image Path
	String studentHigherSecondaryMarksheetPath = applicationPath+"/uploads/images/student_higher_secondary_marksheet/"+applicant_id+".png";

	//Creating Student Higher Secondary Marksheet Image File Object
	File student_higher_secondary_marksheet = new File(studentHigherSecondaryMarksheetPath);

	//Local Variables Declaration for Student Higher Secondary Details
	String higher_secondary_board = "";
	String higher_secondary_passing_year = "";
	String higher_secondary_roll_no = "";
	String higher_secondary_total_marks = "";
	String higher_secondary_obtained_marks = "";
	String higher_secondary_percentage = "";
	String higher_secondary_division = "";
	String student_category = "";

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
			student_category = rs.getString("student_category");
			higher_secondary_board = rs.getString("higher_secondary_board");
			higher_secondary_passing_year = rs.getString("higher_secondary_passing_year");
			higher_secondary_roll_no = rs.getString("higher_secondary_roll_no");
			higher_secondary_total_marks = rs.getString("higher_secondary_total_marks");
			higher_secondary_obtained_marks = rs.getString("higher_secondary_obtained_marks");
			higher_secondary_percentage = rs.getString("higher_secondary_percentage");
			higher_secondary_division = rs.getString("higher_secondary_division");
			if(higher_secondary_board==null)
				higher_secondary_board = "";
			if(higher_secondary_passing_year==null)
				higher_secondary_passing_year = "";
			if(higher_secondary_roll_no==null)
				higher_secondary_roll_no = "";
			if(higher_secondary_total_marks==null)
				higher_secondary_total_marks = "";
			if(higher_secondary_obtained_marks==null)
				higher_secondary_obtained_marks = "";
			if(higher_secondary_percentage==null)
				higher_secondary_percentage = "";
			if(higher_secondary_division==null)
				higher_secondary_division = "";
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
						  <li class="nav-item link-active border-bottom border-white">
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
						<div class="card-header">
							Upload Your 12th Board Marksheet Image in JPG/JPEG Or PNG format and Size should not be more than 100 KB
						</div>
						<div class="card-body text-center">
					  		<div class="alert alert-primary text-center">
								<h6>
									Instructions: You can upload a scan copy of your higher secondary marksheet from here, the format should be JPG/JPEG Or PNG and it should not be more than 100 KB.
								</h6>
							</div>

							<hr>

							<!--If Higher Secondary Details Stored Successfully Show Modal-->
							<%
								if(request.getAttribute("message")!=null)
								{
							%>
									<!-- Modal -->
									<div id="upload_higher_secondary_modal" class="modal fade" role="dialog" data-backdrop="static" data-keyboard="false">
									  <div class="modal-dialog">

									    <!-- Modal content-->
									    <div class="modal-content">
									      <div class="modal-header alert alert-success">
									        <div class="modal-title text-center">Message : Student Higher Secondary Marksheet Upload</div>
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
										$("#upload_higher_secondary_modal").modal();
									</script>
							<%
								}
							%>

                			<form method="post" onsubmit="return validateFormData()" action="Upload_Higher_Secondary" enctype="multipart/form-data">
                				<table class="table table-bordered">
                					<!--Higher Secondary Board Input Select Box-->
                					<tr>
                						<td class="text-right">
                							<label class="form-label" for="higher_secondary_board">Higher Secondary Board:</label>
                						</td>
                						<td class="text-left">
											<select class="form-control mb-3" id="higher_secondary_board" name="higher_secondary_board" onchange="higherSecondaryBoardValidation();">
												<option value="">--Select Higher Secondary Board--</option>
												<option value="Andhra Pradesh Board of Intermediate Education">Andhra Pradesh Board of Intermediate Education</option>
												<option value="Andhra Pradesh Board of Secondary Education">Andhra Pradesh Board of Secondary Education</option>
												<option value="Bihar School Examination Board">Bihar School Examination Board</option>
												<option value="Board of High School and Intermediate Education Uttar Pradesh">Board of High School and Intermediate Education Uttar Pradesh</option>
												<option value="Board of Secondary Education Rajasthan">Board of Secondary Education Rajasthan</option>
												<option value="Central Board of Secondary Education">Central Board of Secondary Education</option>
												<option value="Chhattisgarh Board of Secondary Education">Chhattisgarh Board of Secondary Education</option>
												<option value="Gujarat Secondary and Higher Secondary Education Board">Gujarat Secondary and Higher Secondary Education Board</option>
												<option value="Haryana Board of School Education">Haryana Board of School Education</option>
												<option value="Himachal Pradesh Board of School Education">Himachal Pradesh Board of School Education</option>
												<option value="Indian School Certificate">Indian School Certificate</option>
												<option value="Indian School Certificate Examinations">Indian School Certificate Examinations</option>
												<option value="Jammu and Kashmir State Board of School Education">Jammu and Kashmir State Board of School Education</option>
												<option value="Madhya Pradesh Board of Secondary Education">Madhya Pradesh Board of Secondary Education</option>
												<option value="Maharashtra State Board Of Secondary and Higher Secondary Education">Maharashtra State Board Of Secondary and Higher Secondary Education</option>
												<option value="National Institute of Open Schooling">National Institute of Open Schooling</option>
												<option value="Punjab School Education Board">Punjab School Education Board</option>
												<option value="West Bengal Board of Secondary Education">West Bengal Board of Secondary Education</option>
												<option value="West Bengal Council of Higher Secondary Education">West Bengal Council of Higher Secondary Education</option>
											</select>
                						</td>
                					</tr>

                					<%
	                					if(higher_secondary_board!="")
	                					{
	                				%>
		                					<script type="text/javascript">
		                						var higher_secondary_board_select = document.getElementById('higher_secondary_board');
		                						var higher_secondary_board = "<%= higher_secondary_board %>";
		                						for (i = 0; i< higher_secondary_board_select.options.length; i++)
												{ 
													if (higher_secondary_board_select.options[i].value==higher_secondary_board)
													{
														higher_secondary_board_select.options[i].selected = true;
													}
												}	
		                					</script>
	                				<%
	                					}
	                				%>

                					<tr>
                						<td colspan="2">
                							<p id="higher_secondary_board_check"></p>
                						</td>
                					</tr>

                					<!--Higher Secondary Passing Year Input Select Box-->
                					<tr>
                						<td class="text-right">
                							<label class="form-label" for="higher_secondary_passing_year">Higher Secondary Passing Year:</label>
                						</td>
                						<td class="text-left">
											<select class="form-control mb-3" id="higher_secondary_passing_year" name="higher_secondary_passing_year" onchange="higherSecondaryPassingYearValidation();">
												<option value="">--Select Passing Year--</option>
												<option value="1990">1990</option>
												<option value="1991">1991</option>
												<option value="1992">1992</option>
												<option value="1993">1993</option>
												<option value="1994">1994</option>
												<option value="1995">1995</option>
												<option value="1996">1996</option>
												<option value="1997">1997</option>
												<option value="1998">1998</option>
												<option value="1999">1999</option>
												<option value="2000">2000</option>
												<option value="2001">2001</option>
												<option value="2002">2002</option>
												<option value="2003">2003</option>
												<option value="2004">2004</option>
												<option value="2005">2005</option>
												<option value="2006">2006</option>
												<option value="2007">2007</option>
												<option value="2008">2008</option>
												<option value="2009">2009</option>
												<option value="2010">2010</option>
												<option value="2011">2011</option>
												<option value="2012">2012</option>
												<option value="2013">2013</option>
												<option value="2014">2014</option>
												<option value="2015">2015</option>
												<option value="2016">2016</option>
												<option value="2017">2017</option>
												<option value="2018">2018</option>
												<option value="2019">2019</option>
												<option value="2020">2020</option>
												<option value="2021">2021</option>
											</select>
                						</td>
                					</tr>

                					<%
	                					if(higher_secondary_passing_year!="")
	                					{
	                				%>
		                					<script type="text/javascript">
		                						var higher_secondary_passing_year_select = document.getElementById('higher_secondary_passing_year');
		                						var higher_secondary_passing_year = "<%= higher_secondary_passing_year %>";
		                						for (i = 0; i< higher_secondary_passing_year_select.options.length; i++)
												{ 
													if (higher_secondary_passing_year_select.options[i].value==higher_secondary_passing_year)
													{
														higher_secondary_passing_year_select.options[i].selected = true;
													}
												}	
		                					</script>
	                				<%
	                					}
	                				%>

                					<tr>
                						<td colspan="2">
                							<p id="higher_secondary_passing_year_check"></p>
                						</td>
                					</tr>

                					<!--Higher Secondary Roll No Input Text Box-->
                					<tr>
                						<td class="text-right">
                							<label class="form-label" for="higher_secondary_roll_no">Higher Secondary Roll Number:</label>
                						</td>
                						<td class="text-left">
                							<input class="form-control mb-3" type="text" id="higher_secondary_roll_no" name="higher_secondary_roll_no" placeholder="Higher Secondary Roll Number" onkeyup="return higherSecondaryRollNoValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off" value="<%= higher_secondary_roll_no %>">
                						</td>
                					</tr>

                					<tr>
                						<td colspan="2">
                							<p id="higher_secondary_roll_no_check"></p>
                						</td>
                					</tr>

                					<!--Higher Secondary Total Marks Input Text Box-->
                					<tr>
                						<td class="text-right">
                							<label class="form-label" for="higher_secondary_total_marks">Higher Secondary Total Marks:</label>
                						</td>
                						<td class="text-left">
                							<input class="form-control mb-3" type="text" id="higher_secondary_total_marks" name="higher_secondary_total_marks" placeholder="Higher Secondary Total Marks" onkeyup="return higherSecondaryTotalMarksValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off" value="<%= higher_secondary_total_marks %>" maxlength="3">
                						</td>
                					</tr>

                					<tr>
                						<td colspan="2">
                							<p id="higher_secondary_total_marks_check"></p>
                						</td>
                					</tr>

                					<!--Higher Secondary Obtained Marks Input Text Box-->
                					<tr>
                						<td class="text-right">
                							<label class="form-label" for="higher_secondary_obtained_marks">Higher Secondary Obtained Marks:</label>
                						</td>
                						<td class="text-left">
                							<input class="form-control mb-3" type="text" id="higher_secondary_obtained_marks" name="higher_secondary_obtained_marks" placeholder="Higher Secondary Obtained Marks" onkeyup="return higherSecondaryObtainedMarksValidation();" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off" value="<%= higher_secondary_obtained_marks %>" maxlength="3">
                						</td>
                					</tr>

                					<tr>
                						<td colspan="2">
                							<p id="higher_secondary_obtained_marks_check"></p>
                						</td>
                					</tr>

                					<!--Higher Secondary Percentage Input Text Box-->
                					<tr>
                						<td class="text-right">
                							<label class="form-label" for="higher_secondary_percentage">Higher Secondary Percentage:</label>
                						</td>
                						<td class="text-left">
                							<input class="form-control mb-3" type="text" id="higher_secondary_percentage" name="higher_secondary_percentage" placeholder="Higher Secondary Percentage" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off" value="<%= higher_secondary_percentage %>" readonly>
                						</td>
                					</tr>

                					<tr>
                						<td colspan="2">
                							<p id="higher_secondary_percentage_check"></p>
                						</td>
                					</tr>

                					<!--Higher Secondary Division Input Text Box-->
                					<tr>
                						<td class="text-right">
                							<label class="form-label" for="higher_secondary_division">Higher Secondary Division:</label>
                						</td>
                						<td class="text-left">
                							<input class="form-control mb-3" type="text" id="higher_secondary_division" name="higher_secondary_division" placeholder="Higher Secondary Division" oncopy="return false" onpaste="return false" oncut="return false" ondrop="return false" autocomplete="off" value="<%= higher_secondary_division %>" readonly>
                						</td>
                					</tr>

                					<tr>
                						<td colspan="2">
                							<p id="higher_secondary_division_check"></p>
                						</td>
                					</tr>

                					<tr>
                						<td class="text-right">
                							<label class="form-label" for="photo">Upload Higher Secondary (12th Board) Marksheet:</label>
                						</td>
                						<td class="text-left">
											<input onchange="higherSecondaryMarksheetValidation()" id="photo" type="file" name="higher_secondary_marksheet" accept="image/*"><br>
                						</td>
                					</tr>

                					<tr>
                						<td colspan="2">
                							<p id="photo_message"></p>
                						</td>
                					</tr>
                				</table>

	                        	<input type="hidden" id="scheme_id" name="scheme_id" value="<%=scheme_id%>">

	                        	<input class="btn btn-success mt-2" type="submit" name="upload_higher_secondary" value="Register My 12th Board Examination Details">
                        	</form>

                        	<%
						  		if(student_higher_secondary_marksheet.exists())
						  		{
						  	%>
	                        	<img class="img-fluid mt-3 border" src="../uploads/images/student_higher_secondary_marksheet/<%=applicant_id%>.png?photoCache=<%=photoCache%>" alt="Photo" width="200" height="250"><br>
	                        	<button class="btn btn-info mt-4" onclick="openHigherSecondaryMarksheet()">View Higher Secondary Marksheet</button>

	                        	<!-- Modal -->
								<div id="higher_secondary_marksheet_open" class="modal fade" role="dialog" data-backdrop="static" data-keyboard="false">
								  <div class="modal-dialog">

								    <!-- Modal content-->
								    <div class="modal-content">
								      <div class="modal-header">
								        <div class="modal-title text-center">Higher Secondary Marksheet</div>
								        <button type="button" class="close" data-dismiss="modal">&times;</button>
								      </div>
								      <div class="modal-body">
								        <img class="img-fluid mt-3" src="../uploads/images/student_higher_secondary_marksheet/<%=applicant_id%>.png?photoCache=<%=photoCache%>" alt="Photo" width="1000" height="1000">
								      </div>
								      <div class="modal-footer">
								        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
								      </div>
								    </div>

								  </div>
								</div>
								<script type="text/javascript">
									function openHigherSecondaryMarksheet()
									{
										$("#higher_secondary_marksheet_open").modal();
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
		<script src="../js/main_application_upload_higher_secondary.js"></script>	
	</body>
</html>