//Imports
import java.io.File;
import java.io.IOException;
import java.sql.*;
import java.io.InputStream;
import java.io.FileOutputStream; 
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.utils.db.DBConnection;

//Define Servlet Component
@WebServlet("/Upload_Higher_Secondary")

@MultipartConfig(fileSizeThreshold = 1024*1024*10,		//	10MB
				 maxFileSize = 1024*1024*50,			//	50MB
				 maxRequestSize = 1024*1024*100)		//	100MB

//Class Upload_Higher_Secondary
public class Upload_Higher_Secondary extends HttpServlet
{
	//Directory where uploaded files will be saved, its relative to the web application directory.
    private static final String UPLOAD_DIR = "uploads/images/";
    
	//doPost Method
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
    	//Path where Web Application Exists
        String applicationPath = request.getServletContext().getRealPath("");

        //Path where Files will be stored
        String higher_secondary_marksheet_path = applicationPath + File.separator + UPLOAD_DIR + "student_higher_secondary_marksheet/";
         
        //Creates the save directory if it does not exists
        File higher_secondary_marksheets_save_dir = new File(higher_secondary_marksheet_path);
		if (!higher_secondary_marksheets_save_dir.exists()) 
        {
            higher_secondary_marksheets_save_dir.mkdirs();
        }

        //Get the Session Data
        HttpSession session = request.getSession(false);
        String applicant_id =(String)session.getAttribute("applicant_id");

		//Get Data from Request and Store them in Local Variables
        String scheme_id = request.getParameter("scheme_id");
        String higher_secondary_board = request.getParameter("higher_secondary_board");
        String higher_secondary_passing_year = request.getParameter("higher_secondary_passing_year");
        String higher_secondary_roll_no = request.getParameter("higher_secondary_roll_no");
        String higher_secondary_total_marks = request.getParameter("higher_secondary_total_marks");
        String higher_secondary_obtained_marks = request.getParameter("higher_secondary_obtained_marks");
        String higher_secondary_percentage = request.getParameter("higher_secondary_percentage");
        String higher_secondary_division = request.getParameter("higher_secondary_division");

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
				String qry = "update students SET higher_secondary_board=?, higher_secondary_passing_year=?, higher_secondary_roll_no=?, higher_secondary_total_marks=?, higher_secondary_obtained_marks=?, higher_secondary_percentage=?, higher_secondary_division=?, higher_secondary_marksheet=? where applicant_id='"+applicant_id+"'";
				
				//Create Prepared Statement using the SQL Query
				PreparedStatement ps = con.prepareStatement(qry);

				//Set Parameters in Prepared Statement
				ps.setString(1,higher_secondary_board);
				ps.setString(2,higher_secondary_passing_year);
				ps.setString(3,higher_secondary_roll_no);
				ps.setString(4,higher_secondary_total_marks);
				ps.setString(5,higher_secondary_obtained_marks);
				ps.setString(6,higher_secondary_percentage);
				ps.setString(7,higher_secondary_division);

				//Get Files Part from Request and Create an Input Stream of the File
		    	InputStream higher_secondary_marksheet_stream = null;
		        Part higher_secondary_marksheet_part = null;
		        //String higher_secondary_marksheet_file_name = "";
		        higher_secondary_marksheet_part = request.getPart("higher_secondary_marksheet");
	    		//higher_secondary_marksheet_file_name = getFileName(higher_secondary_marksheet_part);
	    		higher_secondary_marksheet_stream = higher_secondary_marksheet_part.getInputStream();
	    		InputStream pic_data = higher_secondary_marksheet_stream;
	    		byte[] buffer = new byte[pic_data.available()];
			    pic_data.read(buffer);
			    File new_image = new File(higher_secondary_marksheets_save_dir + File.separator + applicant_id + ".png");
	    		new_image.createNewFile(); 
	    		OutputStream higher_secondary_marksheet_os = new FileOutputStream(higher_secondary_marksheets_save_dir + File.separator  + applicant_id + ".png");
	    		higher_secondary_marksheet_os.write(buffer);
	    		higher_secondary_marksheet_os.close();
	    		higher_secondary_marksheet_stream = higher_secondary_marksheet_part.getInputStream();

	    		int higher_secondary_marksheet_length = higher_secondary_marksheet_stream.available();	
				ps.setBinaryStream(8, higher_secondary_marksheet_stream, higher_secondary_marksheet_length);

				//Execute the SQL Query to Store Data into Database Table
				int i = 0;
				i = ps.executeUpdate();

				//If Data Stored Successfully
				if(i>=1)
				{
					//Create Success Message and Dispatch Response to JSP Page
					request.setAttribute("message", "Student Higher Secondary Data & Marksheet Uploaded Successfully!");
     				getServletContext().getRequestDispatcher("/jsp/main_application_upload_higher_secondary.jsp?scheme_id="+scheme_id).forward(request, response);
				}
				//If Data not Stored Successfully
				else
				{
					//Create Failed Message and Dispatch Response to JSP Page
					request.setAttribute("message", "Student Higher Secondary Data & Marksheet Uploading Failed!");
     				getServletContext().getRequestDispatcher("/jsp/main_application_upload_higher_secondary.jsp?scheme_id="+scheme_id).forward(request, response);
				}
			}
			//If Connection not Successfully Established
			else
			{
				//Create Failed Message and Dispatch Response to JSP Page
				request.setAttribute("message", "Database Connectivity Failed");
     			getServletContext().getRequestDispatcher("/jsp/main_application_upload_higher_secondary.jsp?scheme_id="+scheme_id).forward(request, response);
			}
		}
		catch(SQLException se)
		{
			//Create SQL Exception Message and Dispatch Response to JSP Page
			request.setAttribute("message", "SQL Exception : "+se);
     		getServletContext().getRequestDispatcher("/jsp/main_application_upload_higher_secondary.jsp?scheme_id="+scheme_id).forward(request, response);
		}
		catch(Exception e)
		{
			//Create Other Exception Message and Dispatch Response to JSP Page
			request.setAttribute("message", "Exception : "+e);
     		getServletContext().getRequestDispatcher("/jsp/main_application_upload_higher_secondary.jsp?scheme_id="+scheme_id).forward(request, response);
		}
    }

    //getFileName Method to get file name from HTTP header content-disposition
    /*private String getFileName(Part part) 
    {
        String contentDisp = part.getHeader("content-disposition");
        
        String[] tokens = contentDisp.split(";");
        
        for (String token : tokens) 
        {
            if (token.trim().startsWith("filename")) 
            {
                return token.substring(token.indexOf("=") + 2, token.length()-1);
            }
        }
        return "";
    }*/
}