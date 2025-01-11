<% //Page Imports SQL & JSON %>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.*"%>  
  
<%  
	//Get Request Parameters into Local Variables
	String ins_dep = request.getParameter("ins_dep");	//Institute Department
	String ins_dis = request.getParameter("ins_dis");	//Institute District
	String ins_name = request.getParameter("ins_name");	//Institute Name
	String ins_code = request.getParameter("ins_code");	//Institute Code

	//Create Boolean Type Local Variables to check if data available in parameters or null
	boolean ins_dep_available = true;	//Institute Department
	boolean ins_dis_available = true;	//Institute District
	boolean ins_name_available = true;	//Institute Name
	boolean ins_code_available = true;	//Institute Code

	//Check which data is available or null
	if(ins_dep==null || ins_dep.trim().equals(""))		//For Institute Department
	{  
		ins_dep_available = false;
	}
	if(ins_dis==null || ins_dis.trim().equals(""))		//For Institute District
	{  
		ins_dis_available = false; 
	}
	if(ins_name==null || ins_name.trim().equals(""))	//For Institute Name
	{  
		ins_name_available = false; 
	}
	if(ins_code==null || ins_code.trim().equals(""))	//For Institute Code
	{  
		ins_code_available = false; 
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

			//If Institute Department, District, Name & Code Available
			if(ins_dep_available && ins_dis_available && ins_name_available && ins_code_available)
			{
				//If Institute Department - All Department
				if(ins_dep.equals("All Department"))
				{
					qry = "select * from institutes where ins_district='"+ins_dis+"' and ins_code='"+ins_code+"' and ins_name like '"+ins_name+"%' order by ins_name";
				}
				//If Institute Department is Specified by Client
				else
				{
					qry = "select * from institutes where ins_dep='"+ins_dep+"' and ins_district='"+ins_dis+"' and ins_code='"+ins_code+"' and ins_name like '"+ins_name+"%' order by ins_name";
				}
			}

			//If Institute Department, District & Code Available
			else if(ins_dep_available && ins_dis_available && ins_code_available)
			{
				//If Institute Department - All Department
				if(ins_dep.equals("All Department"))
				{
					qry = "select * from institutes where ins_district='"+ins_dis+"' and ins_code='"+ins_code+"' order by ins_name";
				}
				//If Institute Department is Specified by Client
				else
				{
					qry = "select * from institutes where ins_dep='"+ins_dep+"' and ins_district='"+ins_dis+"' and ins_code='"+ins_code+"' order by ins_name";
				}
			}

			//If Institute Department, Name & Code Available
			else if(ins_dep_available && ins_name_available && ins_code_available)
			{
				//If Institute Department - All Department
				if(ins_dep.equals("All Department"))
				{
					qry = "select * from institutes where ins_code='"+ins_code+"' and ins_name like '"+ins_name+"%' order by ins_name";
				}
				//If Institute Department is Specified by Client
				else
				{
					qry = "select * from institutes where ins_dep='"+ins_dep+"' and ins_code='"+ins_code+"' and ins_name like '"+ins_name+"%' order by ins_name";
				}
			}

			//If Institute Department, District & Name Available
			else if(ins_dep_available && ins_dis_available && ins_name_available)
			{
				//If Institute Department - All Department
				if(ins_dep.equals("All Department"))
				{
					qry = "select * from institutes where ins_district='"+ins_dis+"' and ins_name like '"+ins_name+"%' order by ins_name";
				}
				//If Institute Department is Specified by Client
				else
				{
					qry = "select * from institutes where ins_dep='"+ins_dep+"' and ins_district='"+ins_dis+"' and ins_name like '"+ins_name+"%' order by ins_name";
				}
			}

			//If Institute Department & Code Available
			else if(ins_dep_available && ins_code_available)
			{
				//If Institute Department - All Department
				if(ins_dep.equals("All Department"))
				{
					qry = "select * from institutes where ins_code='"+ins_code+"' order by ins_name";
				}
				//If Institute Department is Specified by Client
				else
				{
					qry = "select * from institutes where ins_dep='"+ins_dep+"' and ins_code='"+ins_code+"' order by ins_name";
				}
			}	

			//If Institute Department & Name Available
			else if(ins_dep_available && ins_name_available)
			{
				//If Institute Department - All Department
				if(ins_dep.equals("All Department"))
				{
					qry = "select * from institutes where ins_name like '"+ins_name+"%' order by ins_name";
				}
				//If Institute Department is Specified by Client
				else
				{
					qry = "select * from institutes where ins_dep='"+ins_dep+"' and ins_name like '"+ins_name+"%' order by ins_name";
				}
			}

			//If Institute Department & District Available
			else if(ins_dep_available && ins_dis_available)
			{
				//If Institute Department - All Department
				if(ins_dep.equals("All Department"))
				{
					qry = "select * from institutes where ins_district='"+ins_dis+"' order by ins_name";
				}
				//If Institute Department is Specified by Client
				else
				{
					qry = "select * from institutes where ins_dep='"+ins_dep+"' and ins_district='"+ins_dis+"' order by ins_name";
				}
			}

			//If Institute Department Available
			else if(ins_dep_available)
			{
				//If Institute Department - All Department
				if(ins_dep.equals("All Department"))
				{
					qry = "select * from institutes order by ins_name";
				}
				//If Institute Department is Specified by Client
				else
				{
					qry = "select * from institutes where ins_dep='"+ins_dep+"' order by ins_name";
				}
			}

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
				//Iterate through all the rows
				do
				{
					//Create JSON Object & Put Data into it
	                JSONObject institute_array = new JSONObject();
	                institute_array.put("ins_code",rs.getString("ins_code"));
	                institute_array.put("ins_name",rs.getString("ins_name"));
	                institute_array.put("ins_type",rs.getString("ins_type"));
	                institute_array.put("ins_dep",rs.getString("ins_dep"));
	                institute_array.put("ins_district",rs.getString("ins_district"));
	                institute_array.put("ins_address",rs.getString("ins_address"));
	                institute_array.put("ins_mobile",rs.getString("ins_mobile"));
	                institute_array.put("ins_email",rs.getString("ins_email"));
	                //Append JSON Object of Single Row in JSON Array
	                institutes_array.put(institute_array);
	            }while(rs.next());
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