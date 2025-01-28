//Imports
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import javax.servlet.http.*;
import com.utils.db.DBConnection;

//Define Servlet Component
@WebServlet("/Update_Student_Voter_Id")

//Class Update_Student_Voter_Id
public class Update_Student_Voter_Id extends HttpServlet
{
	//doPost Method
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
    	//Get the Session Data
        HttpSession session = request.getSession(false);
        String applicant_id =(String)session.getAttribute("applicant_id");

    	//Get Data from Request and Store them in Local Variables
        String scheme_id = request.getParameter("scheme_id");
        String voter_id = request.getParameter("voter_id");

        //Create Connection Object
		Connection con = null;

		try
		{
			//Try to open Database Connection
			con = DBConnection.getConnection();

			//If Connection Successfully Established
			if(con != null && !con.isClosed())
			{
				//Create SQL Query for Execution
				String qry = "update students SET voter_id=? where applicant_id='"+applicant_id+"'";
				//Create Prepared Statement using the SQL Query
				PreparedStatement ps = con.prepareStatement(qry);
				//Set Parameters in Prepared Statement
				ps.setString(1,voter_id);
				//Execute the SQL Query to Store Data into Database Table
				int i = 0;
				i = ps.executeUpdate();

				//If Data Stored Successfully
				if(i>=1)
				{
					//Create Success Message and Dispatch Response to JSP Page
					request.setAttribute("message", "Student Voter Id Number Updated Successfully!");
     				getServletContext().getRequestDispatcher("/jsp/main_application_update_voter_id.jsp?scheme_id="+scheme_id).forward(request, response);
				}
				//If Data not Stored Successfully
				else
				{
					//Create Failed Message and Dispatch Response to JSP Page
					request.setAttribute("message", "Student Voter Id Number Updation Failed!");
     				getServletContext().getRequestDispatcher("/jsp/main_application_update_voter_id.jsp?scheme_id="+scheme_id).forward(request, response);
				}
			}
			//If Connection not Successfully Established
			else
			{
				//Create Failed Message and Dispatch Response to JSP Page
				request.setAttribute("message", "Database Connectivity Failed");
     			getServletContext().getRequestDispatcher("/jsp/main_application_update_voter_id.jsp?scheme_id="+scheme_id).forward(request, response);
			}
		}
		catch(SQLException se)
		{
			//Create SQL Exception Message and Dispatch Response to JSP Page
			request.setAttribute("message", "SQL Exception : "+se);
     		getServletContext().getRequestDispatcher("/jsp/main_application_update_voter_id.jsp?scheme_id="+scheme_id).forward(request, response);
		}
		catch(Exception e)
		{
			//Create Other Exception Message and Dispatch Response to JSP Page
			request.setAttribute("message", "Exception : "+e);
     		getServletContext().getRequestDispatcher("/jsp/main_application_update_voter_id.jsp?scheme_id="+scheme_id).forward(request, response);
		}
    }
}