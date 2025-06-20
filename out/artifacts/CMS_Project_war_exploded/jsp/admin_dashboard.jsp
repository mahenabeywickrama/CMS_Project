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
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="../css/admin_styles.css" rel="stylesheet" />
</head>
<body>

<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-3">
        <h3 class="mb-3 mt-3">Welcome Admin: <%= user.getUsername() %> !</h3>
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-secondary logout-btn">Logout</a>
    </div>

    <div class="card p-4">
        <h5 class="mb-3 text-primary fw-bold">All Complaints</h5>
        <div class="table-responsive" style="max-height: 450px; overflow-y: auto;">
            <table class="table table-bordered table-hover align-middle mb-0">
                <thead class="table-light">
                <tr>
                    <th>ID</th>
                    <th>User ID</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Status</th>
                    <th>Remarks</th>
                    <th style="min-width: 120px;">Update</th>
                    <th style="min-width: 120px;">Delete</th>
                </tr>
                </thead>
                <tbody>
                <%
                    if (complaints != null && !complaints.isEmpty()) {
                        for (Complaint c : complaints) {
                %>
                <tr>
                    <form action="${pageContext.request.contextPath}/admin/updateComplaint" method="post" class="d-flex gap-2 align-items-center">
                        <td><%= c.getId() %></td>
                        <td><%= c.getUserId() %></td>
                        <td><%= c.getTitle() %></td>
                        <td><%= c.getDescription() %></td>
                        <td style="min-width: 150px;">
                            <select name="status" class="form-select form-select-sm" required>
                                <option value="PENDING" <%= "PENDING".equals(c.getStatus()) ? "selected" : "" %>>PENDING</option>
                                <option value="IN_PROGRESS" <%= "IN_PROGRESS".equals(c.getStatus()) ? "selected" : "" %>>IN_PROGRESS</option>
                                <option value="RESOLVED" <%= "RESOLVED".equals(c.getStatus()) ? "selected" : "" %>>RESOLVED</option>
                            </select>
                        </td>
                        <td>
                            <input type="text" name="remarks" class="form-control form-control-sm"
                                   value="<%= c.getRemarks() == null ? "" : c.getRemarks() %>" />
                        </td>
                        <td>
                            <input type="hidden" name="id" value="<%= c.getId() %>" />
                            <button type="submit" class="btn btn-sm btn-primary px-3 py-1">Update</button>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/deleteComplaint?id=<%= c.getId() %>"
                               onclick="return confirm('Delete this complaint?')"
                               class="btn btn-sm btn-outline-danger px-3 py-1">
                                <i class="bi bi-trash"></i> Delete
                            </a>
                        </td>
                    </form>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="8" class="text-center text-muted py-4">No complaints found.</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>