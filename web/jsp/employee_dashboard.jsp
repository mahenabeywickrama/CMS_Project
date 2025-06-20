<%--
  Created by IntelliJ IDEA.
  User: Mahen
  Date: 6/20/2025
  Time: 4:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.Complaint" %>
<%@ page import="com.example.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"EMPLOYEE".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    Complaint editComplaint = (Complaint) request.getAttribute("editComplaint");
    List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
    String formAction = (editComplaint != null) ? "editComplaint" : "submitComplaint";
%>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: left; }
        form { margin-bottom: 20px; }
        .btn { padding: 5px 10px; }
    </style>
</head>
<body>
<h2>Welcome, <%= user.getUsername() %>!</h2>
<a href="${pageContext.request.contextPath}/logout">Logout</a>

<h3><%= editComplaint != null ? "Edit Complaint" : "Submit New Complaint" %></h3>

<form action="${pageContext.request.contextPath}/<%= formAction %>" method="post">
    <% if (editComplaint != null) { %>
    <input type="hidden" name="id" value="<%= editComplaint.getId() %>" />
    <% } %>

    Title: <input type="text" name="title" required value="<%= editComplaint != null ? editComplaint.getTitle() : "" %>"/><br><br>
    Description:<br>
    <textarea name="description" rows="4" cols="50" required><%= editComplaint != null ? editComplaint.getDescription() : "" %></textarea><br><br>
    <input type="submit" class="btn" value="<%= editComplaint != null ? "Update" : "Submit" %> Complaint"/>
    <% if (editComplaint != null) { %>
    <a href="${pageContext.request.contextPath}/viewMyComplaints">Cancel</a>
    <% } %>
</form>

<h3>My Complaints</h3>
<table>
    <tr>
        <th>Title</th>
        <th>Description</th>
        <th>Status</th>
        <th>Remarks</th>
        <th>Date</th>
        <th>Time</th>
        <th>Actions</th>
    </tr>
    <%
        if (complaints != null && !complaints.isEmpty()) {
            for (Complaint c : complaints) {
    %>
    <tr>
        <td><%= c.getTitle() %></td>
        <td><%= c.getDescription() %></td>
        <td><%= c.getStatus() %></td>
        <td><%= c.getRemarks() != null ? c.getRemarks() : "-" %></td>
        <td><%= c.getDate() %></td>
        <td><%= c.getTime() %></td>
        <td>
            <% if (!"RESOLVED".equals(c.getStatus())) { %>
            <a href="editComplaint?id=<%= c.getId() %>">Edit</a> |
            <a href="deleteComplaint?id=<%= c.getId() %>" onclick="return confirm('Delete this complaint?')">Delete</a>
            <% } else { %>
            N/A
            <% } %>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr><td colspan="6">No complaints found.</td></tr>
    <% } %>
</table>
</body>
</html>

