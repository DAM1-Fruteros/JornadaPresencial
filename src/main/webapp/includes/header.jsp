<%@page contentType="text/html;charset=UTF-8" language="java" %>

<!doctype html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Practicas presenciales</title>
    <link rel="stylesheet" href="./css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">


    <!-- añadimos jquery para poder usar ajax que es javascript-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>

<body>

<header>
    <!-- Barra de navegación -->
    <nav class="navbar navbar-expand-md navbar-light bg-white py-3">
        <div class="container">
            <a class="navbar-brand" href="#">MiTienda</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">
                            <i class="fas fa-box nav-icon me-2" style="display: none;"></i>
                            <span class="nav-text">Productos</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="fas fa-user nav-icon me-2" style="display: none;"></i>
                            <span class="nav-text">Usuarios</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="fas fa-shopping-cart nav-icon me-2" style="display: none;"></i>
                            <span class="nav-text">Carrito</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>