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
@WebServlet("/Upload_IC_FR_LM")

@MultipartConfig(fileSizeThreshold = 1024*1024*10,		//	10MB
				 maxFileSize = 1024*1024*50,			//	50MB
				 maxRequestSize = 1024*1024*100)		//	100MB

//Class Upload_IC_FR_LM
public class Upload_IC_FR_LM extends HttpServlet
{
	//Directory where uploaded files will be saved, its relative to the web application directory.
    private static final String UPLOAD_DIR = "uploads/images/";
    
	//doPost Method
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
    	//Path where Web Application Exists
        String applicationPath = request.getServletContext().getRealPath("");

        //Path where Files will be stored
        String income_certificate_path = applicationPath + File.separator + UPLOAD_DIR + "student_income_certificate/";
        String last_marksheet_path = applicationPath + File.separator + UPLOAD_DIR + "student_last_marksheet/";
        String fees_receipt_path = applicationPath + File.separator + UPLOAD_DIR + "student_fees_receipt/";
         
        //Creates the save directory if it does not exists
        File income_certificate_save_dir = new File(income_certificate_path);
        File last_marksheet_save_dir = new File(last_marksheet_path);
        File fees_receipt_save_dir = new File(fees_receipt_path);
		if (!income_certificate_save_dir.exists()) 
        {
            income_certificate_save_dir.mkdirs();
        }
        if (!last_marksheet_save_dir.exists()) 
        {
            last_marksheet_save_dir.mkdirs();
        }
        if (!fees_receipt_save_dir.exists()) 
        {
            fees_receipt_save_dir.mkdirs();
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
				String qry = "update students SET income_certificate=?, last_marksheet=?, fees_receipt=? where applicant_id='"+applicant_id+"'";
				
				//Create Prepared Statement using the SQL Query
				PreparedStatement ps = con.prepareStatement(qry);

				//Get Files Part from Request and Create an Input Stream of the File
		    	InputStream income_certificate_stream = null;
		    	InputStream last_marksheet_stream = null;
		    	InputStream fees_receipt_stream = null;
		        
				Part income_certificate_part = null;
				Part last_marksheet_part = null;
				Part fees_receipt_part = null;

		        //String income_certificate_file_name = "";
		        //String last_marksheet_file_name = "";
		        //String fees_receipt_file_name = "";

		        income_certificate_part = request.getPart("income_certificate");
		        last_marksheet_part = request.getPart("last_marksheet");
		        fees_receipt_part = request.getPart("fees_receipt");

	    		//income_certificate_file_name = getFileName(income_certificate_part);
	    		//last_marksheet_file_name = getFileName(last_marksheet_part);
	    		//fees_receipt_file_name = getFileName(fees_receipt_part);

	    		income_certificate_stream = income_certificate_part.getInputStream();
	    		last_marksheet_stream = last_marksheet_part.getInputStream();
	    		fees_receipt_stream = fees_receipt_part.getInputStream();

	    		InputStream income_certificate_data = income_certificate_stream;
	    		InputStream last_marksheet_data = last_marksheet_stream;
	    		InputStream fees_receipt_data = fees_receipt_stream;

	    		byte[] income_certificate_buffer = new byte[income_certificate_data.available()];
	    		byte[] last_marksheet_buffer = new byte[last_marksheet_data.available()];
	    		byte[] fees_receipt_buffer = new byte[fees_receipt_data.available()];

			    income_certificate_data.read(income_certificate_buffer);
			    last_marksheet_data.read(last_marksheet_buffer);
			    fees_receipt_data.read(fees_receipt_buffer);

			    File income_certificate_image = new File(income_certificate_save_dir + File.separator + applicant_id + ".png");
			    File last_marksheet_image = new File(last_marksheet_save_dir + File.separator + applicant_id + ".png");
			    File fees_receipt_image = new File(fees_receipt_save_dir + File.separator + applicant_id + ".png");

	    		income_certificate_image.createNewFile();
	    		last_marksheet_image.createNewFile();
	    		fees_receipt_image.createNewFile();

	    		OutputStream income_certificate_os = new FileOutputStream(income_certificate_save_dir + File.separator  + applicant_id + ".png");
	    		OutputStream last_marksheet_os = new FileOutputStream(last_marksheet_save_dir + File.separator  + applicant_id + ".png");
	    		OutputStream fees_receipt_os = new FileOutputStream(fees_receipt_save_dir + File.separator  + applicant_id + ".png");
	    		
	    		income_certificate_os.write(income_certificate_buffer);
	    		last_marksheet_os.write(last_marksheet_buffer);
	    		fees_receipt_os.write(fees_receipt_buffer);

	    		income_certificate_os.close();
	    		last_marksheet_os.close();
	    		fees_receipt_os.close();

	    		income_certificate_stream = income_certificate_part.getInputStream();
	    		last_marksheet_stream = last_marksheet_part.getInputStream();
	    		fees_receipt_stream = fees_receipt_part.getInputStream();

	    		int income_certificate_length = income_certificate_stream.available();	
				ps.setBinaryStream(1, income_certificate_stream, income_certificate_length);
				
				int last_marksheet_length = last_marksheet_stream.available();	
				ps.setBinaryStream(2, last_marksheet_stream, last_marksheet_length);
				
				int fees_receipt_length = fees_receipt_stream.available();	
				ps.setBinaryStream(3, fees_receipt_stream, fees_receipt_length);

				//Execute the SQL Query to Store Data into Database Table
				int i = 0;
				i = ps.executeUpdate();

				//If Data Stored Successfully
				if(i>=1)
				{
					//Create Success Message and Dispatch Response to JSP Page
					request.setAttribute("message", "Student Income Certificate, Last Marksheet & Fees Receipt Uploaded Successfully!");
     				getServletContext().getRequestDispatcher("/jsp/main_application_upload_ic_fr_lm.jsp?scheme_id="+scheme_id).forward(request, response);
				}
				//If Data not Stored Successfully
				else
				{
					//Create Failed Message and Dispatch Response to JSP Page
					request.setAttribute("message", "Student Income Certificate, Last Marksheet & Fees Receipt Uploading Failed!");
     				getServletContext().getRequestDispatcher("/jsp/main_application_upload_ic_fr_lm.jsp?scheme_id="+scheme_id).forward(request, response);
				}
			}
			//If Connection not Successfully Established
			else
			{
				//Create Failed Message and Dispatch Response to JSP Page
				request.setAttribute("message", "Database Connectivity Failed");
     			getServletContext().getRequestDispatcher("/jsp/main_application_upload_ic_fr_lm.jsp?scheme_id="+scheme_id).forward(request, response);
			}
		}
		catch(SQLException se)
		{
			//Create SQL Exception Message and Dispatch Response to JSP Page
			request.setAttribute("message", "SQL Exception : "+se);
     		getServletContext().getRequestDispatcher("/jsp/main_application_upload_ic_fr_lm.jsp?scheme_id="+scheme_id).forward(request, response);
		}
		catch(Exception e)
		{
			//Create Other Exception Message and Dispatch Response to JSP Page
			request.setAttribute("message", "Exception : "+e);
     		getServletContext().getRequestDispatcher("/jsp/main_application_upload_ic_fr_lm.jsp?scheme_id="+scheme_id).forward(request, response);
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