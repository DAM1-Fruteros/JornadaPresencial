<%@ page import="org.example.database.Database" %>
<%@ page import="org.example.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.dao.UserDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>

<%
    if ((currentSession.getAttribute("role") == null) || (!currentSession.getAttribute("role").equals("admin")) ){
        response.sendRedirect("/practicas_app/login.jsp");
    }
%>

<%
    String search = request.getParameter("search");
%>

    <div class="container py-5">
        <div class="row mb-4">
            <div class="col-md-8">
                <h2 class="mb-0">User Management</h2>
            </div>
            <div class="col-md-4 text-md-end">
                <a href="add_user.jsp" class="btn btn-primary"><i class="bi bi-plus-circle me-2"></i>New User</a>
            </div>
        </div>

        <div class="card mb-4">
            <div class="card-body p-3">
                <div class="row g-3">
                    <div class="col-md-4">
                        <form  method="get" action="<%=request.getRequestURI()%>" class="input-group">
                            <span class="input-group-text bg-white border-end-0"><i class="bi bi-search"></i></span>
                            <input type="text" name="search" id="search" class="form-control border-start-0" placeholder="Buscar por nombre" value="<%= search != null ? search : "" %>" >
                        </form>
                    </div>


                </div>
            </div>
        </div>

        <div class="table-container bg-white">
            <table class="table table-hover mb-0">
                <thead>
                    <tr>
                        <th scope="col">Usuario</th>
                        <th scope="col">Email</th>
                        <th scope="col">Estado</th>
                        <th scope="col" class="text-center">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    Database database = new Database();
                    database.connect();
                    UserDao userDao = new UserDao(database.getConnection());
                    List<User> userList = userDao.getUsers(search);

                    for (User user : userList) {
                %>

                <!-- Usuarios -->
                    <tr>
                        <td>
                            <div class="d-flex align-items-center">
                                <div>
                                    <h6 class="mb-0"><%= user.getName() %></h6>
                                </div>
                            </div>
                        </td>
                        <td><%=user.getEmail()%></td>
                        <td>
                            <span class="user-status <%= user.isActive() ? "status-active" : "status-inactive" %>"></span>
                            <%= user.isActive() ? "ACTIVE" : "NO ACTIVE" %>
                        </td>
                        <td class="text-center">
                            <a href="detail_user.jsp?user_id=<%=user.getId()%>" class="btn btn-sm btn-outline-primary btn-custom">
                                <i class="bi bi-eye me-1"></i>Detalles
                            </a>
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>

                <script>
                    document.addEventListener("DOMContentLoaded", () => {
                        const tabla = document.querySelector(".table");
                        if (!tabla) {
                            console.warn("No se encontró la tabla");
                            return;
                        }

                        const filas = tabla.querySelectorAll("tbody tr");
                        const itemsPagina = 6;
                        let paginaActual = 1;
                        const totalPaginas = Math.ceil(filas.length / itemsPagina);

                        console.log("Filas encontradas:", filas.length);
                        console.log("Total páginas:", totalPaginas);

                        function mostrarPagina(pagina) {
                            filas.forEach((fila, index) => {
                                fila.style.display = ((index >= (pagina - 1) * itemsPagina) && (index < pagina * itemsPagina)) ? "table-row" : "none";
                            });
                        }

                        const btnAnterior = document.getElementById("btn_anterior");
                        const btnSiguiente = document.getElementById("btn_siguiente");

                        if (!btnAnterior || !btnSiguiente) {
                            console.warn("Botones de paginación no encontrados");
                            return;
                        }

                        btnAnterior.addEventListener("click", () => {
                            if (paginaActual > 1) {
                                paginaActual--;
                                mostrarPagina(paginaActual);
                            }
                        });

                        btnSiguiente.addEventListener("click", () => {
                            if (paginaActual < totalPaginas) {
                                paginaActual++;
                                mostrarPagina(paginaActual);
                            }
                        });

                        mostrarPagina(paginaActual);
                    });
                </script>


            </table>
        </div>

    </div>

    <div class="d-flex justify-content-center mt-4">
        <button id="btn_anterior" class="btn btn-outline-secondary  me-1">Anterior</button>
        <button id="btn_siguiente" class="btn btn-outline-secondary">Siguiente</button>
    </div>




<%@include file="includes/footer.jsp"%>
