package api;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
@WebServlet(urlPatterns = "/uploadImage")
public class UploadImageApi extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			Part part = req.getPart("photo");
			String realPath = req.getServletContext().getRealPath("/images");
			String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
			
			if(!Files.exists(Paths.get(realPath))) {
				Files.createDirectory(Paths.get(realPath));
			}
			part.write(realPath + "/" + filename);
			String imageUrl = req.getContextPath() + "/images/" + filename;
            resp.getWriter().write(imageUrl);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}
