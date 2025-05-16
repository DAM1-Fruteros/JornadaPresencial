package org.example.model;

import lombok.Data;

@Data
public class Cart {
    int idUser;
    int idProduct;

    public Cart(int idUser, int idProduct) {
        this.idUser = idUser;
        this.idProduct = idProduct;
    }
}
