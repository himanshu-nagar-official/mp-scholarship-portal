<% //Page Imports SQL & JSON %>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.*"%>  
  
<%  
	//Get Request Parameters into Local Variables
	String ins_code = request.getParameter("ins_code");	//Institute Department
	  
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
			ResultSet rs = ps.executeQuery();

			//If No Data Available in Result Set
			if(!rs.next())
			{
				//Give Response to Client Return Error
				out.print("No Active Courses");  
			}
			//If Data Available in Result Set
			else
			{
				//Create New JSON Array
				JSONArray courses_array = new JSONArray();
				String course_code_map = "";
				//Iterate through all the rows
				do
				{
					//Create JSON Object & Put Data into it
	                JSONObject course_array = new JSONObject();

	                course_code_map = rs.getString("course_code_map");
	                //Create SQL Query Local Variable
	                String cou_qry = "select * from courses where course_code='"+course_code_map+"'";
	                //Execute Select Query & Get Results
					PreparedStatement cou_ps = con.prepareStatement(cou_qry);  
					ResultSet cou_rs = cou_ps.executeQuery();
					if(!cou_rs.next())
					{
						//do nothing
					}
					else
					{
		                course_array.put("course_code",cou_rs.getString("course_code"));
		                course_array.put("course_name",cou_rs.getString("course_name"));
		                course_array.put("branch_name",cou_rs.getString("branch_name"));
		                course_array.put("course_duration",cou_rs.getString("course_duration"));
		                //Append JSON Object of Single Row in JSON Array
		                courses_array.put(course_array);
	                }
	            }while(rs.next());
	            //Give Response to Client Return JSON Array
	            out.print(courses_array);	
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
		out.print("Problem While Finding Courses : "+ e);
	}   
%>