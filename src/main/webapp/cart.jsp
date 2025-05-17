<%@ page import="org.example.model.Product" %>
<%@ page import="org.example.dao.CartDao" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.database.Database" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>


<%

    if (currentSession == null || currentSession.getAttribute("role") == null || !currentSession.getAttribute("role").equals("user")) {
        response.sendRedirect("/practicas_app/login.jsp");
        return;
    }

    if (userId == null) {
        response.sendRedirect("/practicas_app/login.jsp");
        return;
    }
%>


<div class="container mt-5">
    <h2 class="mb-4">Your Cart, <i><%= currentSession.getAttribute("name") %></i></h2>

    <%
        Database database = new Database();
        database.connect();
        CartDao cartDao = new CartDao(database.getConnection());
        List<Product> cartList = cartDao.getCartUserId(userId);

        if (cartList.isEmpty()) {
    %>
    <div class="alert alert-warning">Your cart is empty.</div>
    <%
    } else {
        for (Product product : cartList) {
    %>
    <div class="card mb-3 shadow-sm">
        <div class="row g-0 align-items-center">
            <div class="col-md-3 text-center">
                <img src="images/<%= product.getImage() %>" class="img-fluid rounded-start p-2" style="max-height: 180px; object-fit: contain;" alt="<%= product.getName() %>">
            </div>
            <div class="col-md-6">
                <div class="card-body">
                    <h5 class="card-title mb-1"><%= product.getName() %></h5>
                    <p class="card-text mb-1 text-muted">$<%= product.getPrice() %></p>
                    <p class="card-text mb-1"><i class="bi bi-star-fill" style="color: gold;"></i> <%= product.getRate() %>/10</p>
                </div>
            </div>
            <div class="col-md-3 text-end pe-4">
                <a href="detail_product.jsp?product_id=<%= product.getId() %>" class="btn btn-outline-secondary btn-sm mb-2 w-100">Detail</a>
                <%
                    if (role.equals("user")) {
                %>
                <a href="delete_cart?product_id=<%= product.getId() %>" class="btn btn-danger btn-sm w-100">Delete</a>
                <%
                    }
                %>
            </div>
        </div>
    </div>
    <%
            }
        }
    %>

</div>

<div class="container py-5 mb-6"></div>
<script src="./scripts/script_paginacion.js"></script>


<%@include file="includes/footer.jsp"%>