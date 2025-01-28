<% //Page Imports SQL & JSON %>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.*"%>
<%@ page import="com.utils.db.DBConnection" %> 
  
<%  
	//Get Request Parameters into Local Variables
	String application_id = request.getParameter("application_id");	//Applicant Id
	  
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
			String qry = "select * from application where application_id="+application_id;

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
					//Create SQL Query Local Variable
					qry = "select * from students where applicant_id="+rs.getString("applicant_id");

					//Execute Select Query & Get Results
					ps = con.prepareStatement(qry);  
					ResultSet stu_rs = ps.executeQuery();
					stu_rs.next();

					//Create JSON Object & Put Data into it
	                JSONObject application_array = new JSONObject();
	                application_array.put("applicant_id",rs.getString("applicant_id"));
	                application_array.put("academic_year",rs.getString("academic_year"));
	                application_array.put("application_id",rs.getString("application_id"));
	                application_array.put("scholarship_scheme",rs.getString("scholarship_scheme"));
	                application_array.put("student_name",stu_rs.getString("student_name"));
	                application_array.put("student_dob",stu_rs.getString("student_dob"));
	                application_array.put("student_gender",stu_rs.getString("student_gender"));
	                application_array.put("student_religion",stu_rs.getString("student_religion"));
	                application_array.put("student_father_name",stu_rs.getString("student_father_name"));
	                application_array.put("student_samagra",stu_rs.getString("student_samagra"));
	                application_array.put("student_aadhaar",stu_rs.getString("student_aadhaar"));
	                application_array.put("voter_id",stu_rs.getString("voter_id"));
	                application_array.put("student_category",stu_rs.getString("student_category"));
	                if(stu_rs.getString("caste_certificate_number")!=null)
	                {
	                	application_array.put("caste_certificate_number",stu_rs.getString("caste_certificate_number"));
	                }
	                else
	                {
	                	application_array.put("caste_certificate_number","NA");
	                }
	                application_array.put("admission_date",rs.getString("admission_date"));
	                application_array.put("enrollment_number",rs.getString("enrollment_number"));

	                //Create SQL Query Local Variable
					qry = "select * from institutes where ins_code="+rs.getString("institute_code");

					//Execute Select Query & Get Results
					ps = con.prepareStatement(qry);  
					ResultSet dep_rs = ps.executeQuery();
					dep_rs.next();

	                application_array.put("ins_dep",dep_rs.getString("ins_dep"));
	                application_array.put("ins_name",dep_rs.getString("ins_name"));

	                //Create SQL Query Local Variable
					qry = "select * from courses where course_code="+rs.getString("course_code");

					//Execute Select Query & Get Results
					ps = con.prepareStatement(qry);  
					ResultSet cou_rs = ps.executeQuery();
					cou_rs.next();

	                application_array.put("course_name",cou_rs.getString("course_name"));
	                application_array.put("ins_code",dep_rs.getString("ins_code"));
	                application_array.put("course_code",cou_rs.getString("course_code"));
	                application_array.put("ins_district",dep_rs.getString("ins_district"));
	                application_array.put("high_school_board",stu_rs.getString("high_school_board"));
	                application_array.put("high_school_passing_year",stu_rs.getString("high_school_passing_year"));
	                application_array.put("high_school_roll_no",stu_rs.getString("high_school_roll_no"));
	                application_array.put("high_school_percentage",stu_rs.getString("high_school_percentage"));
	                application_array.put("high_school_division",stu_rs.getString("high_school_division"));
	                application_array.put("exam_name",rs.getString("exam_name"));
	                application_array.put("exam_date",rs.getString("exam_date"));
	                application_array.put("last_percentage",rs.getString("last_percentage"));
	                application_array.put("last_result",rs.getString("last_result"));
	                application_array.put("school_institute",rs.getString("school_institute"));
	                application_array.put("annual_family_income",rs.getString("annual_family_income"));
	                application_array.put("ic_issued_by",rs.getString("ic_issued_by"));
	                application_array.put("income_certificate_date",rs.getString("income_certificate_date"));
	                application_array.put("student_mobile",stu_rs.getString("student_mobile"));
	                application_array.put("student_email",stu_rs.getString("student_email"));
	                application_array.put("student_address",stu_rs.getString("student_address"));
	                application_array.put("student_state",stu_rs.getString("student_state"));
	                application_array.put("student_district",stu_rs.getString("student_district"));
	                application_array.put("student_pincode",stu_rs.getString("student_pincode"));
	                application_array.put("account_number",stu_rs.getString("account_number"));
	                application_array.put("bank_name",stu_rs.getString("bank_name"));
	                application_array.put("ifsc_code",stu_rs.getString("ifsc_code"));
	                application_array.put("branch",stu_rs.getString("branch"));

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
		out.print("Problem While Searching Application : "+ e);
	}   
%>