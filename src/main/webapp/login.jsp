<%@page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>


<script type="text/javascript">
  $(document).ready(function() {
    $("form").on("submit", function(event) {
      event.preventDefault();
      const formValue = $(this).serialize();
      $.ajax("login", {
        type: "POST",
        data: formValue,
        statusCode: {
          200: function(response) {
            if (response === "ok") {
              window.location.href = "/practicas_app";
            } else {
              $("#result").html("<div class='alert alert-danger' role='alert'>"+ response +"</div>");
            }
          }
        }
      });
    });
  });
</script>

<div class="container py-5">
<main class="form-signin w-100 m-auto">
  <div class="container d-flex justify-content-center">
    <form>
      <h1>Electronic devices <i class="fa-solid fa-mobile"></i></h1>
      <h3 class="h3 mb-3 fw-normal">Register</h3>

      <div class="form-floating mb-2" >
        <input type="email" class="form-control" id="floatingInput" name="email">
        <label for="floatingInput">Email</label>
      </div>
      <div class="form-floating mb-2">
        <input type="password" class="form-control" id="floatingPassword" name="password">
        <label for="floatingPassword">Password</label>
      </div>
      <div class="mb-2">
        <input class="btn btn-warning w-100 py-2" type="submit" value="Login">
      </div>

      <div class="mb-2" id="result"></div>
    </form>
  </div>
</main>
</div>
<%@include file="includes/footer.jsp"%>