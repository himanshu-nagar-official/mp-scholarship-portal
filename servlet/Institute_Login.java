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
@WebServlet("/Institute_Login")

//Class Institute_Login
public class Institute_Login extends HttpServlet
{
	//doPost Method
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
    	//Get Data from Request and Store them in Local Variables
    	String ins_code = request.getParameter("ins_code");
        String ins_password = request.getParameter("ins_password");

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