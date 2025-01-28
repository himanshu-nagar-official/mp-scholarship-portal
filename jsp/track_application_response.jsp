<% //Page Imports SQL & JSON %>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.*"%>
<%@ page import="com.utils.db.DBConnection" %>
  
<%  
	//Get Request Parameters into Local Variables
	String application_id = request.getParameter("application_id");	//Application Id

	//Create Boolean Type Local Variables to check if data available in parameters or null
	boolean application_id_available = true;	//Application Id

	//Check which data is available or null
	if(application_id==null || application_id.trim().equals(""))	//For Application Id
	{  
		application_id_available = false;
		//Give Response to Client Return Error
		out.print("Please Enter Application Id");
	}
	  
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
			String qry = "";

			//If Application Id Available
			if(application_id_available)
			{
				qry = "select * from application where application_id="+application_id;
			}			

			//Execute Select Query & Get Results
			PreparedStatement ps = con.prepareStatement(qry);  
			ResultSet rs = ps.executeQuery();

			//If No Data Available in Result Set
			if(!rs.next())
			{
				//Give Response to Client Return Error
				out.print("Application Not Found");  
			}
			//If Data Available in Result Set
			else
			{
				String application_status = rs.getString("application_status");
				if(application_status.equals("Submitted"))
				{
					out.println("Application Status - Scholarship Application is Submitted by Applicant");
				}
				else if(application_status.equals("Payment Done"))
				{
					out.println("Application Status - Scholarship Application Payment is done successfully by Applicant");
				}
				else if(application_status.equals("Approved"))
				{
					out.println("Application Status - Scholarship Application is Approved by Institute");
				}
				else if(application_status.equals("Rejected"))
				{
					out.println("Application Status - Scholarship Application is Rejected by Institute");
				}	
			}
			//Close Database Connection
			con.close();
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
		out.print("Problem While Checking Application Status : "+ e);
	}   
%>