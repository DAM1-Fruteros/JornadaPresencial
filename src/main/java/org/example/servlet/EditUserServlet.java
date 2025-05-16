package org.example.servlet;


import org.example.dao.UserDao;
import org.example.database.Database;
import org.example.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.crypto.Data;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/edit_user")
public class EditUserServlet extends HttpServlet {

    private ArrayList<String> errors;

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        HttpSession currentSession = request.getSession();
        if (currentSession.getAttribute("role") == null) {
            response.sendRedirect("/practicas_app/login.jsp");
        }

        if (!validate(request)){
            response.getWriter().print(errors.toString());
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        Date birthdate = Date.valueOf(request.getParameter("birthdate"));
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        Boolean active = Boolean.parseBoolean(request.getParameter("active"));

        try{
            Database datababase = new Database();
            datababase.connect();
            UserDao userDao = new UserDao(datababase.getConnection());
            User user = new User();
            user.setId(id);
            user.setName(name);
            user.setSurname(surname);
            user.setBirthdate(birthdate);
            user.setEmail(email);
            user.setPassword(password);
            user.setRole(role);
            user.setActive(active);


            boolean edited = userDao.editUser(user);
            if (edited) {
                response.getWriter().print("ok");
            } else {
                response.getWriter().print("No se ha podido actualizar el usuario");
            }
        } catch (SQLException sqle){
            try{
                response.getWriter().println("No se ha podido conectar con la base de datos");
                sqle.printStackTrace();
                response.getWriter().println("Error SQL: " + sqle.getMessage());
            }catch (IOException ioe){
                ioe.printStackTrace();
            }
            sqle.printStackTrace();
        }catch (IOException ioe){
            ioe.printStackTrace();
        }catch (ClassNotFoundException cnfe){
            cnfe.printStackTrace();
        }
    }

    private boolean validate(HttpServletRequest request){
        errors = new ArrayList<>();
        if (request.getParameter("name").isEmpty()){
            errors.add("Name is required");
        }
        if (request.getParameter("email").isEmpty()){
            errors.add("Email is required");
        }
        if (request.getParameter("password").isEmpty()){
            errors.add("Password is required");
        }
        if (request.getParameter("role").isEmpty()){
            errors.add("Rol is required");
        }
        return errors.isEmpty();
    }
}
