//Imports
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

//Define Servlet Component
@WebServlet("/Institute_Logout")

//Class Institute_Logout
public class Institute_Logout extends HttpServlet
{
	//doPost Method
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
    	HttpSession session=request.getSession();  
        session.invalidate();
        request.setAttribute("message", "Logged Out Successfully");
		getServletContext().getRequestDispatcher("/jsp/ilogin.jsp").forward(request, response);
    }
}