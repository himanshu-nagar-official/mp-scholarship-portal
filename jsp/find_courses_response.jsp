<% //Page Imports SQL & JSON %>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.*"%>  
  
<%  
	//Get Request Parameters into Local Variables
	String line_department = request.getParameter("line_department");	//Line Department
	String course_type = request.getParameter("course_type");			//Course Type

	//Create Boolean Type Local Variables to check if data available in parameters or null
	boolean line_department_available = true;	//Line Department
	boolean course_type_available = true;		//Course Type

	//Check which data is available or null
	if(line_department==null || line_department.trim().equals(""))	//For Line Department
	{  
		line_department_available = false;
		//Give Response to Client Return Error
		out.print("Please Select Line Department");
	}
	else if(course_type==null || course_type.trim().equals(""))		//For Course Type
	{  
		course_type_available = false; 
		//Give Response to Client Return Error
		out.print("Please Select Course Type");
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

			//If Line Department & Course Type Available
			if(line_department_available && course_type_available)
			{
				qry = "select * from courses where line_department='"+line_department+"' and course_type='"+course_type+"' order by course_code";
			}			

			//Execute Select Query & Get Results
			PreparedStatement ps = con.prepareStatement(qry);  
			ResultSet rs = ps.executeQuery();

			//If No Data Available in Result Set
			if(!rs.next())
			{
				//Give Response to Client Return Error
				out.print("No Courses Found");  
			}
			//If Data Available in Result Set
			else
			{
				//Create New JSON Array
				JSONArray courses_array = new JSONArray();
				//Iterate through all the rows
				do
				{
					//Create JSON Object & Put Data into it
	                JSONObject course_array = new JSONObject();
	                course_array.put("course_code",rs.getString("course_code"));
	                course_array.put("course_name",rs.getString("course_name"));
	                course_array.put("branch_name",rs.getString("branch_name"));
	                course_array.put("course_duration",rs.getString("course_duration"));
	                course_array.put("course_type",rs.getString("course_type"));
	                //Append JSON Object of Single Row in JSON Array
	                courses_array.put(course_array);
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
		out.print("Problem While Searching Courses : "+ e);
	}   
%>