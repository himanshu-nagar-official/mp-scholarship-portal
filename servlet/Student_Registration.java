//Imports
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

//Define Servlet Component
@WebServlet("/Student_Registration")

//Class Student_Registration
public class Student_Registration extends HttpServlet
{
	//doPost Method
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        //Get Data from Request and Store them in Local Variables
        String student_name = request.getParameter("student_name");
        String student_father_name = request.getParameter("student_father_name");
		String student_dob = request.getParameter("student_dob");
		String student_gender = request.getParameter("student_gender");
		String student_category = request.getParameter("student_category");
		String student_religion = request.getParameter("student_religion");
		String student_mobile = request.getParameter("student_mobile");
		String student_email = request.getParameter("student_email");
		String student_aadhaar = request.getParameter("student_aadhaar");
		String student_samagra = request.getParameter("student_samagra");
		String student_area = request.getParameter("student_area");
		String student_state = request.getParameter("student_state");
		String student_district = request.getParameter("student_district");
		String student_pincode = request.getParameter("student_pincode");
		String student_password = request.getParameter("student_password");
		String student_address = request.getParameter("student_address");

		//Create Connection Object
		Connection con = null;

		//Create MySQL Database Connection Parameters Local Variables
		String url = "jdbc:mysql://localhost:3309/mp-scholarship-portal";
		String uid = "root";
		String pass = "poly";
		String driver = "com.mysql.jdbc.Driver";

		try
		{
			//Try to open Database Connection
			Class.forName(driver);
			con = DriverManager.getConnection(url,uid,pass);

			//If Connection Successfully Established
			if(!con.isClosed())
			{
				//Create Select Query for getting all data from students table & Execute it
				String qry = "select applicant_id from students";
				PreparedStatement ps = con.prepareStatement(qry);
				ResultSet rs = ps.executeQuery();

				//Create Boolean Type Local Variables to check if Applicant Already Registered
				boolean applicant_id_already_available = true;
				boolean applicant_already_available = false;

				//Create applicant_id Local Variable
				String applicant_id = "";

				//Loop till we generate an unique applicant id
				while(applicant_id_already_available)
				{
					//Generate New Applicant Id
					applicant_id = String.valueOf(applicant_id());

					//Check if Result Set is Empty
					applicant_id_already_available = rs.next();
					
					//Loop through all the rows and check if applicant id is duplicate or not
					if(applicant_already_available)
					{
						do
						{
							if(applicant_id.equals(rs.getString("applicant_id")))
								applicant_id_already_available = true;
							else
								applicant_id_already_available = false;
						}while(rs.next());
					}

					//If not duplicate break this Loop
					if(applicant_id_already_available==false)
						break;
				}

				//Create Select Query for getting student_mobile, student_email, student_aadhaar & student_samagra data from students table & Execute it
				qry = "select student_mobile, student_email, student_aadhaar, student_samagra from students";
				ps = con.prepareStatement(qry);
				rs = ps.executeQuery();

				//Check for Duplicate Values
				while(rs.next())
				{
					//For Duplicate Student Mobile Number
					if(student_mobile.equals(rs.getString("student_mobile")))
					{
						applicant_already_available = true;
						break;
					}
					//For Duplicate Student Email
					else if(student_email.equals(rs.getString("student_email")))
					{
						applicant_already_available = true;
						break;
					}
					//For Duplicate Student Aadhaar
					else if(student_aadhaar.equals(rs.getString("student_aadhaar")))
					{
						applicant_already_available = true;
						break;
					}
					//For Duplicate Student Samagra
					else if(student_samagra.equals(rs.getString("student_samagra")))
					{
						applicant_already_available = true;
						break;
					}
					else
					{
						applicant_already_available = false;
					}
				}

				//If Duplicate Data Available & Applicant Already Available
				if(applicant_already_available)
				{
					//Close Database Connectivity & Redirect Message
					con.close();
					request.setAttribute("message", "Student Already Available");
					getServletContext().getRequestDispatcher("/jsp/sregistration.jsp").forward(request, response);
				}

				//If Applicant not Available Already
				else
				{
					//Create SQL Query for Insertion
					qry = "insert into students (applicant_id,student_name,student_father_name,student_dob,student_gender,student_category,student_religion,student_mobile,student_email,student_aadhaar,student_samagra,student_area,student_state,student_district,student_pincode,student_password,student_address) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

					//Create Prepared Statement using the SQL Query
					ps = con.prepareStatement(qry);

					//Set Parameters in Prepared Statement
					ps.setString(1,applicant_id);
					ps.setString(2,student_name);
					ps.setString(3,student_father_name);
					ps.setString(4,student_dob);
					ps.setString(5,student_gender);
					ps.setString(6,student_category);
					ps.setString(7,student_religion);
					ps.setString(8,student_mobile);
					ps.setString(9,student_email);
					ps.setString(10,student_aadhaar);
					ps.setString(11,student_samagra);
					ps.setString(12,student_area);
					ps.setString(13,student_state);
					ps.setString(14,student_district);
					ps.setString(15,student_pincode);
					ps.setString(16,student_password);
					ps.setString(17,student_address);

					//Execute the SQL Query to Store Data into Database Table
					int i = 0;
					i = ps.executeUpdate();

					//If Data Stored Successfully
					if(i>=1)
					{
						//Close Database Connectivity
						con.close();
						//Create Success Message and Dispatch Response to JSP Page
						request.setAttribute("student_name", student_name);
						request.setAttribute("applicant_id", applicant_id);
						request.setAttribute("student_password", student_password);
	     				getServletContext().getRequestDispatcher("/jsp/registration_successfull.jsp").forward(request, response);
					}

					//If Data not Stored Successfully
					else
					{
						//Close Database Connectivity
						con.close();
						//Create Failed Message and Dispatch Response to JSP Page
						request.setAttribute("message", "Student Registration Failed");
	     				getServletContext().getRequestDispatcher("/jsp/sregistration.jsp").forward(request, response);
					}	
				}
			}
			//If Connection not Successfully Established
			else
			{
				//Create Failed Message and Dispatch Response to JSP Page
				request.setAttribute("message", "Database Connectivity Failed");
     			getServletContext().getRequestDispatcher("/jsp/sregistration.jsp").forward(request, response);
			}
		}
		catch(SQLException se)
		{
			//Create SQL Exception Message and Dispatch Response to JSP Page
			request.setAttribute("message", "SQL Exception : "+se);
     		getServletContext().getRequestDispatcher("/jsp/sregistration.jsp").forward(request, response);
		}
		catch(Exception e)
		{
			//Create Other Exception Message and Dispatch Response to JSP Page
			request.setAttribute("message", "Exception : "+e);
     		getServletContext().getRequestDispatcher("/jsp/sregistration.jsp").forward(request, response);
		}
    }

    //Applicant Id Generator Method
    private static char[] applicant_id()
    {
    	int length = 8;
    	int i;
        String numbers = "123456789";
        Random random = new Random();
        char[] applicant_id = new char[length];
  
        for(i=0;i<length;i++)
        {
            applicant_id[i] = numbers.charAt(random.nextInt(numbers.length()));
            numbers += "0";
        }
        return applicant_id;
    }
}