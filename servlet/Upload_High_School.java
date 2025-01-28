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
@WebServlet("/Upload_High_School")

@MultipartConfig(fileSizeThreshold = 1024*1024*10,		//	10MB
				 maxFileSize = 1024*1024*50,			//	50MB
				 maxRequestSize = 1024*1024*100)		//	100MB

//Class Upload_High_School
public class Upload_High_School extends HttpServlet
{
	//Directory where uploaded files will be saved, its relative to the web application directory.
    private static final String UPLOAD_DIR = "uploads/images/";
    
	//doPost Method
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
    	//Path where Web Application Exists
        String applicationPath = request.getServletContext().getRealPath("");

        //Path where Files will be stored
        String high_school_marksheet_path = applicationPath + File.separator + UPLOAD_DIR + "student_high_school_marksheet/";
         
        //Creates the save directory if it does not exists
        File high_school_marksheets_save_dir = new File(high_school_marksheet_path);
		if (!high_school_marksheets_save_dir.exists()) 
        {
            high_school_marksheets_save_dir.mkdirs();
        }

        //Get the Session Data
        HttpSession session = request.getSession(false);
        String applicant_id =(String)session.getAttribute("applicant_id");

		//Get Data from Request and Store them in Local Variables
        String scheme_id = request.getParameter("scheme_id");
        String high_school_board = request.getParameter("high_school_board");
        String high_school_passing_year = request.getParameter("high_school_passing_year");
        String high_school_roll_no = request.getParameter("high_school_roll_no");
        String high_school_total_marks = request.getParameter("high_school_total_marks");
        String high_school_obtained_marks = request.getParameter("high_school_obtained_marks");
        String high_school_percentage = request.getParameter("high_school_percentage");
        String high_school_division = request.getParameter("high_school_division");

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
				String qry = "update students SET high_school_board=?, high_school_passing_year=?, high_school_roll_no=?, high_school_total_marks=?, high_school_obtained_marks=?, high_school_percentage=?, high_school_division=?, high_school_marksheet=? where applicant_id='"+applicant_id+"'";
				
				//Create Prepared Statement using the SQL Query
				PreparedStatement ps = con.prepareStatement(qry);

				//Set Parameters in Prepared Statement
				ps.setString(1,high_school_board);
				ps.setString(2,high_school_passing_year);
				ps.setString(3,high_school_roll_no);
				ps.setString(4,high_school_total_marks);
				ps.setString(5,high_school_obtained_marks);
				ps.setString(6,high_school_percentage);
				ps.setString(7,high_school_division);

				//Get Files Part from Request and Create an Input Stream of the File
		    	InputStream high_school_marksheet_stream = null;
		        Part high_school_marksheet_part = null;
		        //String high_school_marksheet_file_name = "";
		        high_school_marksheet_part = request.getPart("high_school_marksheet");
	    		//high_school_marksheet_file_name = getFileName(high_school_marksheet_part);
	    		high_school_marksheet_stream = high_school_marksheet_part.getInputStream();
	    		InputStream pic_data = high_school_marksheet_stream;
	    		byte[] buffer = new byte[pic_data.available()];
			    pic_data.read(buffer);
			    File new_image = new File(high_school_marksheets_save_dir + File.separator + applicant_id + ".png");
	    		new_image.createNewFile(); 
	    		OutputStream high_school_marksheet_os = new FileOutputStream(high_school_marksheets_save_dir + File.separator  + applicant_id + ".png");
	    		high_school_marksheet_os.write(buffer);
	    		high_school_marksheet_os.close();
	    		high_school_marksheet_stream = high_school_marksheet_part.getInputStream();

	    		int high_school_marksheet_length = high_school_marksheet_stream.available();	
				ps.setBinaryStream(8, high_school_marksheet_stream, high_school_marksheet_length);

				//Execute the SQL Query to Store Data into Database Table
				int i = 0;
				i = ps.executeUpdate();

				//If Data Stored Successfully
				if(i>=1)
				{
					//Create Success Message and Dispatch Response to JSP Page
					request.setAttribute("message", "Student High School Data & Marksheet Uploaded Successfully!");
     				getServletContext().getRequestDispatcher("/jsp/main_application_upload_high_school.jsp?scheme_id="+scheme_id).forward(request, response);
				}
				//If Data not Stored Successfully
				else
				{
					//Create Failed Message and Dispatch Response to JSP Page
					request.setAttribute("message", "Student High School Data & Marksheet Uploading Failed!");
     				getServletContext().getRequestDispatcher("/jsp/main_application_upload_high_school.jsp?scheme_id="+scheme_id).forward(request, response);
				}
			}
			//If Connection not Successfully Established
			else
			{
				//Create Failed Message and Dispatch Response to JSP Page
				request.setAttribute("message", "Database Connectivity Failed");
     			getServletContext().getRequestDispatcher("/jsp/main_application_upload_high_school.jsp?scheme_id="+scheme_id).forward(request, response);
			}
		}
		catch(SQLException se)
		{
			//Create SQL Exception Message and Dispatch Response to JSP Page
			request.setAttribute("message", "SQL Exception : "+se);
     		getServletContext().getRequestDispatcher("/jsp/main_application_upload_high_school.jsp?scheme_id="+scheme_id).forward(request, response);
		}
		catch(Exception e)
		{
			//Create Other Exception Message and Dispatch Response to JSP Page
			request.setAttribute("message", "Exception : "+e);
     		getServletContext().getRequestDispatcher("/jsp/main_application_upload_high_school.jsp?scheme_id="+scheme_id).forward(request, response);
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