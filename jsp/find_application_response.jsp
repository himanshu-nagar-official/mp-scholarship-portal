<% //Page Imports SQL & JSON %>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.*"%>  
  
<%  
	//Get Request Parameters into Local Variables
	String scholarship_scheme = request.getParameter("app_scheme");	//Application Scheme
	String course_code = request.getParameter("cou_bra");	//Application Course
	String application_status = request.getParameter("app_status");	//Application Status
	String institute_code = request.getParameter("ins_code");	//Institute Code
	  
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
			String qry = "select * from application where scholarship_scheme='"+scholarship_scheme+"' and institute_code='"+institute_code+"' and course_code='"+course_code+"' and application_status='"+application_status+"'";
			//Execute Select Query & Get Results
			PreparedStatement ps = con.prepareStatement(qry);  
			ResultSet rs = ps.executeQuery();

			//If No Data Available in Result Set
			if(!rs.next())
			{
				//Give Response to Client Return Error
				out.print("No Application Found");  
			}
			//If Data Available in Result Set
			else
			{
				//Create New JSON Array
				JSONArray applications_array = new JSONArray();
				//Iterate through all the rows
				do
				{
					qry = "select * from students where applicant_id="+rs.getString("applicant_id");
					ps = con.prepareStatement(qry);
					ResultSet stu_rs = ps.executeQuery();
					stu_rs.next();
					//Create JSON Object & Put Data into it
	                JSONObject application_array = new JSONObject();
	                application_array.put("application_id",rs.getString("application_id"));
	                application_array.put("applicant_id",rs.getString("applicant_id"));
	                application_array.put("academic_year",rs.getString("academic_year"));
	                application_array.put("student_name",stu_rs.getString("student_name"));
	                application_array.put("student_dob",stu_rs.getString("student_dob"));
	                application_array.put("student_aadhaar",stu_rs.getString("student_aadhaar"));
	                //Append JSON Object of Single Row in JSON Array
	                applications_array.put(application_array);
	            }while(rs.next());
	            //Give Response to Client Return JSON Array
	            out.print(applications_array);	
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
		out.print("Problem While Finding Institute : "+ e);
	}   
%>