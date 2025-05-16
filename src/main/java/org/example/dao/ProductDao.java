package org.example.dao;

import org.example.exception.ProductNotFoundException;
import org.example.exception.UserNotFoundException;
import org.example.model.Product;
import org.example.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ProductDao {
    private Connection connection;

    public ProductDao(Connection connection) {
        this.connection = connection;
    }

    //Mostramos todos los productos sin campo de busqueda
    public ArrayList<Product> getProducts() throws SQLException, ProductNotFoundException {
        String sql = "SELECT * FROM products";
        return launchQuery(sql);
    }

    //Mostramos todos los productos teniendo en cuenta el campo de busqueda
    public ArrayList<Product> getProducts(String search) throws SQLException, ProductNotFoundException {
        String sql = "SELECT * FROM products WHERE name LIKE ? ";
        if (search == null || search.isEmpty()) {
            return getProducts();
        }
        return launchQuery(sql, search);
    }

    //Mostramos todos los usuarios
    private ArrayList<Product> launchQuery(String sql, String ...search) throws SQLException {
        PreparedStatement statement = null;
        ResultSet result = null;
        statement = connection.prepareStatement(sql);
        if (search.length > 0) {
            statement.setString(1, "%" + search[0] + "%");
        }
        result = statement.executeQuery();

        ArrayList<Product> productList = new ArrayList<>();

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
            productList.add(product);
        }
        statement.close();

        return productList;
    }

    //Mostramos un producto
    public Product getProduct (int id) throws SQLException, UserNotFoundException {
        String sql = "SELECT * FROM products WHERE id = ?";
        PreparedStatement statement = null;
        ResultSet result = null;

        statement = connection.prepareStatement(sql);
        statement.setInt(1, id);
        result = statement.executeQuery();

        if (!result.next()){
            throw new UserNotFoundException();
        }
        Product product = new Product();
        product.setId(result.getInt("id"));
        product.setName(result.getString("name"));
        product.setDescription(result.getString("description"));
        product.setPrice(result.getFloat("price"));
        product.setQuantity(result.getInt("quantity"));
        product.setCategory(result.getString("category"));
        product.setImage(result.getString("image"));
        product.setRate(result.getFloat("rate"));
        statement.close();

        return product;
    }

    //Añadimos un producto
    public boolean addProduct (Product product) throws SQLException {
        String sql = "INSERT INTO products (name, description, price, quantity, category, image, rate) VALUES (?,?,?,?,?,?,?)";
        PreparedStatement statement = null;

        statement = connection.prepareStatement(sql);
        statement.setString(1, product.getName());
        statement.setString(2, product.getDescription());
        statement.setFloat(3, product.getPrice());
        statement.setInt(4, product.getQuantity());
        statement.setString(5, product.getCategory());
        statement.setString(6, product.getImage());
        statement.setFloat(7,product.getRate());

        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;
    }

    //Editamos un producto
    public boolean editProduct (Product product) throws SQLException {
        String sentenciasql = "UPDATE products SET name = ?, description = ?, price = ?, quantity = ?, category = ?, image = ?, rate = ? WHERE id = ?";
        PreparedStatement statement = null;
        statement = connection.prepareStatement(sentenciasql);

        statement.setString(1, product.getName());
        statement.setString(2, product.getDescription());
        statement.setFloat(3, product.getPrice());
        statement.setInt(4, product.getQuantity());
        statement.setString(5, product.getCategory());
        statement.setString(6, product.getImage());
        statement.setFloat(7, product.getRate());
        statement.setInt(8, product.getId());

        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;
    }

    //Borramos un producto
    public boolean deleteProduct(int productId) throws SQLException {
        String sentenciasql = "DELETE FROM products WHERE id=?";
        PreparedStatement statement = null;
        statement = connection.prepareStatement(sentenciasql);
        statement.setInt(1, productId);

        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;

    }

}
