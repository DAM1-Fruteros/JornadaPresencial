package org.example.model;

import lombok.Data;

@Data
public class Product {
    private int id;
    private String name;
    private String description;
    private float price;
    private int quantity;
    private String category;
    private String image;
    private float rate;
}
