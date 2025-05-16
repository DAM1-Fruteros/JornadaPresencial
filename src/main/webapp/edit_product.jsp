<%@ page import="org.example.model.Product" %>
<%@ page import="org.example.database.Database" %>
<%@ page import="org.example.dao.ProductDao" %>

<%@include file="includes/header.jsp"%>

<%
  if ((currentSession.getAttribute("role") == null) || (!currentSession.getAttribute("role").equals("admin"))) {
    response.sendRedirect("/practicas_app/login.jsp");
  }

  String action = null;
  Product product = null;
  String productId = request.getParameter("product_id");
  if (productId != null) {
    action = "Edit";
    Database database = new Database();
    database.connect();
    ProductDao productDao = new ProductDao(database.getConnection());
    product = productDao.getProduct(Integer.parseInt(productId));
  } else {
    action = "Send";
  }
%>

<script type="text/javascript">
  $(document).ready(function() {
    $("form").on("submit", function(event) {
      event.preventDefault();
      const form = $("form")[0];
      const formValue = new FormData(form);
      $.ajax("edit_product", {
        type: "POST",
        enctype: "multipart/form-data",
        data: formValue,
        processData: false,
        contentType: false,
        statusCode: {
          200: function(response) {
            if (response === "ok") {
              $("#result").html("<div class='alert alert-success' role='alert'>"+ response +"</div>");    //sino tirame en la capa result lo que te tire el servlet
            } else {
              $("#result").html("<div class='alert alert-danger' role='alert'>"+ response +"</div>");    //sino tirame en la capa result lo que te tire el servlet
            }
          },
          404: function (response) {
            $("#result").html("<div class='alert alert-danger' role='alert'>Error on sending data</div>");
          }
        }
      });
    });
  });
</script>

<div class="album py-5 bg-body-territory">
  <div class="container d-flex justify-content-center">
    <form>
      <h1>Electronic devices <i class="fa-solid fa-mobile"></i></h1>
      <h3 class="h3 mb-3 fw-normal"><%=action %> product</h3>
      <div class="input-group mb-2">
        <span class="input-group-text">Product</span>
        <input type="text" id="name" name="name" placeholder="Iphone 16"  class="form-control"
               aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default"
               value="<%= product != null ? product.getName() : "" %>">  <!-- El ?  funciona como un if y los : actúa como else    -->
      </div>

      <div class="input-group mb-2">
        <span class="input-group-text">Description</span>
        <input type="text" id="description" name="description" placeholder="Features, properties,..." class="form-control"
                  value="<%= product != null ? product.getDescription() : "" %>">
      </div>

      <div class="input-group mb-2">
        <span class="input-group-text">Category</span>
        <input type="text" id="category" name="category" class="form-control" placeholder="Mobile"
               value="<%= product != null ? product.getCategory() : "" %>">
      </div>

      <div class="input-group mb-2">
        <span class="input-group-text">Product image</span>
        <input type="file" id="image" name="image"  class="form-control">
      </div>

      <div class="input-group mb-2">
        <span class="input-group-text">Price</span>
        <input type="text" id="price" name="price" placeholder="900€" class="form-control"
               value="<%= product != null ? product.getPrice() : "" %>">
      </div>

      <div class="input-group mb-2">
        <span class="input-group-text">Quantity</span>
        <input type="text"  id="quantity" name="quantity" placeholder="20" class="form-control"
               value="<%= product != null ? product.getQuantity() : "" %>">
      </div>

      <div class="input-group mb-2">
        <span class="input-group-text">Rating</span>
        <input type="text"  id="rate" name="rate" max="5" min="0" placeholder="3.5" class="form-control"
               value="<%= product != null ? product.getRate() : "" %>">
      </div>

      <div>
        <input class="btn btn-primary" type="submit" value="Send" name="submit">
      </div>

      <input type="hidden" name="action" value="<%= action%>">

      <%
        if (action.equals("Edit")) {
      %>
      <input type="hidden" name="productId" value= "<%= product.getId()%>"> <!-- Nos permite facilitar el  ID del producto al realizar la acción de modificar o registrar -->

      <%
        }
      %>

      <div class="mb-2" id="result"></div>

    </form>
  </div>
</div>



<%@include file="includes/footer.jsp"%>