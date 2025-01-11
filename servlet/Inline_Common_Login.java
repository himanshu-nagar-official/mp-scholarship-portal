//Imports
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

//Define Servlet Component
@WebServlet("/Inline_Common_Login")

//Class Inline_Common_Login
public class Inline_Common_Login extends HttpServlet
{
	//doPost Method
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
    	String login_type = request.getParameter("login_type");

  		if(login_type.equals("Student"))
    	{
    		//Get Data from Request and Store them in Local Variables
	    	String applicant_id = request.getParameter("user_id");
	        String student_password = request.getParameter("password");

	        //Create Boolean Type Local Variables to check if Applicant is Trustworthy
	        boolean applicant_is_trustworthy = false;
	        
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
    	else if(login_type.equals("Institute"))
    	{
    		//Get Data from Request and Store them in Local Variables
	    	String ins_code = request.getParameter("user_id");
	        String ins_password = request.getParameter("password");

	        //Create Boolean Type Local Variables to check if Institute is Trustworthy
	        boolean institute_is_trustworthy = false;
	        
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
					//Create Select Query for getting data from institutes table where ins_code & ins_password matches with user input & Execute it
					String qry = "select * from institutes where ins_code='"+ins_code+"' and ins_password='"+ins_password+"'";
					PreparedStatement ps = con.prepareStatement(qry);
					ResultSet rs = ps.executeQuery();

					//Check if Institute Id & Password Matches
					institute_is_trustworthy = rs.next();

					//If Institute is Trustworthy
					if(institute_is_trustworthy)
					{
						//Creates New Session & Set Attributes
						HttpSession session=request.getSession();
						session.setAttribute("ins_code",ins_code);
						session.setAttribute("ins_name",rs.getString("ins_name"));

						//Close Database Connectivity
						con.close();

						//Redirect to Dashboard Page
						getServletContext().getRequestDispatcher("/jsp/idashboard.jsp").forward(request, response);
					}

					//If Institute is not Trustworthy
					else
					{
						//Close Database Connectivity & Redirect Message
						con.close();
						request.setAttribute("message", "Wrong Institute Id or Password");
						getServletContext().getRequestDispatcher("/jsp/ilogin.jsp").forward(request, response);
					}
				}

				//If Connection not Successfully Established
				else
				{
					//Create Failed Message and Dispatch Response to JSP Page
					request.setAttribute("message", "Database Connectivity Failed");
	     			getServletContext().getRequestDispatcher("/jsp/ilogin.jsp").forward(request, response);
				}
			}
			catch(SQLException se)
			{
				//Create SQL Exception Message and Dispatch Response to JSP Page
				request.setAttribute("message", "SQL Exception : "+se);
	     		getServletContext().getRequestDispatcher("/jsp/ilogin.jsp").forward(request, response);
			}
			catch(Exception e)
			{
				//Create Other Exception Message and Dispatch Response to JSP Page
				request.setAttribute("message", "Exception : "+e);
	     		getServletContext().getRequestDispatcher("/jsp/ilogin.jsp").forward(request, response);
			}
    	}
    }
}