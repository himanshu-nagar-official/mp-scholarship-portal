<!--Page Encoding - Unicode-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--Page Imports-->
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.Math"%>

<!--Check if Institute Logged in or not-->
<%
	String ins_code =(String)session.getAttribute("ins_code");
	String ins_name =(String)session.getAttribute("ins_name");
	if(ins_code==null && ins_name==null)
	{ 
		response.sendRedirect("ilogin.jsp");
		return; 
	}
%>

<!--HTML 5 Document Starting-->
<!DOCTYPE html>
<html lang="en">
	<head>
		<!--Title of Webpage-->
		<title>Institute Dashboard</title>
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
		<script src="../js/jquery-3.5.1.slim.js"></script>
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
		    	<ul class="nav navbar-nav navbar-left">
	    			<!--Home Page Link-->
	      			<li class="nav-item">
	        			<a class="nav-link" href="../index.jsp"><i class="fas fa-home"></i> Home</a>
	      			</li>
	      			<!--Institute Dashboard Page Link-->
	      			<li class="nav-item link-active">
	        			<a class="nav-link" href="idashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
	      			</li>
		    	</ul>
		    	<ul class="nav navbar-nav ml-auto">
		    		<!--Logout-->
      				<li class="nav-item logout-link">
	        			<a class="nav-link" href="Institute_Logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
	      			</li>
		    	</ul>
		  	</div>
		</nav>

		<div class="container-fluid mt-2 mb-2">
			<h5>Welcome, <strong><%=ins_name%>(<%=ins_code%>)</strong></h5>
			<hr>
		</div>

		<!--If Action Successfull Show Modal-->
		<%
			if(request.getAttribute("message")!=null)
			{
		%>
				<!-- Modal -->
				<div id="action_success_modal" class="modal fade" role="dialog" data-backdrop="static" data-keyboard="false">
				  <div class="modal-dialog">

				    <!-- Modal content-->
				    <div class="modal-content">
				      <div class="modal-header alert alert-success">
				        <div class="modal-title text-center">Message</div>
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
					$("#action_success_modal").modal();
				</script>
		<%
			}
		%>

		<!--Find Application Heading & Instructions-->
		<div class="container mt-4 mb-0">
			<div class="alert alert-primary text-center mb-0">
				<h3>Application Approval Corner</h3>
				<h4>Help: Institute can Approve or Reject Application on it's Eligibility Basis.</h4>
			</div>
		</div>
		<!--Find Application Form-->
		<div class="container mt-0">
			<form name="application_data" class="border pr-2 pl-2 mb-2">
				<div class="row">
					<!--Application Scheme Select Box-->
					<div class="col-md-6">
						Application Scheme:
						<select class="form-control mb-2" name="app_scheme">
							<option value="">-- Select Application Scheme --</option>
							<option value="Post Metric Scholarship">Post Metric Scholarship</option>
							<option value="Mukhyamantri Medhavi Vidhyarthi Yojna">Mukhyamantri Medhavi Vidhyarthi Yojna</option>
							<option value="Mukyamantri Jan Kalyan Yojna">Mukyamantri Jan Kalyan Yojna</option>
							<option value="Gaon Ki Beti">Gaon Ki Beti</option>
							<option value="Pratibha Kiran">Pratibha Kiran</option>
						</select>
					</div>
					<%
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
								String qry = "select * from institutes_courses_mapping where institute_code_map='"+ins_code+"'";
								//Execute Select Query & Get Results
								PreparedStatement ps = con.prepareStatement(qry);  
								ResultSet map_rs = ps.executeQuery();
								map_rs.next();
								
					%>
								<!--Course & Branch Select Box-->
								<div class="col-md-6">
									Application Course & Branch:
									<select class="form-control mb-2" name="cou_bra">
										<option value="">-- Select Application Course & Branch --</option>
					<%
								do
								{
									//Create SQL Query Local Variable
									qry = "select * from courses where course_code='"+map_rs.getString("course_code_map")+"'";
									//Execute Select Query & Get Results
									ps = con.prepareStatement(qry);  
									ResultSet cou_rs = ps.executeQuery();
									cou_rs.next();
									String course_code = cou_rs.getString("course_code");
									String cou_bra = cou_rs.getString("course_name") + " - " + cou_rs.getString("branch_name");
					%>
										<option value="<%=course_code %>"><%=cou_bra %></option>
					<%
								}while(map_rs.next());
					%>
									</select>
								</div>
					<%
								
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
					%>
				</div>
				<div class="row">
					<!--Application Status Select Box-->
					<div class="col-md-6">
						Application Status:
						<select class="form-control mb-2" name="app_status">
							<option value="">-- Select Application Status --</option>
							<option value="Payment Done">Approval Pending</option>
							<option value="Approved">Approved By Institute</option>
							<option value="Rejected">Rejected By Institute</option>
						</select>
					</div>
				</div>

				<input type="hidden" name="ins_code" id="ins_code" value="<%=ins_code %>"> 
			</form>
		</div>

		<div class="container text-center mb-4">
			<!--Send Application Data Button-->
			<button id="show_application_btn" class="btn btn-primary" onclick="send_application_data()">
				<span id="loading_spinner" class=""></span>
				Show Application(s)
			</button>
			<!--Error Division-->
			<div id="error" class=""></div>
		</div>

		<!--Application Received Data Table-->
		<div class="container-fluid pr-4 pl-4 mb-4">
			<div class="table-responsive">
				<table id="application_table" class="table table-bordered table-striped nowrap" style="width: 100%"></table>
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
		<script src="../js/idashboard.js"></script>
	</body>
</html>