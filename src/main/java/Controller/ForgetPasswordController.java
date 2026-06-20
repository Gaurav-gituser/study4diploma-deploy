package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import Dao.UserDao;
import Model.User;

/**
 * Servlet implementation class ForgetPasswordController
 */
@WebServlet("/ForgetPasswordController")
public class ForgetPasswordController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ForgetPasswordController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String but=request.getParameter("btn");
		HttpSession session1=request.getSession();
		 // Send alert + redirect
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
	    if(but.equals("forget")) 
	    {
		String email=request.getParameter("email");
/*		String password=request.getParameter("password");
*/		Random random= new Random ();
		int otp = 100000 + random.nextInt(900000);
		System.out.println("number="+otp);
		
		
		String host = "smtp.gmail.com"; // SMTP server (example: Gmail)
        String from = "bhumikanavale108@gmail.com"; // Your email
        String emailpassword = "teav dycj talq fzwp"; // Your email password
        String to = email; // Recipient's email

        // Set properties for the mail session
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "587");

        // Create a session with the email configuration
        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, emailpassword);
            }
        });

        try {
            // Create the message
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject("otp for forget password");

            // Set the email body text
            message.setText("Hello, otp for forget password is "+otp);

            User user = new User(email, otp);
            // Send the message
            Transport.send(message);
            session1.setAttribute("otp",user);
            out.println("<script type='text/javascript'>");
            out.println("alert('OTP sent successfully!');");
            out.println("window.location.href='./User/verifyOtp.jsp';");
            out.println("</script>");
            
            System.out.println("Email sent successfully!");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
	    }
	
	else if(but.equals("verifyOtp"))
	{
		
		  String enteredOtp = request.getParameter("otp");
	        String serverOtp = request.getParameter("serverotp");
	        String email = request.getParameter("email");

	        int sotp = Integer.parseInt(request.getParameter("serverotp"));
	        System.out.println(enteredOtp+serverOtp+email);
	        
	        if(enteredOtp.equalsIgnoreCase(serverOtp))
	        {
	        	   User verifyuser = new User(email,sotp);
	        	 session1.setAttribute("verifyuser",verifyuser);
	        	 out.println("<script type='text/javascript'>");
	             out.println("window.location.href='./User/updatePassword.jsp';");
	             out.println("</script>");
	        }
		

		}
	    
	else if (but.equals("update")) {

	    String email = request.getParameter("email");
	    String newPass = request.getParameter("newPassword");
	    String confirmPass = request.getParameter("confirmPassword");

	    System.out.println("Updating password for: " + email);

	    if (newPass.equals(confirmPass)) {  // ✅ compare passwords, not email
	        UserDao dao = new UserDao();
	        int result = dao.updatePassword(email, newPass);

	        if (result == 1) {
	            out.println("<script type='text/javascript'>");
	            out.println("alert('Password updated successfully');");
	            out.println("window.location.href='./User/login.jsp';");
	            out.println("</script>");
	        } else {
	            out.println("<script type='text/javascript'>");
	            out.println("alert('Password update failed');");
	            out.println("window.location.href='./User/updatePassword.jsp';");
	            out.println("</script>");
	        }

	    } else {
	        out.println("<script type='text/javascript'>");
	        out.println("alert('Passwords do not match!');");
	        out.println("window.history.back();");
	        out.println("</script>");
	    }
	}

	}

}
