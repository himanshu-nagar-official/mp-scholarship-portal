//Imports
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import javax.servlet.http.*;

//Define Servlet Component
@WebServlet("/Application_Approval")

//Class Application_Approval
public class Application_Approval extends HttpServlet
{
	//doPost Method
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
    	//Get Data from Request and Store them in Local Variables
        String approve_form = request.getParameter("approve_form");
        String reject_form = request.getParameter("reject_form");
        String application_status = "";
        String application_id = "";

        if(approve_form!=null)
        {
        	application_status = "Approved";
        	application_id = approve_form;
        }
        else
        {
        	application_status = "Rejected";
        	application_id = reject_form;
        }

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
				//Create SQL Query for Execution
				String qry = "update application SET application_status=? where application_id='"+application_id+"'";
				//Create Prepared Statement using the SQL Query
				PreparedStatement ps = con.prepareStatement(qry);
				//Set Parameters in Prepared Statement
				ps.setString(1,application_status);
				//Execute the SQL Query to Store Data into Database Table
				int i = 0;
				i = ps.executeUpdate();

				//If Data Stored Successfully
				if(i>=1)
				{
					//Create Success Message and Dispatch Response to JSP Page
					request.setAttribute("message", "Scholarship Form "+application_status+" Successfully!");
     				getServletContext().getRequestDispatcher("/jsp/idashboard.jsp").forward(request, response);
				}
				//If Data not Stored Successfully
				else
				{
					//Create Failed Message and Dispatch Response to JSP Page
					request.setAttribute("message", "Failed!");
     				getServletContext().getRequestDispatcher("/jsp/idashboard.jsp").forward(request, response);
				}
			}
			//If Connection not Successfully Established
			else
			{
				//Create Failed Message and Dispatch Response to JSP Page
				request.setAttribute("message", "Database Connectivity Failed");
     			getServletContext().getRequestDispatcher("/jsp/idashboard.jsp").forward(request, response);
			}
		}
		catch(SQLException se)
		{
			//Create SQL Exception Message and Dispatch Response to JSP Page
			request.setAttribute("message", "SQL Exception : "+se);
     		getServletContext().getRequestDispatcher("/jsp/idashboard.jsp").forward(request, response);
		}
		catch(Exception e)
		{
			//Create Other Exception Message and Dispatch Response to JSP Page
			request.setAttribute("message", "Exception : "+e);
     		getServletContext().getRequestDispatcher("/jsp/idashboard.jsp").forward(request, response);
		}
    }
}