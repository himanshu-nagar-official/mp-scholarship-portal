//Imports
import java.io.File;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import java.io.InputStream;
import java.io.*;
import java.io.FileOutputStream; 
import java.io.OutputStream;
import java.util.Base64;
import java.nio.charset.StandardCharsets;
import java.awt.image.BufferedImage;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.servlet.http.*;

//Define Servlet Component
@WebServlet("/Upload_Sambal_Card")

@MultipartConfig(fileSizeThreshold = 1024*1024*10,		//	10MB
				 maxFileSize = 1024*1024*50,			//	50MB
				 maxRequestSize = 1024*1024*100)		//	100MB

//Class Upload_Sambal_Card
public class Upload_Sambal_Card extends HttpServlet
{
	//Directory where uploaded files will be saved, its relative to the web application directory.
    private static final String UPLOAD_DIR = "uploads/images/";
    
	//doPost Method
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
    	//Path where Web Application Exists
        String applicationPath = request.getServletContext().getRealPath("");

        //Path where Files will be stored
        String sambal_card_path = applicationPath + File.separator + UPLOAD_DIR + "student_sambal_card/";
         
        //Creates the save directory if it does not exists
        File sambal_card_save_dir = new File(sambal_card_path);
		if (!sambal_card_save_dir.exists()) 
        {
            sambal_card_save_dir.mkdirs();
        }

        //Get the Session Data
        HttpSession session = request.getSession(false);
        String applicant_id =(String)session.getAttribute("applicant_id");
		String student_name =(String)session.getAttribute("student_name");

		//Get Data from Request and Store them in Local Variables
        String scheme_id = request.getParameter("scheme_id");
        String sambal_card_number = request.getParameter("sambal_card_number");

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
				String qry = "update students SET sambal_card_number=?, sambal_card=? where applicant_id='"+applicant_id+"'";
				
				//Create Prepared Statement using the SQL Query
				PreparedStatement ps = con.prepareStatement(qry);

				//Set Parameters in Prepared Statement
				ps.setString(1,sambal_card_number);

				//Get Files Part from Request and Create an Input Stream of the File
		    	InputStream sambal_card_stream = null;
		        Part sambal_card_part = null;
		        String sambal_card_file_name = "";
		        sambal_card_part = request.getPart("sambal_card");
	    		sambal_card_file_name = getFileName(sambal_card_part);
	    		sambal_card_stream = sambal_card_part.getInputStream();
	    		InputStream pic_data = sambal_card_stream;
	    		byte[] buffer = new byte[pic_data.available()];
			    pic_data.read(buffer);
			    File new_image = new File(sambal_card_save_dir + File.separator + applicant_id + ".png");
	    		new_image.createNewFile(); 
	    		OutputStream sambal_card_os = new FileOutputStream(sambal_card_save_dir + File.separator  + applicant_id + ".png");
	    		sambal_card_os.write(buffer);
	    		sambal_card_os.close();
	    		sambal_card_stream = sambal_card_part.getInputStream();

	    		int sambal_card_length = sambal_card_stream.available();	
				ps.setBinaryStream(2, sambal_card_stream, sambal_card_length);

				//Execute the SQL Query to Store Data into Database Table
				int i = 0;
				i = ps.executeUpdate();

				//If Data Stored Successfully
				if(i>=1)
				{
					//Create Success Message and Dispatch Response to JSP Page
					request.setAttribute("message", "Student Sambal Card Uploaded Successfully!");
     				getServletContext().getRequestDispatcher("/jsp/main_application_upload_sambal_card.jsp?scheme_id="+scheme_id).forward(request, response);
				}
				//If Data not Stored Successfully
				else
				{
					//Create Failed Message and Dispatch Response to JSP Page
					request.setAttribute("message", "Student Sambal Card Uploading Failed!");
     				getServletContext().getRequestDispatcher("/jsp/main_application_upload_sambal_card.jsp?scheme_id="+scheme_id).forward(request, response);
				}
			}
			//If Connection not Successfully Established
			else
			{
				//Create Failed Message and Dispatch Response to JSP Page
				request.setAttribute("message", "Database Connectivity Failed");
     			getServletContext().getRequestDispatcher("/jsp/main_application_upload_sambal_card.jsp?scheme_id="+scheme_id).forward(request, response);
			}
		}
		catch(SQLException se)
		{
			//Create SQL Exception Message and Dispatch Response to JSP Page
			request.setAttribute("message", "SQL Exception : "+se);
     		getServletContext().getRequestDispatcher("/jsp/main_application_upload_sambal_card.jsp?scheme_id="+scheme_id).forward(request, response);
		}
		catch(Exception e)
		{
			//Create Other Exception Message and Dispatch Response to JSP Page
			request.setAttribute("message", "Exception : "+e);
     		getServletContext().getRequestDispatcher("/jsp/main_application_upload_sambal_card.jsp?scheme_id="+scheme_id).forward(request, response);
		}
    }

    //getFileName Method to get file name from HTTP header content-disposition
    private String getFileName(Part part) 
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
    }
}