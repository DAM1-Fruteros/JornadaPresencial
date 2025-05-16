package org.example.dao;

import org.example.exception.UserNotFoundException;
import org.example.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UserDao {
    private Connection connection;

    public UserDao(Connection connection) {
        this.connection = connection;
    }

    //Login que devuelve un objeto usuario
    public User loginUsers(String email, String password) throws SQLException, UserNotFoundException {
        String sql = "SELECT id, name, email, password, role FROM users WHERE email = ? AND password = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, email);
        statement.setString(2, password);
        ResultSet result = statement.executeQuery();

        if (!result.next()) {
            throw new UserNotFoundException();
        }

        User user = new User();
        user.setId(result.getInt("id"));
        user.setName(result.getString("name"));
        user.setEmail(result.getString("email"));
        user.setPassword(result.getString("password"));
        user.setRole(result.getString("role"));
        return user;
    }

    //Mostramos todos los usuarios sin campo de busqueda
    public ArrayList<User> getUsers() throws SQLException, UserNotFoundException{
        String sql = "SELECT * FROM users";
        return launchQuery(sql);
    }

    //Mostramos todos los usuarios teniendo en cuenta el campo de busqueda
    public ArrayList<User> getUsers(String search) throws SQLException, UserNotFoundException {
        String sql = "SELECT * FROM users WHERE email LIKE ? OR role LIKE ? OR name LIKE ?";
        if (search == null || search.isEmpty()) {
            return getUsers();
        }
        return launchQuery(sql, search);
    }

    //Mostramos todos los usuarios
    private ArrayList<User> launchQuery(String sql, String ...search) throws SQLException {
        PreparedStatement statement = null;
        ResultSet result = null;
        statement = connection.prepareStatement(sql);
        if (search.length > 0) {
            statement.setString(1, "%" + search[0] + "%");
            statement.setString(2, "%" + search[0] + "%");
            statement.setString(3, "%" + search[0] + "%");
        }
        result = statement.executeQuery();

        ArrayList<User> userList = new ArrayList<>();

        while (result.next()) {
            User user = new User();
            user.setId(result.getInt("id"));
            user.setName(result.getString("name"));
            user.setSurname(result.getString("surname"));
            user.setBirthdate(result.getDate("birthdate"));
            user.setEmail(result.getString("email"));
            user.setPassword(result.getString("password"));
            user.setRole(result.getString("role"));
            user.setActive(result.getBoolean("active"));
            userList.add(user);
        }
        statement.close();

        return userList;
    }

    //Mostramos un usuario
    public User getUser (int id) throws SQLException, UserNotFoundException {
        String sql = "SELECT * FROM users WHERE id = ?";
        PreparedStatement statement = null;
        ResultSet result = null;

        statement = connection.prepareStatement(sql);
        statement.setInt(1, id);
        result = statement.executeQuery();

        if (!result.next()){
            throw new UserNotFoundException();
        }
        User user = new User();
        user.setId(result.getInt("id"));
        user.setName(result.getString("name"));
        user.setSurname(result.getString("surname"));
        user.setBirthdate(result.getDate("birthdate"));
        user.setEmail(result.getString("email"));
        user.setPassword(result.getString("password"));
        user.setRole(result.getString("role"));
        user.setActive(result.getBoolean("active"));
        statement.close();

        return user;
    }

    //Añadimos un usuario
    public boolean addUser (User user) throws SQLException {
        String sql = "INSERT INTO users (name, surmane, birthdate, email, password, role, active) VALUES (?,?,?,?,?,?,?)";
        PreparedStatement statement = null;

        statement = connection.prepareStatement(sql);
        statement.setString(1, user.getName());
        statement.setString(2, user.getSurname());
        statement.setDate(3, user.getBirthdate());
        statement.setString(4, user.getEmail());
        statement.setString(5, user.getPassword());
        statement.setString(6,user.getRole());
        statement.setBoolean(7,user.isActive());

        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;
    }

    //Editamos un usuario
    public boolean editUser (User user) throws SQLException {
        String sentenciasql = "UPDATE users SET name = ?, surname = ?, birthdate = ?, email = ?, password = ?, role = ?, active = ? WHERE id = ?";
        PreparedStatement statement = null;
        statement = connection.prepareStatement(sentenciasql);

        statement.setString(1, user.getName());
        statement.setString(2, user.getSurname());
        statement.setDate(3, user.getBirthdate());
        statement.setString(4, user.getEmail());
        statement.setString(5, user.getPassword());
        statement.setString(6, user.getRole());
        statement.setBoolean(7, user.isActive());
        statement.setInt(8, user.getId());

        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;
    }

    //Borramos un usuario
    public boolean deleteUser(int usuarioId) throws SQLException {
        String sentenciasql = "DELETE FROM usuarios WHERE id=?";
        PreparedStatement statement = null;
        statement = connection.prepareStatement(sentenciasql);
        statement.setInt(1, usuarioId);

        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;

    }
}
