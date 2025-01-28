//Imports
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import com.utils.db.DBConnection;

//Define Servlet Component
@WebServlet("/Student_Login")

//Class Student_Login
public class Student_Login extends HttpServlet
{
	//doPost Method
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
    	//Get Data from Request and Store them in Local Variables
    	String applicant_id = request.getParameter("applicant_id");
        String student_password = request.getParameter("student_password");

        //Create Boolean Type Local Variables to check if Applicant is Trustworthy
        boolean applicant_is_trustworthy = false;
        
        //Create Connection Object
		Connection con = null;

		try
		{
			//Try to open Database Connection
			con = DBConnection.getConnection();

			//If Connection Successfully Established
			if(con != null && !con.isClosed())
			{
				//Create Select Query for getting data from students table where applicant_id & student_password matches with user input & Execute it
				String qry = "select * from students where applicant_id='"+applicant_id+"' and student_password='"+student_password+"'";
				PreparedStatement ps = con.prepareStatement(qry);
				ResultSet rs = ps.executeQuery();

				//Check if Applicant Id & Password Matches
				applicant_is_trustworthy = rs.next();

				//If Applicant is Trustworthy
				if(applicant_is_trustworthy)
				{
					//Creates New Session & Set Attributes
					HttpSession session=request.getSession();
					session.setAttribute("applicant_id",applicant_id);
					session.setAttribute("student_name",rs.getString("student_name"));

					//Close Database Connectivity
					con.close();

					//Redirect to Dashboard Page
					getServletContext().getRequestDispatcher("/jsp/sdashboard.jsp").forward(request, response);
				}

				//If Applicant is not Trustworthy
				else
				{
					//Close Database Connectivity & Redirect Message
					con.close();
					request.setAttribute("message", "Wrong Username or Password");
					getServletContext().getRequestDispatcher("/jsp/slogin.jsp").forward(request, response);
				}
			}

			//If Connection not Successfully Established
			else
			{
				//Create Failed Message and Dispatch Response to JSP Page
				request.setAttribute("message", "Database Connectivity Failed");
     			getServletContext().getRequestDispatcher("/jsp/slogin.jsp").forward(request, response);
			}
		}
		catch(SQLException se)
		{
			//Create SQL Exception Message and Dispatch Response to JSP Page
			request.setAttribute("message", "SQL Exception : "+se);
     		getServletContext().getRequestDispatcher("/jsp/slogin.jsp").forward(request, response);
		}
		catch(Exception e)
		{
			//Create Other Exception Message and Dispatch Response to JSP Page
			request.setAttribute("message", "Exception : "+e);
     		getServletContext().getRequestDispatcher("/jsp/slogin.jsp").forward(request, response);
		}
    }
}