package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.UsersService;

@WebServlet("/checkExists")
public class CheckExistsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        String value = request.getParameter("value");

        UsersService usersService = new UsersService();
        boolean exists = false;

        if ("username".equals(type)) {
            exists = usersService.checkUsernameExists(value);
        } else if ("email".equals(type)) {
            exists = usersService.checkEmailExists(value);
        }

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        if (exists) {
            response.getWriter().write(type + " đã tồn tại");
        } else {
            response.getWriter().write("");
        }
    }
}
