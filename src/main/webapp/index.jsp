<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.database.Database" %>
<%@ page import="org.example.dao.ProductDao" %>
<%@ page import="org.example.model.Product" %>
<%@ page import="java.util.List" %>


<%@include file="includes/header.jsp"%>
<%@include file="includes/carousel.jsp"%>

<%
    String search =request.getParameter("search"); //Obtenemos el Id del juego
%>
<!-- Contenido principal-->
<div class="container my-4">
    <div class="row">
        <div class="col-12 text-center">
            <h2>Nuestra tienda online</h2>
            <p class="lead">Productos de la aplicación web.</p>
        </div>
    </div>
</div>

<div class="container">
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
        <%
            HttpSession currentSession = request.getSession();
            String role = "anonymous";
            Database database = new Database();
            database.connect();
            ProductDao productDao = new ProductDao(database.getConnection());

            List<Product> productList = productDao.getProducts(search);
            for (Product product: productList){
        %>
        <div class="col">
            <div class="card shadow-sm">
                <!-- <img src="../product_images/"> -->
                <div class="card-body">
                    <h4 class="card-text"><%= product.getName() %></h4>
                    <p class="card-text"><%= product.getDescription() %></p>
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="btn-group">
                            <a href="detail_product.jsp?product_id=<%= product.getId()%>" class="btn btn-sm btn-outline-secondary"> Acerca del producto</a>
                            <%
                                if (role.equals("user")){ //si el usuario es de tipo user le pintamos el botón de comprar sino
                            %>
                            <a href="add_cart?product_id=<%= product.getId()%>" class="btn btn-sm btn-outline-secondary">Añadir al carrito</a> <!--Los que vayan directamente a una acción directa a través de un servlet no hará falta poner jsp -->
                            <%
                            } else if (role.equals("admin")) {
                            %>
                            <a href="edit_product.jsp?product_id=<%= product.getId()%>"
                               onclick="return confirm('¿Estás seguro de querer modificar el juego?')"
                               class="btn btn-sm btn-outline-warning">Editar</a>    <!--Los que vayan directamente a otra web hará falta poner .jsp -->
                            <a href="delete_product?product_id=<%= product.getId()%>"
                               onclick="return confirm('¿Estás seguro de querer eliminar el juego?')"
                               class="btn btn-sm btn-outline-danger">Eliminar</a>
                            
                            <%
                                }

                            %>
                        </div>
                        <small class="text-body-secondary"><%=product.getPrice() %></small>
                    </div>
                </div>
            </div>
        </div>
        <%
            }
        %>

    </div>
</div>





<%@include file="includes/footer.jsp"%>
