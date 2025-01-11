<!--Page Encoding - Unicode-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--Page Imports-->
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.lang.Math"%>

<%
	String payment_id = request.getParameter("payment_id");
	String amt = request.getParameter("amt");
	String application_id = request.getParameter("application_id");

	if((payment_id!=null)&&(application_id!=null)&&(amt!=null))
	{
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
				String qry = "update application SET application_status='"+"Payment Done"+"' where application_id='"+application_id+"'";
				//Execute Select Query & Get Results
				PreparedStatement ps = con.prepareStatement(qry);  
				int i = ps.executeUpdate();
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
	}
%>