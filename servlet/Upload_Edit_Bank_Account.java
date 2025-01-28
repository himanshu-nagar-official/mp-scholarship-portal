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
@WebServlet("/Upload_Edit_Bank_Account")

@MultipartConfig(fileSizeThreshold = 1024*1024*10,		//	10MB
				 maxFileSize = 1024*1024*50,			//	50MB
				 maxRequestSize = 1024*1024*100)		//	100MB

//Class Upload_Edit_Bank_Account
public class Upload_Edit_Bank_Account extends HttpServlet
{
	//Directory where uploaded files will be saved, its relative to the web application directory.
    private static final String UPLOAD_DIR = "uploads/images/";
    
	//doPost Method
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
    	//Path where Web Application Exists
        String applicationPath = request.getServletContext().getRealPath("");

        //Path where Files will be stored
        String bank_passbook_path = applicationPath + File.separator + UPLOAD_DIR + "student_bank_passbook/";
         
        //Creates the save directory if it does not exists
        File bank_passbook_save_dir = new File(bank_passbook_path);
		if (!bank_passbook_save_dir.exists()) 
        {
            bank_passbook_save_dir.mkdirs();
        }

        //Get the Session Data
        HttpSession session = request.getSession(false);
        String applicant_id =(String)session.getAttribute("applicant_id");

		//Get Data from Request and Store them in Local Variables
        String scheme_id = request.getParameter("scheme_id");
        String bank_name = request.getParameter("bank_name");
        String branch = request.getParameter("branch");
        String ifsc_code = request.getParameter("ifsc_code");
        String account_number = request.getParameter("account_number");

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
				String qry = "update students SET bank_name=?, branch=?, ifsc_code=?, account_number=?, bank_passbook=? where applicant_id='"+applicant_id+"'";
				
				//Create Prepared Statement using the SQL Query
				PreparedStatement ps = con.prepareStatement(qry);

				//Set Parameters in Prepared Statement
				ps.setString(1,bank_name);
				ps.setString(2,branch);
				ps.setString(3,ifsc_code);
				ps.setString(4,account_number);

				//Get Files Part from Request and Create an Input Stream of the File
		    	InputStream bank_passbook_stream = null;
		        Part bank_passbook_part = null;
		        //String bank_passbook_file_name = "";
		        bank_passbook_part = request.getPart("bank_passbook");
	    		//bank_passbook_file_name = getFileName(bank_passbook_part);
	    		bank_passbook_stream = bank_passbook_part.getInputStream();
	    		InputStream pic_data = bank_passbook_stream;
	    		byte[] buffer = new byte[pic_data.available()];
			    pic_data.read(buffer);
			    File new_image = new File(bank_passbook_save_dir + File.separator + applicant_id + ".png");
	    		new_image.createNewFile(); 
	    		OutputStream bank_passbook_os = new FileOutputStream(bank_passbook_save_dir + File.separator  + applicant_id + ".png");
	    		bank_passbook_os.write(buffer);
	    		bank_passbook_os.close();
	    		bank_passbook_stream = bank_passbook_part.getInputStream();

	    		int bank_passbook_length = bank_passbook_stream.available();	
				ps.setBinaryStream(5, bank_passbook_stream, bank_passbook_length);

				//Execute the SQL Query to Store Data into Database Table
				int i = 0;
				i = ps.executeUpdate();

				//If Data Stored Successfully
				if(i>=1)
				{
					//Create Success Message and Dispatch Response to JSP Page
					request.setAttribute("message", "Student Bank Account Details & Passbook Uploaded Successfully!");
     				getServletContext().getRequestDispatcher("/jsp/main_application_edit_bank_account.jsp?scheme_id="+scheme_id).forward(request, response);
				}
				//If Data not Stored Successfully
				else
				{
					//Create Failed Message and Dispatch Response to JSP Page
					request.setAttribute("message", "Student Bank Account Details & Passbook Uploading Failed!");
     				getServletContext().getRequestDispatcher("/jsp/main_application_edit_bank_account.jsp?scheme_id="+scheme_id).forward(request, response);
				}
			}
			//If Connection not Successfully Established
			else
			{
				//Create Failed Message and Dispatch Response to JSP Page
				request.setAttribute("message", "Database Connectivity Failed");
     			getServletContext().getRequestDispatcher("/jsp/main_application_edit_bank_account.jsp?scheme_id="+scheme_id).forward(request, response);
			}
		}
		catch(SQLException se)
		{
			//Create SQL Exception Message and Dispatch Response to JSP Page
			request.setAttribute("message", "SQL Exception : "+se);
     		getServletContext().getRequestDispatcher("/jsp/main_application_edit_bank_account.jsp?scheme_id="+scheme_id).forward(request, response);
		}
		catch(Exception e)
		{
			//Create Other Exception Message and Dispatch Response to JSP Page
			request.setAttribute("message", "Exception : "+e);
     		getServletContext().getRequestDispatcher("/jsp/main_application_edit_bank_account.jsp?scheme_id="+scheme_id).forward(request, response);
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