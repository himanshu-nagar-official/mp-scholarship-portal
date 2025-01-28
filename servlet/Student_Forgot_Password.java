//Imports
import java.sql.*;
import java.util.*;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.Transport;
import com.utils.db.DBConnection;

//Define Servlet Component
@WebServlet("/Student_Forgot_Password")

//Class Student_Forgot_Password
public class Student_Forgot_Password extends HttpServlet
{
	//doPost Method
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
    	//Check if Request for New Password Creation
    	if(request.getParameter("student_password")!=null)
    	{
    		//Get Data from Request and Store them in Local Variables
    		String student_password = request.getParameter("student_password");
    		String student_confirm_password = request.getParameter("student_confirm_password");
    		String hash_key = request.getParameter("hash_key");

    		//Create Connection Object
			Connection con = null;

			//Create Boolean Type Local Variables to check if Hash Key is Valid
			boolean hash_key_matched = false;

			try
			{
				//Try to open Database Connection
				con = DBConnection.getConnection();

				//If Connection Successfully Established
				if(con != null && !con.isClosed())
				{
					//Create Select Query for getting data from forgot_password table where hash_key matches & Execute it
					String qry = "select * from forgot_password where hash_key='"+hash_key+"'";
					PreparedStatement ps = con.prepareStatement(qry);
					ResultSet rs = ps.executeQuery();

					//Check if Hash Key Matches
					hash_key_matched = rs.next();

					//If Hash Key is Valid
					if(hash_key_matched)
					{
						//If Student Password & Confirm Password Matches
						if(student_password.equals(student_confirm_password))
			    		{
			    			//Store Student Aadhaar & Email in Local Variables from Result Set
			    			String student_aadhaar = rs.getString("student_aadhaar");
			    			String student_email = rs.getString("student_email");

			    			//Create Update Query for changing password of student & Execute it
							qry = "update students SET student_password='"+student_password+"' where student_aadhaar='"+student_aadhaar+"' and student_email='"+student_email+"'";
							ps = con.prepareStatement(qry);
							int i = ps.executeUpdate();

							//If Password Updated Successfully
							if(i>=1)
							{
								//Create Delete query to delete Pasrticular hash_key row from forgot_password table & Execute it
								qry = "delete from forgot_password where hash_key='"+hash_key+"'";
						    	ps = con.prepareStatement(qry);
						    	ps.executeUpdate();

						    	//Create Select query to get all data from forgot_password table where student_aadhaar & student_email is matching & Execute it
								qry = "select * from students where student_aadhaar='"+student_aadhaar+"' and student_email='"+student_email+"'";
								ps = con.prepareStatement(qry);
								rs = ps.executeQuery();

								//If got the Student Data
								if(rs.next()!=false)
								{
									//Store Applicant Id, Password & Name into Local Variables
									String applicant_id = rs.getString("applicant_id");
									student_password = rs.getString("student_password");
									String student_name = rs.getString("student_name");

									//Close Database Connectivity & Redirect Student Data & Success Message to JSP Page
									con.close();
									request.setAttribute("message", "Password Reset Successfully!");
									request.setAttribute("applicant_id", applicant_id);
									request.setAttribute("student_password", student_password);
									request.setAttribute("student_name", student_name);
									getServletContext().getRequestDispatcher("/jsp/registration_successfull.jsp").forward(request, response);
								}
							}

							//If Password Reset Failed
							else
							{
								//Close Database Connectivity & Redirect Failed Message to JSP Page
								con.close();
								request.setAttribute("message", "Password Reset Failed");
			     				getServletContext().getRequestDispatcher("/jsp/sforgot_password.jsp").forward(request, response);
							}
			    		}
			    		//If Student Password & Confirm Password does not Matches
			    		else
			    		{
			    			//Close Database Connectivity & Redirect Failed Message to JSP Page
			    			con.close();
			    			request.setAttribute("hash_key", hash_key); 
							request.setAttribute("message", "Password & Confirm Password are not matching");
			     			getServletContext().getRequestDispatcher("/jsp/screate_np_fp.jsp").forward(request, response);
			    		}
					}

					//If Hash Key is Invalid
					else
					{
						//Close Database Connectivity & Redirect Failed Message to JSP Page
						con.close();
						request.setAttribute("message", "Insecure Access Denied");
		     			getServletContext().getRequestDispatcher("/jsp/sforgot_password.jsp").forward(request, response);	
					}
				}

				//If Connection not Successfully Established
				else
				{
					//Create Failed Message and Dispatch Response to JSP Page
					request.setAttribute("message", "Database Connectivity Failed");
	     			getServletContext().getRequestDispatcher("/jsp/sforgot_password.jsp").forward(request, response);
				}	
			}
			catch(SQLException se)
			{
				//Create SQL Exception Message and Dispatch Response to JSP Page
				request.setAttribute("message", "SQL Exception : "+se);
	     		getServletContext().getRequestDispatcher("/jsp/sforgot_password.jsp").forward(request, response);
			}
			catch(Exception e)
			{
				//Create Other Exception Message and Dispatch Response to JSP Page
				request.setAttribute("message", "Exception : "+e);
	     		getServletContext().getRequestDispatcher("/jsp/sforgot_password.jsp").forward(request, response);
			}
    	}

