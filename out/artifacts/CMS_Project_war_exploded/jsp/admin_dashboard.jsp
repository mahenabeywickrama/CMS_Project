<%--
  Created by IntelliJ IDEA.
  User: Mahen
  Date: 6/20/2025
  Time: 3:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.Complaint" %>
<%@ page import="com.example.model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"ADMIN".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
        form { margin: 0; }
        input[type="text"], select { width: 100%; }
    </style>
</head>
<body>

<h2>Welcome Admin: <%= user.getUsername() %></h2>
<a href="../logout">Logout</a>

<h3>All Complaints</h3>
<table>
    <tr>
        <th>ID</th>
        <th>User ID</th>
        <th>Title</th>
        <th>Description</th>
        <th>Status</th>
        <th>Remarks</th>
        <th>Update</th>
        <th>Delete</th>
    </tr>

    <%
        if (complaints != null && !complaints.isEmpty()) {
            for (Complaint c : complaints) {
    %>
    <tr>
        <form action="${pageContext.request.contextPath}/admin/updateComplaint" method="post">
            <td><%= c.getId() %></td>
            <td><%= c.getUserId() %></td>
            <td><%= c.getTitle() %></td>
            <td><%= c.getDescription() %></td>
            <td>
                <select name="status">
                    <option value="PENDING" <%= "PENDING".equals(c.getStatus()) ? "selected" : "" %>>PENDING</option>
                    <option value="IN_PROGRESS" <%= "IN_PROGRESS".equals(c.getStatus()) ? "selected" : "" %>>IN_PROGRESS</option>
                    <option value="RESOLVED" <%= "RESOLVED".equals(c.getStatus()) ? "selected" : "" %>>RESOLVED</option>
                </select>
            </td>
            <td>
                <input type="text" name="remarks" value="<%= c.getRemarks() == null ? "" : c.getRemarks() %>" />
            </td>
            <td>
                <input type="hidden" name="id" value="<%= c.getId() %>" />
                <input type="submit" value="Update" />
            </td>
            <td>
                <a href="${pageContext.request.contextPath}/deleteComplaint?id=<%= c.getId() %>"
                   onclick="return confirm('Delete this complaint?')">Delete</a>
            </td>
        </form>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="8">No complaints found.</td>
    </tr>
    <%
        }
    %>
</table>

</body>
</html>
