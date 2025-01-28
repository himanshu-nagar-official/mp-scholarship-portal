//Imports
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import javax.servlet.http.*;
import com.utils.db.DBConnection;

//Define Servlet Component
@WebServlet("/Main_Application_Registration")

//Class Main_Application_Registration
public class Main_Application_Registration extends HttpServlet
{
	//doPost Method
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
    	//Get the Session Data
        HttpSession session = request.getSession(false);
        String applicant_id =(String)session.getAttribute("applicant_id");
		//String student_name =(String)session.getAttribute("student_name");

    	//Get Data from Request and Store them in Local Variables
        String scheme_id = request.getParameter("scheme_id");
        String academic_year = request.getParameter("academic_year");
        String scholarship_scheme = request.getParameter("scholarship_scheme");
        String institute_code = request.getParameter("institute_code");
        String course_code = request.getParameter("course_code");
        String course_year = request.getParameter("course_year");
        String admission_date = request.getParameter("admission_date");
        String enrollment_date = request.getParameter("enrollment_date");
        String enrollment_number = request.getParameter("enrollment_number");
        String disability_status = request.getParameter("disability_status");
        String admission_type = request.getParameter("admission_type");
        String counselling_id = request.getParameter("counselling_id");
        String counselling_date = request.getParameter("counselling_date");
        String exam_name = request.getParameter("exam_name");
        String exam_date = request.getParameter("exam_date");
        String school_institute = request.getParameter("school_institute");
        String last_total_marks = request.getParameter("last_total_marks");
        String last_obtained_marks = request.getParameter("last_obtained_marks");
        String last_percentage = request.getParameter("last_percentage");
        String last_result = request.getParameter("last_result");
        String father_occupation = request.getParameter("father_occupation");
        String mother_occupation = request.getParameter("mother_occupation");
        String annual_family_income = request.getParameter("annual_family_income");
        String ic_issued_by = request.getParameter("ic_issued_by");
        String income_certificate_date = request.getParameter("income_certificate_date");
        String application_status = "Submitted";

        //Create Connection Object
		Connection con = null;

		try
		{
			//Try to open Database Connection
			con = DBConnection.getConnection();

			//If Connection Successfully Established
			if(con != null && !con.isClosed())
			{
				//Create Select Query for getting all data from application table & Execute it
				String qry = "select application_id from application";
				PreparedStatement ps = con.prepareStatement(qry);
				ResultSet rs = ps.executeQuery();

				//Create Boolean Type Local Variables to check if Application Already Registered
				boolean application_id_already_available = true;
				boolean application_already_available = false;

				//Create application_id Local Variable
				String application_id = "";

				//Loop till we generate an unique application id
				while(application_id_already_available)
				{
					//Generate New Application Id
					application_id = String.valueOf(application_id());

					//Check if Result Set is Empty
					application_id_already_available = rs.next();
					
					//Loop through all the rows and check if application id is duplicate or not
					if(application_already_available)
					{
						do
						{
							if(application_id.equals(rs.getString("application_id")))
								application_id_already_available = true;
							else
								application_id_already_available = false;
						}while(rs.next());
					}

					//If not duplicate break this Loop
					if(application_id_already_available==false)
						break;
				}

				//Create SQL Query for Execution
				qry = "insert into application (application_id,applicant_id,academic_year,scholarship_scheme,institute_code,course_code,course_year,admission_date,enrollment_date,enrollment_number,disability_status,admission_type, counselling_id, counselling_date,exam_name,exam_date,school_institute,last_total_marks,last_obtained_marks,last_percentage,last_result,father_occupation,mother_occupation,annual_family_income,ic_issued_by,income_certificate_date,application_status) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				//Create Prepared Statement using the SQL Query
				ps = con.prepareStatement(qry);
				//Set Parameters in Prepared Statement
				ps.setString(1,application_id);
				ps.setString(2,applicant_id);
				ps.setString(3,academic_year);
				ps.setString(4,scholarship_scheme);
				ps.setString(5,institute_code);
				ps.setString(6,course_code);
				ps.setString(7,course_year);
				ps.setString(8,admission_date);
				ps.setString(9,enrollment_date);
				ps.setString(10,enrollment_number);
				ps.setString(11,disability_status);
				ps.setString(12,admission_type);
				ps.setString(13,counselling_id);
				ps.setString(14,counselling_date);
				ps.setString(15,exam_name);
				ps.setString(16,exam_date);
				ps.setString(17,school_institute);
				ps.setString(18,last_total_marks);
				ps.setString(19,last_obtained_marks);
				ps.setString(20,last_percentage);
				ps.setString(21,last_result);
				ps.setString(22,father_occupation);
				ps.setString(23,mother_occupation);
				ps.setString(24,annual_family_income);
				ps.setString(25,ic_issued_by);
				ps.setString(26,income_certificate_date);
				ps.setString(27,application_status);
				//Execute the SQL Query to Store Data into Database Table
				int i = 0;
				i = ps.executeUpdate();

				//If Data Stored Successfully
				if(i>=1)
				{
					//Create Success Message and Dispatch Response to JSP Page
					request.setAttribute("message", "Scholarship Application Form Registered Successfully");
     				getServletContext().getRequestDispatcher("/jsp/main_application_dashboard.jsp?scheme_id="+scheme_id).forward(request, response);
				}
				//If Data not Stored Successfully
				else
				{
					//Create Failed Message and Dispatch Response to JSP Page
					request.setAttribute("message", "Scholarship Application Form Registration Failed!");
     				getServletContext().getRequestDispatcher("/jsp/main_application_dashboard.jsp?scheme_id="+scheme_id).forward(request, response);
				}
			}
			//If Connection not Successfully Established
			else
			{
				//Create Failed Message and Dispatch Response to JSP Page
				request.setAttribute("message", "Database Connectivity Failed");
     			getServletContext().getRequestDispatcher("/jsp/main_application_dashboard.jsp?scheme_id="+scheme_id).forward(request, response);
			}
		}
		catch(SQLException se)
		{
			//Create SQL Exception Message and Dispatch Response to JSP Page
			request.setAttribute("message", "SQL Exception : "+se);
     		getServletContext().getRequestDispatcher("/jsp/main_application_dashboard.jsp?scheme_id="+scheme_id).forward(request, response);
		}
		catch(Exception e)
		{
			//Create Other Exception Message and Dispatch Response to JSP Page
			request.setAttribute("message", "Exception : "+e);
     		getServletContext().getRequestDispatcher("/jsp/main_application_dashboard.jsp?scheme_id="+scheme_id).forward(request, response);
		}
    }

    //Application Id Generator Method
    private static char[] application_id()
    {
    	int length = 6;
    	int i;
        String numbers = "123456789";
        Random random = new Random();
        char[] application_id = new char[length];
  
        for(i=0;i<length;i++)
        {
            application_id[i] = numbers.charAt(random.nextInt(numbers.length()));
            numbers += "0";
        }
        return application_id;
    }
}