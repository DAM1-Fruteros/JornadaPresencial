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
    userId = Integer.parseInt(request.getParameter("user_id"));
    Database database = new Database();
    database.connect();
    UserDao userDao = new UserDao(database.getConnection());
    try{
        User user = userDao.getUser(userId);
%>


<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-7">
            <div class="card shadow-lg rounded-2">
                <div class="card-header bg-white text-black text-center">
                    <h3 class="mb-0">Detail of User</h3>
                </div>
                <div class="card-body p-4">
                    <p><strong>Name:</strong> <%= user.getName() %></p>
                    <p><strong>Surname:</strong> <%= user.getSurname() %></p>
                    <p><strong>Birthdate:</strong> <%= user.getBirthdate() %></p>
                    <p><strong>Email:</strong> <%= user.getEmail() %></p>
                    <p><strong>Rol:</strong> <%= user.getRole() %></p>
                    <p><strong>Active:</strong> <%= user.isActive() ? "Yes" : "No" %></p>
                </div>

                <div class="card-footer text-end">
                    <a href="users.jsp" class="btn btn-secondary btn-sm">Return</a>
                    <a href="edit_user.jsp?user_id=<%=user.getId()%>" class="btn btn-warning btn-sm">Edit</a>
                    <a href="delete_user?user_id=<%=user.getId()%>" class="btn btn-danger btn-sm" onclick="return confirm('Do you want to delete permanently?')">Delete</a>
                </div>
            </div>
        </div>
    </div>
</div>

<%
} catch ( UserNotFoundException unfe){
%>
<%@ include file="includes/user_not_found.jsp"%>
<%
    }
%>

<%@include file="includes/footer.jsp"%>