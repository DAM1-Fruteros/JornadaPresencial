CREATE DATABASE IF NOT EXISTS practicasapp;
GRANT ALL PRIVILEGES ON practicasapp.* TO user;
USE
practicasapp;

CREATE TABLE users
(
    id        INT AUTO_INCREMENT PRIMARY KEY,
    name      VARCHAR(150)        NOT NULL,
    surname   VARCHAR(150)        NOT NULL,
    birthdate DATE                NOT NULL,
    email     VARCHAR(255) UNIQUE NOT NULL,
    password  VARCHAR(255)        NOT NULL,
    role      VARCHAR(100)        NOT NULL,
    active    BOOLEAN DEFAULT TRUE
);

CREATE TABLE products
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(200) NOT NULL,
    description TEXT,
    price       FLOAT        NOT NULL,
    quantity    INT          NOT NULL,
    category    VARCHAR(150),
    image       VARCHAR(255),
    rate        DECIMAL(3, 1)
);

CREATE TABLE cart
(
    id         INT AUTO_INCREMENT PRIMARY KEY,
    id_user    INT NOT NULL,
    id_product INT NOT NULL,
    FOREIGN KEY (id_user) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (id_product) REFERENCES products (id) ON DELETE CASCADE
);

INSERT INTO users (name, surname, birthdate, email, password, role, active) VALUES
                ('Juan', 'Pérez', '1990-05-15', 'juan.perez@example.com', 'password123', 'admin', TRUE),
                ('María', 'Gómez', '1985-10-23', 'maria.gomez@example.com', 'mariapassword', 'user', TRUE),
                ('Carlos', 'Lopez', '1993-01-10', 'carlos.lopez@example.com', 'carpassword', 'user', TRUE),
                ('Ana', 'Martínez', '1998-07-29', 'ana.martinez@example.com', 'anapassword', 'user', TRUE),
                ('Luis', 'Hernández', '1988-03-02', 'luis.hernandez@example.com', 'luispassword', 'admin', FALSE);


INSERT INTO products (name, description, price, quantity, category, rate) VALUES
                 ('Laptop', 'Laptop 15 inches with 16GB of RAM and a 512GB SSD', 1000.00, 10, 'Electrónica', 4.5),
                 ('Smartphone', 'Smartphone with 6.5 inches screen and 48MP camera', 500.00, 50, 'Electrónica', 4.2),
                 ('Headphones', 'Auriculares con cancelación de ruido y conexión bluetooth', 150.00, 30, 'Accesorios', 4.8),
                 ('Smartwatch', 'Reloj inteligente con monitor de ritmo cardíaco', 200.00, 25, 'Accesorios', 4.0),
                 ('Cámara DSLR', 'Cámara profesional con lente 18-55mm', 800.00, 15, 'Fotografía', 4.6);


INSERT INTO cart (id_user, id_product) VALUES
                                           (1, 17),
                                           (2, 20);