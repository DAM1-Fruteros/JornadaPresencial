package org.example.servlet;


import org.example.dao.UserDao;
import org.example.database.Database;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/delete_user")

public class DeleteUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setCharacterEncoding("UTF-8");

        HttpSession currentSession = request.getSession();
        if (currentSession.getAttribute("role") == null) {
            response.sendRedirect("/practicas_app/login.jsp");
            return;
        }

        String userId = request.getParameter("user_id");

        try {
            Database database = new Database();
            database.connect();
            UserDao userDao = new UserDao(database.getConnection());
            userDao.deleteUser(Integer.parseInt(userId));

            response.sendRedirect("/practicas_app/users.jsp");

        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }


    }
}
