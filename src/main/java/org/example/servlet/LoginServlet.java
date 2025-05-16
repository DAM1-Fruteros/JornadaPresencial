package org.example.servlet;


import org.example.dao.UserDao;
import org.example.database.Database;
import org.example.exception.UserNotFoundException;
import org.example.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;


@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException{

        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try{
            Database database = new Database();
            database.connect();
            UserDao userDao = new UserDao(database.getConnection());
            /*Cuando usamos el login que solo devuelve el role
            String role = usuarioDao.loginUsers(email, password);

            HttpSession session = request.getSession();
            session.setAttribute("email", email);
            session.setAttribute("role", role);*/

            //Cuando usamos el login que devuelve el objeto Usuario
            User user = userDao.loginUsers(email, password);
            HttpSession session = request.getSession();
            session.setAttribute("email", user.getEmail());
            session.setAttribute("role", user.getRole());
            session.setAttribute("name", user.getName());
            session.setAttribute("id", user.getId());


            response.getWriter().print("ok");

        }catch (SQLException sqle) {
            try {
                response.getWriter().println("No se ha podido conectar con la base de datos");
            } catch (IOException ioe) {
                ioe.printStackTrace();
            }
            sqle.printStackTrace();
        }catch (ClassNotFoundException cnfe){
            cnfe.printStackTrace();
        }catch (IOException ioe){
            ioe.printStackTrace();
        }catch (UserNotFoundException unfe){
            try{
                response.getWriter().println("Usuario/contraseña incorrectos");
            }catch (IOException ioe) {
                ioe.printStackTrace();
            }
        }

    }
}
