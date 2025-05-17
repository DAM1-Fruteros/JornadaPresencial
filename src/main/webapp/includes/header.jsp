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

    <%
        HttpSession currentSession = request.getSession();
        String role = "anonymous";
        Integer userId = null;
        String name = null;
        if (currentSession.getAttribute("role") !=null){
            role = currentSession.getAttribute("role").toString();
        }
        if (currentSession.getAttribute("id") !=null){
            //añadimos esta linea para coger id cuando pasamos usuario y cogemos tb id
            userId = (int) currentSession.getAttribute("id");
        }
        if (currentSession.getAttribute("name") !=null) {
            name = currentSession.getAttribute("name").toString();
        }
    %>

    <!-- Barra de navegación -->
    <nav class="navbar navbar-expand-md navbar-light bg-white py-3">
        <div class="container">
            <a class="navbar-brand" href="/practicas_app">Electronic devices</a>
            <i class="fa-solid fa-mobile"></i>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <%
                        if (role.equals("admin")) {
                    %>
                    <li class="nav-item active">
                        <a class="nav-link" href="edit_product.jsp">
                            <i class="fas fa-box nav-icon me-2" style="display: none;"></i>
                            <span class="nav-text">Productos <i class="fa-solid fa-plus"></i></span>
                        </a>
                    </li>
                    <%
                        }
                    %>

                    <%
                        if (role.equals("admin")){
                    %>
                    <li class="nav-item">
                        <a class="nav-link" href="users.jsp">
                            <i class="fas fa-user nav-icon me-2" style="display: none;"></i>
                            <span class="nav-text">Profile</span>
                        </a>
                    </li>
                    <%
                        }
                    %>
                    <%
                        if (role.equals("unknown")) {
                    %>
                    <li class="nav-item">
                        <a class="nav-link" href="cart.jsp">
                            <i class="fas fa-shopping-cart nav-icon me-2" style="display: none;"></i>
                            <span class="nav-text">Go to cart</span>
                        </a>
                    </li>

                    <%
                        }

                        if (role.equals("anonymous")) {
                    %>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">
                            <i class="fa-solid fa-user"></i>
                        </a>
                    </li>
                    <%
                        } else {
                    %>
                    <li class="nav-item">
                        <a class="nav-link" href="/practicas_app/logout">
                            <i class="fa-solid fa-right-to-bracket"></i>
                        </a>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </div>
        </div>
    </nav>
</header>