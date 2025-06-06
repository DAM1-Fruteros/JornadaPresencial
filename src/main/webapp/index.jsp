<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.database.Database" %>
<%@ page import="org.example.dao.ProductDao" %>
<%@ page import="org.example.model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.utils.CurrencyUtils" %>


<%@include file="includes/header.jsp"%>
<%@include file="includes/carousel.jsp"%>

<%
    String search = request.getParameter("search");
%>

<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <form  method="get" action="<%=request.getRequestURI()%>" class="input-group">
            <span class="input-group-text bg-white border-end-0"><i class="bi bi-search"></i></span>
            <input type="text" name="search" id="search" class="form-control border-start-0" placeholder="Search by name" value="<%= search != null ? search : "" %>" >
        </form>
    </div>
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
        <%
            Database database = new Database();
            database.connect();
            ProductDao productDao = new ProductDao(database.getConnection());
            List<Product> productList = productDao.getProducts(search);
            for (Product product: productList){
        %>

        <div class="col">
            <div class="card shadow-sm card-paginacion">
                <div class="d-flex align-items-center justify-content-center card-index-image">
                 <img src="../practicas_app_images/<%= product.getImage()%>" style="width:150px; height:130px;">
                </div>
                <div class="card-body">
                    <h4 class="card-text"><%= product.getName() %></h4>
                    <p class="card-text"><%= product.getDescription() %></p>
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="btn-group">
                            <a href="detail_product.jsp?product_id=<%= product.getId()%>" class="btn btn-sm btn-outline-secondary"> See more</a>
                            <%
                                if (role.equals("user")){ //si el usuario es de tipo user le pintamos el botón de comprar sino
                            %>
                            <a href="add_cart?product_id=<%= product.getId()%>" class="btn btn-sm btn-outline-info px-4"><i class="fa-solid fa-cart-shopping"></i></a>
                            <%
                            }  %>
                        </div>
                        <small class="text-body-secondary"><%= CurrencyUtils.format(product.getPrice())%></small>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", () => {
            const cards = document.querySelectorAll(".card-paginacion");
            const itemsPagina = 6;
            let paginaActual = 1;
            const totalPaginas = Math.ceil(cards.length / itemsPagina);

            function mostrarPagina(pagina) {
            cards.forEach((card, index) => {
            card.style.display = ((index >= (pagina - 1) * itemsPagina) && (index < pagina * itemsPagina)) ? "block" : "none";
            });
            }

            document.getElementById("btn_anterior").addEventListener("click", () => {
            if (paginaActual > 1) {
            paginaActual--;
            mostrarPagina(paginaActual);
            }
            });

            document.getElementById("btn_siguiente").addEventListener("click", () => {
            if (paginaActual < totalPaginas) {
            paginaActual++;
            mostrarPagina(paginaActual);
            }
            });

            mostrarPagina(paginaActual);
            });
        </script>

        <%
            }
        %>

    </div>
</div>


<div class="d-flex justify-content-center mt-4">
    <button id="btn_anterior" class="btn btn-outline-secondary  me-1">Previous</button>
    <button id="btn_siguiente" class="btn btn-outline-secondary">Next</button>
</div>



<%@include file="includes/footer.jsp"%>
