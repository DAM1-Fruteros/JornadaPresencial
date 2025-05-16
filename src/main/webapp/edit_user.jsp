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
    if ((currentSession.getAttribute("role") == null) || (currentSession.getAttribute("id") == null)){
        response.sendRedirect("peliculas_app/login.jsp");
    }
    int userId = Integer.parseInt(request.getParameter("user_id"));
    if (!role.equals("admin") && userId != userId) {
        response.sendRedirect("practicas_app/login.jsp");
    }
    Database database = new Database();
    database.connect();
    UserDao userDao = new UserDao(database.getConnection());
    try{
        User user = userDao.getUser(userId);
%>

<script type="text/javascript">
    $(document).ready(function() {
        $("form").on("submit", function(event) {
            event.preventDefault();
            const formValue = $(this).serialize();
            $.ajax({
                url:"edit_user",
                type: "POST",
                data: formValue,
                statusCode: {
                    200: function(response) {
                        console.log("Respuesta del servidor:", response);
                        if (response === "ok") {
                            window.location.href = "/practicas_app/detail_user.jsp?user_id=<%=user.getId()%>";
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
    <h2 class="mb-4">Modify user</h2>
    <form method="post" id="user_edit-form"  class="shadow p-4 bg-white rounded">
        <div class="mb-3">
            <label for="name" class="form-label">Name</label>
            <input type="text" class="form-control" id="name" name="name" value="<%=user.getName()%>">
        </div>
        <div class="mb-3">
            <label for="surname" class="form-label">Surname</label>
            <input type="text" class="form-control" id="surname" name="surname" value="<%=user.getSurname()%>">
        </div>
        <div class="mb-3">
            <label for="birthdate" class="form-label">Birthdate</label>
            <input type="date" class="form-control" id="birthdate" name="birthdate" value="<%=user.getBirthdate()%>" required>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email" value="<%=user.getEmail()%>" <%= "user".equals(user.getRole()) ? "readonly" : "" %> >
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" value ="<%=user.getPassword()%>" >
        </div>

        <%
            if (role.equals("admin")) {
        %>
        <div class="mb-3">
            <label for="role" class="form-label">Rol</label>
            <select class="form-select" id="role" name="role" >
                <option disabled value="">Seleccione un rol</option>
                <option value="admin" <%= "admin".equals(user.getRole()) ? "selected" : "" %>>Admin</option>
                <option value="user" <%= "user".equals(user.getRole()) ? "selected" : "" %>>User</option>
            </select>
        </div>
        <div class="mb-3">
            <label for="active" class="form-label">Active</label>
            <select class="form-select" id="active" name="active" required>
                <option disabled value="">Select an option</option>
                <option value="true" <%= user.isActive() ? "selected" : "" %>>Yes</option>
                <option value="false" <%= !user.isActive() ? "selected" : "" %>>No</option>
            </select>
        </div>
        <%
        } else {
        %>
        <div class="mb-3">
            <label for="role" class="form-label">Rol</label>
            <input type="text" class="form-control" name="role" value="<%= user.getRole() %>" readonly>
        </div>
        <input type="hidden" name="active" value="<%= user.isActive() %>">
        <input type="hidden" name="role" value="<%= user.getRole() %>">

        <%
            }
        %>
        <input class="btn btn-primary" type="submit" value="Modificar" onclick="return confirm('¿Desea confirmar?')">
        <!--<button type="submit" class="btn btn-primary">Guardar Usuario</button>-->
        <a href="detail_user.jsp?user_id=<%=user.getId()%>" class="btn btn-secondary ms-2">Cancelar</a>

        <input type="hidden" name="id" value="<%= userId %>">
        <div id="result"></div>
    </form>
</div>

<%
}catch (UserNotFoundException unfe) {
%>
<%@ include file="includes/user_not_found.jsp"%>
<%
    }
%>

<%@include file="includes/footer.jsp"%>