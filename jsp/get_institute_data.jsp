<% //Page Imports SQL & JSON %>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.*"%>
<%@ page import="com.utils.db.DBConnection" %>
  
<%  
	//Get Request Parameters into Local Variables
	String ins_code = request.getParameter("ins_code");	//Institute Code
	  
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
			String qry = "select * from institutes where ins_code='"+ins_code+"'";

			//Execute Select Query & Get Results
			PreparedStatement ps = con.prepareStatement(qry);  
			ResultSet rs = ps.executeQuery();

			//If No Data Available in Result Set
			if(!rs.next())
			{
				//Give Response to Client Return Error
				out.print("No Institute Found");  
			}
			//If Data Available in Result Set
			else
			{
				//Create New JSON Array
				JSONArray institutes_array = new JSONArray();
				//Create JSON Object & Put Data into it
                JSONObject institute_array = new JSONObject();
                institute_array.put("ins_name",rs.getString("ins_name"));
                institute_array.put("ins_type",rs.getString("ins_type"));
                institute_array.put("ins_dep",rs.getString("ins_dep"));
                institute_array.put("ins_district",rs.getString("ins_district"));
                //Append JSON Object of Single Row in JSON Array
                institutes_array.put(institute_array);
	            //Give Response to Client Return JSON Array
	            out.print(institutes_array);	
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