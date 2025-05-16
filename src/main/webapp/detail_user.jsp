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
    int usuarioId = Integer.parseInt(request.getParameter("usuario_id"));
    Database database = new Database();
    database.connect();
    UserDao userDao = new UserDao(database.getConnection());
    try{
        User usuario = userDao.getUser(usuarioId);
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



/********/
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-7">
            <div class="card shadow-lg rounded-2">
                <div class="card-header bg-black text-white text-center">
                    <h3 class="mb-0">Detalle del Usuario</h3>
                </div>
                <div class="card-body p-4">
                    <p><strong>Nombre:</strong> <%= usuario.getNombre() %></p>
                    <p><strong>Apellidos:</strong> <%= usuario.getApellido() %></p>
                    <p><strong>Fecha Nacimiento:</strong> <%= usuario.getFechaNacimiento() %></p>
                    <p><strong>Edad:</strong> <%= usuario.getEdad() %></p>
                    <p><strong>Email:</strong> <%= usuario.getEmail() %></p>
                    <% if (role.equals ("admin")){
                    %>
                    <p><strong>Rol:</strong> <%= usuario.getRole() %></p>
                    <p><strong>Activo:</strong> <%= usuario.isActivo() ? "SI" : "No" %></p>
                    <p><strong>Valoración:</strong> <%= usuario.getValoracion() %></p>
                    <% }
                    %>
                </div>
                <div class="card-footer text-end">
                    <% if (role.equals("usuario")){
                    %>
                    <a href="index.jsp" class="btn btn-secondary btn-sm">Volver</a>
                    <a href="edit_usuario.jsp?usuario_id=<%=usuario.getId()%>" class="btn btn-warning btn-sm">Editar</a>

                    <%
                    }else if (role.equals("admin")){
                    %>
                    <a href="usuarios.jsp" class="btn btn-secondary btn-sm">Volver</a>
                    <a href="edit_usuario.jsp?usuario_id=<%=usuario.getId()%>" class="btn btn-warning btn-sm">Editar</a>
                    <a href="delete_usuario?usuario_id=<%=usuario.getId()%>" class="btn btn-danger btn-sm" onclick="return confirm('¿Desea eliminar permanentemente?')">Eliminar</a>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </div>
</div>

<%
} catch ( UsuarioNotFoundException unfe){
%>
<%@ include file="includes/usuario_not_found.jsp"%>
<%
    }
%>

<%@include file="includes/footer.jsp"%>