    	//Check if Request for OTP Verification
    	else if(request.getParameter("otp")!=null)
    	{
    		//Get Data from Request and Store them in Local Variables
    		String user_entered_otp = request.getParameter("otp");
    		String hash_key = request.getParameter("hash_key");

    		//Create Connection Object
			Connection con = null;

			//Create Boolean Type Local Variables to check if Hash Key is Valid
			boolean hash_key_matched = false;

			try
			{
				//Try to open Database Connection
				con = DBConnection.getConnection();

				//If Connection Successfully Established
				if(con != null && !con.isClosed())
				{
					//Create Select Query for getting data from forgot_password table where hash_key matches & Execute it
					String qry = "select * from forgot_password where hash_key='"+hash_key+"'";
					PreparedStatement ps = con.prepareStatement(qry);
					ResultSet rs = ps.executeQuery();

					//Check if Hash Key Matches
					hash_key_matched = rs.next();

					//If Hash Key is Valid
					if(hash_key_matched)
					{
						//Create Date Object & Get Current Time in Milliseconds
						Date date = new Date();
					    long current_time = date.getTime();

					    //Get OTP, Chances & Expiration Time Available in Database
						String otp = rs.getString("otp");
						short chances = rs.getShort("chances");
					    Long expiration_time = Long.parseLong(rs.getString("expiration_time"));

					    //If OTP is not Expired
					    if(current_time<expiration_time)
					    {
					    	//If Chances are still available
					    	if(chances>0)
					    	{
					    		//Create New Chances Local Variable
					    		int new_chances = chances-1;

					    		//Create Update Query for updating chances in forgot_password table where hash_key matches & Execute it
					    		qry = "update forgot_password SET chances='"+new_chances+"' where hash_key='"+hash_key+"'";
								ps = con.prepareStatement(qry);
								ps.executeUpdate();

								//If OTP Successfully Matched
					    		if(user_entered_otp.equals(otp))
								{
									//Close Database Connectivity & Redirect Success Message to JSP Page
									con.close();
									request.setAttribute("hash_key", hash_key); 
									request.setAttribute("message", "OTP Verified Successfully, Please Change Your Password");
					     			getServletContext().getRequestDispatcher("/jsp/screate_np_fp.jsp").forward(request, response);
								}	

								//If OTP does not Match
								else
								{
									//Check if No Chances Are Available
									if(new_chances==0)
									{
										//Create Delete Query for deleting row in forgot_password table where hash_key matches & Execute it
										qry = "delete from forgot_password where hash_key='"+hash_key+"'";
								    	ps = con.prepareStatement(qry);
								    	ps.executeUpdate();

								    	//Close Database Connectivity & Redirect OTP Verification Attempts Exceeded! Message to JSP Page
								    	con.close();
								    	request.setAttribute("message", "OTP Verification Attempts Exceeded! Please Try Again");
						     			getServletContext().getRequestDispatcher("/jsp/sforgot_password.jsp").forward(request, response);
									}

									//Check if Chances are Available
									else
									{
										//Close Database Connectivity & Redirect Invalid OTP Entered! Message to JSP Page
										con.close();
										request.setAttribute("message", "Invalid OTP Entered! Please Try Again, You Have "+new_chances+" Attempts Left");
						     			request.setAttribute("hash_key", hash_key);
						     			getServletContext().getRequestDispatcher("/jsp/sverify_otp_fp.jsp").forward(request, response);
									}
								}
					    	}

					    	//If Chances are not available
					    	else
					    	{
					    		//Create Delete Query for deleting row in forgot_password table where hash_key matches & Execute it
					    		qry = "delete from forgot_password where hash_key='"+hash_key+"'";
						    	ps = con.prepareStatement(qry);
						    	ps.executeUpdate();

						    	//Close Database Connectivity & Redirect OTP Verification Attempts Exceeded! Message to JSP Page
						    	con.close();
						    	request.setAttribute("message", "OTP Verification Attempts Exceeded! Please Try Again");
				     			getServletContext().getRequestDispatcher("/jsp/sforgot_password.jsp").forward(request, response);		
					    	}
					    }

					    ////If OTP is Expired
					    else
					    {
					    	//Create Delete Query for deleting row in forgot_password table where hash_key matches & Execute it
					    	qry = "delete from forgot_password where hash_key='"+hash_key+"'";
					    	ps = con.prepareStatement(qry);
					    	ps.executeUpdate();

					    	//Close Database Connectivity & Redirect OTP Expired! Message to JSP Page
					    	con.close();
					    	request.setAttribute("message", "OTP Expired! Please Try Again");
			     			getServletContext().getRequestDispatcher("/jsp/sforgot_password.jsp").forward(request, response);
					    }
					}

					//If Hash Key is Invalid
					else
					{
						//Close Database Connectivity & Redirect Insecure Access Denied Message to JSP Page
						con.close();
						request.setAttribute("message", "Insecure Access Denied");
		     			getServletContext().getRequestDispatcher("/jsp/sforgot_password.jsp").forward(request, response);
					}	
				}

				//If Connection not Successfully Established
				else
				{
					//Create Failed Message and Dispatch Response to JSP Page
					request.setAttribute("message", "Database Connectivity Failed");
	     			getServletContext().getRequestDispatcher("/jsp/sforgot_password.jsp").forward(request, response);
				}
			}
			catch(SQLException se)
			{
				//Create SQL Exception Message and Dispatch Response to JSP Page
				request.setAttribute("message", "SQL Exception : "+se);
	     		getServletContext().getRequestDispatcher("/jsp/sforgot_password.jsp").forward(request, response);
			}
			catch(Exception e)
			{
				//Create Other Exception Message and Dispatch Response to JSP Page
				request.setAttribute("message", "Exception : "+e);
	     		getServletContext().getRequestDispatcher("/jsp/sforgot_password.jsp").forward(request, response);
			}
    	}

