package org.example.model;

import java.sql.Date;
import lombok.Data;

@Data
public class User {

    private int id;
    private String name;
    private String surname;
    private Date birthdate;
    private String email;
    private String password;
    private String role;
    private boolean active;
}
