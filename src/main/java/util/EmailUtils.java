package util;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.*;



public class EmailUtils {
	public static void send(String to, String sub, String msg, final String user, final String pass) 
			throws Exception {
		Properties prop = new Properties();
		
		prop.put("mail.smtp.host", "smtp.gmail.com");
		prop.put("mail.smtp.port", "587");
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.starttls.enable", "true");
		
		Session session = Session.getInstance(prop, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, pass);
			}
		});
		try {
			Message message = new MimeMessage(session);
			
			message.setFrom(new InternetAddress(user));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
			message.setSubject(sub);
			message.setContent(msg, "text/html; charset=utf-8"); 
			
			Transport.send(message);
			
			
		} catch (Exception e) {
			e.printStackTrace();			
			throw e;
		}
	}
}