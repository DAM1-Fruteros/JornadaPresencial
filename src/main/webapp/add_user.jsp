<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.database.Database" %>
<%@ page import="org.example.dao.ProductDao" %>
<%@ page import="org.example.model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.dao.UserDao" %>
<%@ page import="org.example.model.User" %>
<%@ page import="org.example.exception.UserNotFoundException" %>


<%@include file="includes/header.jsp"%>

<%
    if ((currentSession.getAttribute("role") == null) || (!currentSession.getAttribute("role").equals("admin")) ){
        response.sendRedirect("/practicas_app/login.jsp");
    }
%>

<script type="text/javascript">
    $(document).ready(function() {
        $("form").on("submit", function(event) {
            event.preventDefault();
            const formValue = $(this).serialize();
            $.ajax({
                url:"add_user",
                type: "POST",
                data: formValue,
                statusCode: {
                    200: function(response) {
                        console.log("Respuesta del servidor:", response);
                        if (response === "ok") {
                            window.location.href = "/practicas_app/users.jsp";
                        } else {
                            $("#result").html("<div class='alert alert-danger' role='alert'>" + response + "</div>");
                        }
                    },
                    404: function (response) {
                        $("#result").html("<div class='alert alert-danger' role='alert'>Error al enviar datos</div>");
                    },
                    500: function(response){
                        console.error("Server error:", response);
                        $("#result").html("<div class='alert alert-danger' role='alert' " + response.toString() + "</div>");
                    }
                }
            });
        });
    });
</script>


<div class="container mt-5">
    <h2 class="mb-4">New User</h2>
    <form method="post" id="usuario-form"  class="shadow p-4 bg-white rounded">
        <div class="mb-3">
            <label for="name" class="form-label">Name</label>
            <input type="text" class="form-control" id="name" name="name" >
        </div>
        <div class="mb-3">
            <label for="surname" class="form-label">Surname</label>
            <input type="text" class="form-control" id="surname" name="surname">
        </div>
        <div class="mb-3">
            <label for="birthdate" class="form-label">Birthdate</label>
            <input type="date" class="form-control" id="birthdate" name="birthdate" required>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email">
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password">
        </div>
        <div class="mb-3">
            <label for="role" class="form-label">Role</label>
            <select class="form-select" id="role" name="role" >
                <option value="">Select rol</option>
                <option value="admin">Admin</option>
                <option value="usuario">User</option>
            </select>
        </div>
        <div class="mb-3">
            <label for="active" class="form-label">Active</label>
            <select class="form-select" id="active" name="active">
                <option value="">Select option</option>
                <option value="true" >Yes</option>
                <option value="false">No</option>
            </select>
        </div>


        <input class="btn btn-primary" type="submit" value="Register">
        <!--<button type="submit" class="btn btn-primary">Guardar Usuario</button>-->
        <a href="users.jsp" class="btn btn-secondary ms-2">Abort</a>

    </form>
    <div id="result"> </div>
</div>

<%@include file="includes/footer.jsp"%>