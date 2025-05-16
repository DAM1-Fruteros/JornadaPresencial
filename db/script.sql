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
    FOREIGN KEY (id_product) REFERENCES products (id) ON DELETE CASCADE,
);

INSERT INTO users (name, surname, birthdate, email, password, role, active) VALUES
                                                                                ('Juan', 'Pérez', '1990-05-15', 'juan.perez@example.com', 'password123', 'admin', TRUE),
                                                                                ('María', 'Gómez', '1985-10-23', 'maria.gomez@example.com', 'mariapassword', 'customer', TRUE),
                                                                                ('Carlos', 'Lopez', '1993-01-10', 'carlos.lopez@example.com', 'carpassword', 'customer', TRUE),
                                                                                ('Ana', 'Martínez', '1998-07-29', 'ana.martinez@example.com', 'anapassword', 'customer', TRUE),
                                                                                ('Luis', 'Hernández', '1988-03-02', 'luis.hernandez@example.com', 'luispassword', 'admin', FALSE);


INSERT INTO products (name, description, price, quantity, category, image, rate) VALUES
                                                                                     ('Laptop', 'Laptop de 15 pulgadas con 16GB de RAM y 512GB SSD', 1000.00, 10, 'Electrónica', 'laptop.jpg', 4.5),
                                                                                     ('Smartphone', 'Smartphone con pantalla de 6.5 pulgadas y cámara de 48MP', 500.00, 50, 'Electrónica', 'smartphone.jpg', 4.2),
                                                                                     ('Headphones', 'Auriculares con cancelación de ruido y conexión bluetooth', 150.00, 30, 'Accesorios', 'headphones.jpg', 4.8),
                                                                                     ('Smartwatch', 'Reloj inteligente con monitor de ritmo cardíaco', 200.00, 25, 'Accesorios', 'smartwatch.jpg', 4.0),
                                                                                     ('Cámara DSLR', 'Cámara profesional con lente 18-55mm', 800.00, 15, 'Fotografía', 'camera.jpg', 4.6);


INSERT INTO cart (id_user, id_product) VALUES
                                           (1, 2),  -- Juan ha agregado el Smartphone al carrito
                                           (2, 3),  -- María ha agregado los Headphones al carrito
                                           (3, 1),  -- Carlos ha agregado la Laptop al carrito
                                           (4, 4),  -- Ana ha agregado el Smartwatch al carrito
                                           (5, 5);  -- Luis ha agregado la Cámara DSLR al carrito
