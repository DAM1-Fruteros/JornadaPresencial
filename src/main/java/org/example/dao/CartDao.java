package org.example.dao;

import org.example.model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDao {

    private Connection connection;

    public CartDao() {
        this.connection = connection;
    }

    public List<Product> getCartUserId(int id) throws SQLException {
        String sql = "SELECT p.* FROM cart c JOIN products p ON c.id_product = p.id WHERE c.id_user = ?";
        PreparedStatement statement = null;
        ResultSet result = null;

        statement = connection.prepareStatement(sql);
        statement.setInt(1, id);
        result = statement.executeQuery();

        List<Product> cartList = new ArrayList<>();

        while (result.next()) {
            Product product = new Product();
            product.setId(result.getInt("id"));
            product.setName(result.getString("name"));
            product.setDescription(result.getString("description"));
            product.setPrice(result.getFloat("price"));
            product.setQuantity(result.getInt("quantity"));
            product.setCategory(result.getString("category"));
            product.setImage(result.getString("image"));
            product.setRate(result.getFloat("rate"));

            cartList.add(product);

        }
        return cartList;
    }

    public boolean addCart(int userId, int productId) throws SQLException {
        String sql = "INSERT INTO favoritos (id_user, id_product) VALUES (?,?)";
        PreparedStatement statement = null;

        statement = connection.prepareStatement(sql);
        statement.setInt(1,userId);
        statement.setInt(2, productId);

        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;
    }

    public boolean deleteCart(int userId, int productId) throws SQLException {
        String sql = "DELETE FROM cart WHERE id_user = ? AND id_product = ?";
        PreparedStatement statement = null;

        statement = connection.prepareStatement(sql);
        statement.setInt(1, userId);
        statement.setInt(2, productId);

        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;

    }
}