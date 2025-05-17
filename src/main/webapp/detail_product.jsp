<%@ page import="org.example.exception.ProductNotFoundException" %>
<%@ page import="org.example.database.Database" %>
<%@ page import="org.example.dao.ProductDao" %>
<%@ page import="org.example.model.Product" %>
<%@ page import="org.example.utils.CurrencyUtils" %>

<%@include file="includes/header.jsp"%>

<%
    int productId = Integer.parseInt(request.getParameter("product_id"));

    Database database = new Database();
    database.connect();
    ProductDao productDao = new ProductDao(database.getConnection());
    try {
        Product product = productDao.getProduct(productId);
%>

<div class="container py-5">
    <div class="container d-flex justify-content-center">
        <div class="card mb-3" style="max-width: 700px;">
            <div class="row g-0">
                <div class="col-md-4 d-flex align-items-center justify-content-center card-image">
                    <img src="../practicas_app_images/<%= product.getImage()%>" class="img-fluid rounded-start" style="width: 100%; height: 70%;" alt="no hay imagen disponible">
                </div>
                <div class="col-md-8">
                    <div class="card-body">
                        <h5 class="card-title"><%= product.getName()%></h5>
                        <p class="card-text">Description: <%= product.getDescription()%></p>
                        <p class="card-text">Category: <%= product.getCategory()%></p>
                        <p class="card-text">Rating: <%= product.getRate()%> <i class="bi bi-star-fill" style="color: gold;"></i></p>
                        <p class="card-text">Price: <%= CurrencyUtils.format(product.getPrice())%></p>
                        <p class="card-text"><small class="text-body-secondary"><%= product.getQuantity()%> units left!</small></p>

                        <div class="text-end mt-3">
                            <%
                                if (role.equals("user")) {
                            %>
                            <a href="add_cart?product_id=<%= product.getId()%>" type="button" class="btn btn-outline-warning">Add to cart</a>
                            <%
                            } else if (role.equals("admin")) {
                            %>
                            <a href="edit_product.jsp?product_id=<%= product.getId()%>" type="button" class="btn btn-info">Edit</a>
                            <a href="delete_product?product_id=<%= product.getId()%>" type="button"
                               onclick="return confirm('Are you sure you want to delete it?')"
                               class="btn btn-danger">Delete</a>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container py-5"></div>
<%
} catch (ProductNotFoundException pnfe) {
%>
    <%@include file="includes/not_found_product.jsp"%>
<%
    }
%>

<%@include file="includes/footer.jsp"%>