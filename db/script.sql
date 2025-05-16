CREATE DATABASE IF NOT EXISTS practicasapp;
GRANT ALL PRIVILEGES ON practicasapp.* TO user;
USE practicasapp;

CREATE TABLE users (
           id INT AUTO_INCREMENT PRIMARY KEY,
           name VARCHAR(150) NOT NULL,
           surname VARCHAR(150) NOT NULL,
           birthdate DATE NOT NULL,
           email VARCHAR(255) UNIQUE NOT NULL,
           password VARCHAR(255) NOT NULL,
           role VARCHAR(100) NOT NULL,
           active BOOLEAN DEFAULT TRUE
);

CREATE TABLE products (
          id INT AUTO_INCREMENT PRIMARY KEY,
          name VARCHAR(200) NOT NULL,
          description TEXT,
          price FLOAT NOT NULL,
          quantity INT NOT NULL,
          category VARCHAR(150),
          image VARCHAR(255),
          rate DECIMAL(3,1)
);

CREATE TABLE cart (
          id INT AUTO_INCREMENT PRIMARY KEY,
          id_user INT NOT NULL,
          id_product INT NOT NULL,
          FOREIGN KEY (id_user) REFERENCES users(id) ON DELETE CASCADE,
          FOREIGN KEY (id_product) REFERENCES products(id) ON DELETE CASCADE,
);