package org.example.dao;

import java.sql.Connection;

public class ProductDao {
    private Connection connection;

    public ProductDao(Connection connection) {
        this.connection = connection;
    }



}
