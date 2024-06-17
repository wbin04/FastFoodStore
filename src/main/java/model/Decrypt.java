package model;

import java.security.MessageDigest;

import org.apache.tomcat.util.codec.binary.Base64;

public class Decrypt {
	public static String SHA1(String str)
	{
		String salt = "asjjjasd&*$bh@##h";
		String result = null;
		str += salt;
		try {
			byte[] dataBytes = str.getBytes("UTF-8");
			MessageDigest md = MessageDigest.getInstance("SHA-1");
			result = Base64.encodeBase64String(md.digest(dataBytes));
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return result;
	}
}
