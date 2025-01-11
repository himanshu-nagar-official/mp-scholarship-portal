<% //Page Imports SQL & JSON %>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.*"%>

<%  
	//Get Request Parameters into Local Variables
	String student_name = request.getParameter("student_name");			//Student Name
	String student_gender = request.getParameter("student_gender");		//Student Gender
	String student_email = request.getParameter("student_email");		//Student Email
	String student_aadhaar = request.getParameter("student_aadhaar");	//Student Aadhaar Number

	//Create Boolean Type Local Variables to check if data available in parameters or null
	Boolean student_email_available = true;
	Boolean student_aadhaar_available = true;

	if(student_email.trim().equals("")||student_email==null)
	{
		student_email_available = false;
	}
	else if(student_aadhaar.trim().equals("")||student_aadhaar==null)
	{
		student_aadhaar_available = false;
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
			String qry = "";

			if(student_aadhaar_available)
			{
				qry = "select * from students where student_name='"+student_name+"' and student_gender='"+student_gender+"' and student_aadhaar='"+student_aadhaar+"'";
			}
			else if(student_email_available)
			{
				qry = "select * from students where student_name='"+student_name+"' and student_gender='"+student_gender+"' and student_email='"+student_email+"'";
			}

			//Execute Select Query & Get Results
			PreparedStatement ps = con.prepareStatement(qry);  
			ResultSet rs = ps.executeQuery();

			//If No Data Available in Result Set
			if(!rs.next())
			{
				//Give Response to Client Return Error
				out.print("Sorry we couldn't find your record");  
			}
			//If Data Available in Result Set
			else
			{
				//Create New JSON Array
				JSONArray student_record_array = new JSONArray();
				//Create JSON Object & Put Data into it
                JSONObject student_object = new JSONObject();
                student_object.put("applicant_id",rs.getString("applicant_id"));
                student_object.put("student_name",rs.getString("student_name"));
                student_object.put("student_father_name",rs.getString("student_father_name"));
                student_object.put("student_dob",rs.getString("student_dob"));
                student_object.put("student_category",rs.getString("student_category"));
                student_object.put("student_state",rs.getString("student_state"));
                student_object.put("student_district",rs.getString("student_district"));
                student_object.put("student_pincode",rs.getString("student_pincode"));
                student_object.put("student_address",rs.getString("student_address"));
                //Append JSON Object of Single Row in JSON Array
                student_record_array.put(student_object);
                //Give Response to Client Return JSON Array
	            out.print(student_record_array);
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
		out.print("Problem While Searching Student Data : "+ e);
	}
%>