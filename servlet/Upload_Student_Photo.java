//Imports
import java.sql.*;
import java.io.*;
import java.util.Base64;
import java.nio.charset.StandardCharsets;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.utils.db.DBConnection;

//Define Servlet Component
@WebServlet("/Upload_Student_Photo")


@MultipartConfig(fileSizeThreshold = 1024*1024*10,		//	10MB
				 maxFileSize = 1024*1024*50,			//	50MB
				 maxRequestSize = 1024*1024*100)		//	100MB

//Class Upload_Student_Photo
public class Upload_Student_Photo extends HttpServlet
{
	//Directory where uploaded files will be saved, its relative to the web application directory.
    private static final String UPLOAD_DIR = "uploads/images/";
    
    //doPost Method
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        //Path where Web Application Exists
        String applicationPath = request.getServletContext().getRealPath("");

        //Path where Files will be stored
        String photos_path = applicationPath + File.separator + UPLOAD_DIR + "student_photos/";
         
        //Creates the save directory if it does not exists
        File photos_save_dir = new File(photos_path);
		if (!photos_save_dir.exists()) 
        {
            photos_save_dir.mkdirs();
        }

        //Get the Session Data
        HttpSession session = request.getSession(false);
        String applicant_id =(String)session.getAttribute("applicant_id");

		//Get Data from Request and Store them in Local Variables
		String scheme_id = request.getParameter("scheme_id");

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
				String qry = "update students SET student_photo=? where applicant_id='"+applicant_id+"'";

				//Create Prepared Statement using the SQL Query
				PreparedStatement ps = con.prepareStatement(qry);

				//Get Files Part from Request and Create an Input Stream of the File
		    	InputStream photo_stream = null;
		        Part photo_part = null;
		        //String photo_file_name = "";
		        String captured_pic = request.getParameter("captured");
		        if(captured_pic.equals(""))
		        {
		    		photo_part = request.getPart("photo");
		    		//photo_file_name = getFileName(photo_part);
		    		photo_stream = photo_part.getInputStream();
		    		InputStream pic_data = photo_stream;
		    		byte[] buffer = new byte[pic_data.available()];
				    pic_data.read(buffer);
				    File new_image = new File(photos_save_dir + File.separator + applicant_id + ".png");
		    		new_image.createNewFile(); 
		    		OutputStream photo_os = new FileOutputStream(photos_save_dir + File.separator  + applicant_id + ".png");
		    		photo_os.write(buffer);
		    		photo_os.close();
		    		photo_stream = photo_part.getInputStream();
		    	}
		    	else
		    	{
		    		String pic = captured_pic.substring(captured_pic.indexOf(",") + 1);
		    		byte[] pic_data = Base64.getDecoder().decode(pic.getBytes(StandardCharsets.UTF_8));
		    		File new_image = new File(photos_save_dir + File.separator + applicant_id + ".png");
		    		new_image.createNewFile(); 
		    		OutputStream photo_os = new FileOutputStream(photos_save_dir + File.separator  + applicant_id + ".png");
		    		photo_stream = new ByteArrayInputStream(pic_data);
		    		photo_os.write(pic_data);
		    		photo_os.close();
		    	}
				int photo_length = photo_stream.available();	
				ps.setBinaryStream(1, photo_stream, photo_length);

				//Execute the SQL Query to Store Data into Database Table
				int i = 0;
				i = ps.executeUpdate();

				//If Data Stored Successfully
				if(i>=1)
				{
					//Create Success Message and Dispatch Response to JSP Page
					request.setAttribute("message", "Student Photo Uploaded Successfully!");
     				getServletContext().getRequestDispatcher("/jsp/main_application_upload_student_photo.jsp?scheme_id="+scheme_id).forward(request, response);
				}
				//If Data not Stored Successfully
				else
				{
					//Create Failed Message and Dispatch Response to JSP Page
					request.setAttribute("message", "Student Photo Uploading Failed!");
     				getServletContext().getRequestDispatcher("/jsp/main_application_upload_student_photo.jsp?scheme_id="+scheme_id).forward(request, response);
				}	
			}
			//If Connection not Successfully Established
			else
			{
				//Create Failed Message and Dispatch Response to JSP Page
				request.setAttribute("message", "Database Connectivity Failed");
     			getServletContext().getRequestDispatcher("/jsp/main_application_upload_student_photo.jsp?scheme_id="+scheme_id).forward(request, response);
			}
		}
		catch(SQLException se)
		{
			//Create SQL Exception Message and Dispatch Response to JSP Page
			request.setAttribute("message", "SQL Exception : "+se);
     		getServletContext().getRequestDispatcher("/jsp/main_application_upload_student_photo.jsp?scheme_id="+scheme_id).forward(request, response);
		}
		catch(Exception e)
		{
			//Create Other Exception Message and Dispatch Response to JSP Page
			request.setAttribute("message", "Exception : "+e);
     		getServletContext().getRequestDispatcher("/jsp/main_application_upload_student_photo.jsp?scheme_id="+scheme_id).forward(request, response);
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