    	//Check if Request for Send OTP
    	else
    	{
    		//Get Data from Request and Store them in Local Variables
    		String student_email = request.getParameter("student_email");
			String student_aadhaar = request.getParameter("student_aadhaar");

			//Create Boolean Type Local Variables to check if Applicant is Trustworthy
			boolean applicant_is_trustworthy = false;
	        
	        //Create Connection Object
			Connection con = null;

			try
			{
				//Try to open Database Connection
				con = DBConnection.getConnection();

				//If Connection Successfully Established
				if(con != null && !con.isClosed())
				{
					//Create Select Query for getting data from students table where student_email & student_aadhaar matches with user input & Execute it
					String qry = "select * from students where student_email='"+student_email+"' and student_aadhaar='"+student_aadhaar+"'";
					PreparedStatement ps = con.prepareStatement(qry);
					ResultSet rs = ps.executeQuery();

					//Create OTP, Student Name, Expiration Time & Hash Key Local Variables
					String otp = "";
					String student_name = "";
					String expiration_time = "";
					String hash_key = "";

					//Check if Applicant is Trustworthy
					applicant_is_trustworthy = rs.next();

					//If Applicant is Trustworthy
					if(applicant_is_trustworthy)
					{
						//Store Student Name into Local Variable
						student_name = rs.getString("student_name");

						//Generate 6 Digit OTP & Store it in Local Variable
						otp = String.valueOf(generate_otp());

						//Generate Expiration Time & Store it in Local Variable
						expiration_time = expiration_time_generator();

						//Create Delete Query for deleting row in forgot_password table where otp is expired & Execute it
						qry = "delete from forgot_password where expiration_time>'"+expiration_time+"'";
				    	ps = con.prepareStatement(qry);
				    	ps.executeUpdate();

				    	//Generate Hash Key & Store it in Local Variable
						hash_key = String.valueOf(generate_hash_key());

						//Create OTP Email Subject
						String subject = "OTP for Forgot Password";
						
						//Create Email Status Local Variable & Pass Parameters to Send Email Function
						String happened = sendMail(student_email, subject, otp, student_name);

						//If Mail Sent Successfully
						if(happened.equals("A 6 digit One-Time-Password(OTP) is sent to your registered email id."))
						{
							//Create Insert Query to Insert Data into forgot_password Table & Execute It
							qry = "insert into forgot_password (otp,student_email,student_aadhaar,expiration_time,chances,hash_key) values(?,?,?,?,?,?)";
							ps = con.prepareStatement(qry);
							ps.setString(1,otp);
							ps.setString(2,student_email);
							ps.setString(3,student_aadhaar);
							ps.setString(4,expiration_time);
							ps.setInt(5,3);
							ps.setString(6,hash_key);
							int i = 0;
							i = ps.executeUpdate();

							//If Data Stored Successfully
							if(i>=1)
							{
								//Close Database Connectivity & Redirect Success Message to JSP Page
								con.close();
								request.setAttribute("message", happened);
								request.setAttribute("hash_key", hash_key);
								getServletContext().getRequestDispatcher("/jsp/sverify_otp_fp.jsp").forward(request, response);
							}

							//If Data Not Stored Successfully
							else
							{
								//Close Database Connectivity & Redirect Failed Message to JSP Page
								con.close();
								request.setAttribute("message", "OTP Processing Failed");
			     				getServletContext().getRequestDispatcher("/jsp/sforgot_password.jsp").forward(request, response);
							}
						}

						//If Mail does not Sent Successfully
						else
						{
							//Close Database Connectivity & Redirect Failed Message to JSP Page
							con.close();
							request.setAttribute("message", happened);
							getServletContext().getRequestDispatcher("/jsp/sforgot_password.jsp").forward(request, response);
						}
					}

					//If Applicant is not Trustworthy
					else
					{
						//Close Database Connectivity & Redirect Failed Message to JSP Page
						con.close();
						request.setAttribute("message", "Wrong Email Id or Aadhaar Number");
						getServletContext().getRequestDispatcher("/jsp/sforgot_password.jsp").forward(request, response);
					}
				}

				//If Connection not Successfully Established
				else
				{
					//Create Failed Message and Dispatch Response to JSP Page
					request.setAttribute("message", "Database Connectivity Failed");
	     			getServletContext().getRequestDispatcher("/jsp/sforgot_password.jsp").forward(request, response);
				}
			}
			catch(SQLException se)
			{
				//Create SQL Exception Message and Dispatch Response to JSP Page
				request.setAttribute("message", "SQL Exception : "+se);
	     		getServletContext().getRequestDispatcher("/jsp/sforgot_password.jsp").forward(request, response);
			}
			catch(Exception e)
			{
				//Create Other Exception Message and Dispatch Response to JSP Page
				request.setAttribute("message", "Exception : "+e);
	     		getServletContext().getRequestDispatcher("/jsp/sforgot_password.jsp").forward(request, response);
			}
    	}
    }

    //6 Digit OTP Generator Method
    private static char[] generate_otp()
    {
    	int length = 6;
    	short i;
        String numbers = "123456789";
        Random random = new Random();
        char[] otp = new char[length];
  
        for(i=0;i<length;i++)
        {
            otp[i] = numbers.charAt(random.nextInt(numbers.length()));
            numbers += "0";
        }
        return otp;
    }

    //20 Characters Hash Key Generator Method
    private static char[] generate_hash_key()
    {
    	int length = 20;
    	short i;
        String random_char = "!@#$%^&*()abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
        Random random = new Random();
        char[] hash_key = new char[length];
  
        for(i=0;i<length;i++)
        {
            hash_key[i] = random_char.charAt(random.nextInt(random_char.length()));
        }
        return hash_key;
    }

    //Send Mail Method
    public static String sendMail(String student_email, String subject, String otp, String student_name)
	{
		Properties properties = new Properties();

		properties.put("mail.smtp.auth","true");
		properties.put("mail.smtp.starttls.enable","true");
		properties.put("mail.smtp.host","smtp.gmail.com");
		properties.put("mail.smtp.port","587");

		String myAccountEmail = "madhyapradeshscholarshipportal@gmail.com";
		String password = "olvg mkgq fzwi bqeo";

		Session session = Session.getInstance(properties, new Authenticator(){
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(myAccountEmail, password);
			}
		});

		Message message = prepareMessage(session, myAccountEmail, student_email, subject, otp, student_name); 

		try
		{
			if(message==null)
			{
				return "Error While Sending OTP";
			}
			Transport.send(message);
			return "A 6 digit One-Time-Password(OTP) is sent to your registered email id.";
		}
		catch(Exception ex)
		{
			return "Error While Sending OTP : "+ex;
		}
	}

	//Prepare Message Method
	private static Message prepareMessage(Session session, String myAccountEmail, String student_email, String subject, String otp, String student_name)
	{
		try
		{
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(myAccountEmail));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(student_email));
			message.setSubject(subject);
			String msg = "<h4>Dear "+student_name+"</h4><br>";
			msg += "<p> Forgot Password - Madhya Pradesh Scholarship Portal.</p>";
			msg += "<table cellspacing='0' cellpadding='0' style='width:100%'><tbody><tr>";
     		msg += "<td style='text-align:left;border:1px solid #ccc;padding:5px 10px;margin:0px;width:50%'>Your 6 Digit OTP for verification is: </td>";
            msg += "<td style='text-align:left;border:1px solid #ccc;padding:5px 10px;margin:0px;width:50%'><strong>"+otp+"</strong></td></tr></tbody></table><br>";
            msg += "<h4>Instructions: </h4>";
            msg += "<p>1. Please Enter Your 6 Digit OTP to create new Password.</p>";
            msg += "<p>2. OTP is valid for 10 minutes only.</p><br>";
            msg += "<p>With Regards</p>";
            msg += "<p>Madhya Pradesh Scholarship Portal Team</p>";
            msg += "<figure style='margin:0'>";
            msg += "<img src='mediafire.com/convkey/7af5/qe6h1yzalhf5ltuzg.jpg' alt='Madhya Pradesh Scholarship Portal'>"; 
        	msg += "</figure>";
			message.setContent(msg, "text/html");
			return message;
		}
		catch(Exception ex)
		{
			return null;
		}
	}

	//Expiration Time Generator Method
	public static String expiration_time_generator()
	{
		Date date = new Date();
	    long timeMilli = date.getTime();
	    long timeMilli10 = timeMilli + 600000;
	    String expiration_time = String.valueOf(timeMilli10);
	    return expiration_time;
	}
}