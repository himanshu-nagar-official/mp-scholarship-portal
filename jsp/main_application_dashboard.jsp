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

	//Check if Applicant Id & Student Name are Available
	if(applicant_id==null||student_name==null)
	{ 
		//Redirect to Student Login Page
		response.sendRedirect("slogin.jsp");
		return; 
	}

	Boolean application_already_registered = true;

	//Get Web Application Path
	String applicationPath = request.getServletContext().getRealPath("");

	//Get Student Photo Path
	String photoPath = applicationPath+"/uploads/images/student_photos/"+applicant_id+".png";

	//Creating Student Photo File Object
	File student_photo = new File(photoPath);

	//Get Student Income Certificate Path
	String incomeCertificatePath = applicationPath+"/uploads/images/student_income_certificate/"+applicant_id+".png";

	//Creating Student Income Certificate File Object
	File student_income_certificate = new File(incomeCertificatePath);

	//Get Student Last Marksheet Path
	String lastMarksheetPath = applicationPath+"/uploads/images/student_last_marksheet/"+applicant_id+".png";

	//Creating Student Last Marksheet File Object
	File student_last_marksheet = new File(lastMarksheetPath);

	//Get Student Fees Receipt Path
	String feesReceiptPath = applicationPath+"/uploads/images/student_fees_receipt/"+applicant_id+".png";

	//Creating Student Fees Receipt File Object
	File student_fees_receipt = new File(feesReceiptPath);

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
	String payment = request.getParameter("payment");

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
			student_name = rs.getString("student_name");
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
		<!--jQuery Imports-->
		<script src="../js/jquery-3.5.1.js"></script>
		<!--Bootstrap JavaScript Imports-->
		<script src="../js/popper.min.js"></script>
		<script src="../js/bootstrap.min.js"></script>
		<!--Export PDF Template Images-->
		<script src="../js/pdfImages.js"></script>
		<script src="../js/jspdf.min.js"></script>
		<script src="../js/html2canvas.js"></script>
		<script src="../js/qrcode.js"></script>
		<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
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
					  			<img class="img-fluid" id="student_photo" src="../uploads/images/student_photos/<%=applicant_id%>.png?photoCache=<%=photoCache%>" alt="Photo" width="300" height="300">
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

					  <li class="nav-item border-bottom border-white">
					    <a class="nav-link" href="main_application_register.jsp?scheme_id=<%=scheme_id%>">Register Application for Scholarship</a>
					  </li>

					  <li class="nav-item link-active">
					    <a class="nav-link" href="main_application_dashboard.jsp?scheme_id=<%=scheme_id%>">Application Dashboard</a>
					  </li>
					</ul>
				</div>

				<!--If Any Message Show Modal-->
				<%
					if(request.getAttribute("message")!=null)
					{
				%>
						<!-- Modal -->
						<div id="message_modal" class="modal fade" role="dialog" data-backdrop="static" data-keyboard="false">
						  <div class="modal-dialog">

						    <!-- Modal content-->
						    <div class="modal-content">
						      <div class="modal-header alert alert-success">
						        <div class="modal-title text-center">Message : Scholarship Application Form</div>
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
							$("#message_modal").modal();
						</script>
				<%
					}
				%>

				<!--If Any Message Show Modal-->
				<%
					if(payment!=null)
					{
				%>
						<!-- Modal -->
						<div id="payment_modal" class="modal fade" role="dialog" data-backdrop="static" data-keyboard="false">
						  <div class="modal-dialog">

						    <!-- Modal content-->
						    <div class="modal-content">
						      <div class="modal-header alert alert-success">
						        <div class="modal-title text-center">Message : Scholarship Application Form Payment</div>
						        <button type="button" class="close" data-dismiss="modal">&times;</button>
						      </div>
						      <div class="modal-body">
						        <div class="alert alert-primary text center mt-2 mb-2">Success : <%=payment %></div>
						        <br>
						        Please Export Your Application in PDF Format & Take a Print Out & then submit it to your institute along with required documents for approval process.
						      </div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						      </div>
						    </div>

						  </div>
						</div>
						<script type="text/javascript">
							$("#payment_modal").modal();
						</script>
				<%
					}
				%>

				<div class="col-md-10">
					<div class="card">
						<!--Application Dashboard Heading With Student Name-->
						<div class="card-header">
							Application Dashboard
						</div>
						<div class="card-body">
								<%
									//Try to Establish Database Connectivity  
									try
									{  
										//Create Connection Object
										Connection con = null;

										int i = 1;

										//Try to open Database Connection
										con = DBConnection.getConnection();
										
										String qry = "select * from application where applicant_id='"+applicant_id+"'";
										PreparedStatement ps = con.prepareStatement(qry);  
										ResultSet rs = ps.executeQuery();
										
										if(!rs.next())
										{
											application_already_registered = false;	
										}
										else 
										{
											application_already_registered = true;	
										}
										if(application_already_registered==true)
										{
								%>
											<div class="table-responsive">
												<table class="table table-bordered">
													<tr>
														<th>S. No.</th>
														<th>Application Id</th>
														<th>Academic Year</th>
														<th>Institute Name</th>
														<th>Branch</th>
														<th>Course Year</th>
														<th>Scheme</th>
														<th>Application Status</th>
														<th>Action</th>
													</tr>
													<%
														do
														{
													%>
															<tr>
																<td>(<%= i %>.)</td>
																<td><%=rs.getString("application_id") %></td>
																<td><%=rs.getString("academic_year") %></td>
																<%
																	qry = "select ins_name from institutes where ins_code='"+rs.getString("institute_code")+"'";
																	ps = con.prepareStatement(qry);  
																	ResultSet is = ps.executeQuery();
																	is.next();
																%>
																<td><%=is.getString("ins_name") %></td>
																<%
																	qry = "select branch_name from courses where course_code='"+rs.getString("course_code")+"'";
																	ps = con.prepareStatement(qry);  
																	ResultSet cs = ps.executeQuery();
																	cs.next();
																%>
																<td><%=cs.getString("branch_name") %></td>
																<td><%=rs.getString("course_year") %></td>
																<td id='<%=rs.getString("application_id") %>_scholarship_scheme'><%=rs.getString("scholarship_scheme") %></td>
																<td><%=rs.getString("application_status") %></td>
																<td>
																	<%
																		if(rs.getString("application_status").equals("Submitted"))
																		{
																	%>
																	<button class="btn btn-sm btn-success" id='<%=rs.getString("application_id") %>' onclick="pay_now(this.id)">Pay Now</button><br><br>
																	<%
																		}
																	%>
																	<%
																		if(rs.getString("application_status").equals("Payment Done"))
																		{
																	%>
																	<button id='<%=rs.getString("application_id") %>' onclick="send_application_id_data(this.id)" class="btn btn-sm btn-info">Export PDF</button>
																	<%
																		}
																	%>
																</td>
															</tr>
															<% i++; %>
													<%
														}
														while(rs.next());
													%>
												</table>
											</div>
									<%
										}
										else
										{
									%>
											<div class="alert alert-warning text-center">
												<h4>
													No Application Available
												</h4>
											</div>
								<%
										}
									}
									catch(Exception e)
									{
										//Give Response to Client Return Error
										out.print("Problem While Finding Application Data : "+ e);
									}
								%>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!--Loading Data Division-->
		<div class="loading_modal" id="loading_modal"></div>

		<%
	  		if(student_photo.exists())
	  		{
	  	%>
	  			<img id="s_photo" src="../uploads/images/student_photos/<%=applicant_id%>.png?photoCache=<%=photoCache%>" alt="Photo" width="300" height="300" style="display: none;">
	  			<canvas id="photo" hidden="true" height="300" width="300"></canvas>
	  	<%
	  		}
	  	%>
		<%
	  		if(student_income_certificate.exists())
	  		{
	  	%>
	  			<img id="student_income_certificate" src="../uploads/images/student_income_certificate/<%=applicant_id%>.png?photoCache=<%=photoCache%>" alt="Income Certificate" height="1000" width="1000" style="display: none;">
	  			<canvas id="income_certificate" hidden="true" height="1000" width="1000"></canvas>
	  	<%
	  		}
	  	%>
	  	<%
	  		if(student_last_marksheet.exists())
	  		{
	  	%>
	  			<img id="student_last_marksheet" src="../uploads/images/student_last_marksheet/<%=applicant_id%>.png?photoCache=<%=photoCache%>" alt="Last Marksheet" width="1000" height="1000" style="display: none;">
	  			<canvas id="last_marksheet" hidden="true" height="1000" width="1000"></canvas>
	  	<%
	  		}
	  	%>
	  	<%
	  		if(student_fees_receipt.exists())
	  		{
	  	%>
	  			<img id="student_fees_receipt" src="../uploads/images/student_fees_receipt/<%=applicant_id%>.png?photoCache=<%=photoCache%>" alt="Fees Receipt" width="1000" height="1000" style="display: none;">
	  			<canvas id="fees_receipt" hidden="true" height="1000" width="1000"></canvas>
	  	<%
	  		}
	  	%>

		<div id="qrcode" hidden="true"></div>

		<script type="text/javascript">
			var qrData;
			var photoData;
			var incomeCertificateData;
			var lastMarksheetData;
			var feesReceiptData;
			window.onload = function()
			{
				var qrcode = new QRCode("qrcode", 
				{
				    text: "Madhya Pradesh Scholarship Portal : Applicant Id - "+"<%=applicant_id %>"+"Applicant Name : "+"<%=student_name %>",
				    width: 128,
				    height: 128,
				    colorDark : "#000000",
				    colorLight : "#ffffff",
				    correctLevel : QRCode.CorrectLevel.H,
					}); 
					qrcode._oDrawing._elImage.onload = ev => 
					{ 
					    qrData = ev.target.src;
				}
				var photo = document.getElementById("photo");
			  	var ctx = photo.getContext("2d");
			  	var img = document.getElementById("s_photo");
			  	ctx.drawImage(img, 0, 0, 300, 300);
			  	photoData = photo.toDataURL();
			  	var income_certificate = document.getElementById("income_certificate");
			  	ctx = income_certificate.getContext("2d");
			  	img = document.getElementById("student_income_certificate");
			  	ctx.drawImage(img, 0, 0, 1000, 1000);
			  	incomeCertificateData = income_certificate.toDataURL();
			  	var last_marksheet = document.getElementById("last_marksheet");
			  	ctx = last_marksheet.getContext("2d");
			  	img = document.getElementById("student_last_marksheet");
			  	ctx.drawImage(img, 0, 0, 1000, 1000);
			  	lastMarksheetData = last_marksheet.toDataURL();
			  	var fees_receipt = document.getElementById("fees_receipt");
			  	ctx = fees_receipt.getContext("2d");
			  	img = document.getElementById("student_fees_receipt");
			  	ctx.drawImage(img, 0, 0, 1000, 1000);
			  	feesReceiptData = fees_receipt.toDataURL();
			}
		</script>

		<script type="text/javascript">
			function pay_now(application_id)
			{
				var amt = 1;
				var scholarship_scheme = document.getElementById(application_id+"_scholarship_scheme").innerHTML;
				var options = {
				    "key": "rzp_test_1cuMe7RwmoJJWb",
				    "amount": amt*100,
				    "currency": "INR",
				    "name": "Madhya Pradesh Scholarship Portal",
				    "description": scholarship_scheme,
				    "image": "http://mediafire.com/convkey/7af5/qe6h1yzalhf5ltuzg.jpg",
				    "handler": function (response){
				        jQuery.ajax({
				        	type:'post',
				        	url:'payment_process.jsp',
				        	data:"payment_id="+response.razorpay_payment_id+"&amt="+amt+"&application_id="+application_id,
				        	success:function(result)
				        	{
				        		window.location.href="main_application_dashboard.jsp?scheme_id="+"<%=scheme_id %>&payment=Payment Successfull";
				        	}
				        });
			    	},
			    	"prefill": {
				        "name": "<%=student_name %>",
				        "email": "<%=student_email %>",
				        "contact": "<%=student_mobile %>"
				    },
			    	"theme": {
				        "color": "#ff7b00"
				    }
				};
				var rzp1 = new Razorpay(options);
				rzp1.open();
			}
		</script>

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
		<script src="../js/application.js"></script>	
	</body>
</html>