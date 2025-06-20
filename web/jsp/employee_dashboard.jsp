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
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Employee Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="../css/employee_styles.css" rel="stylesheet" />
</head>
<body>

<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-3">
        <h3 class="mb-3 mt-3">Welcome, <%= user.getUsername() %> !</h3>
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-secondary logout-btn">Logout</a>
    </div>

    <div class="card form-section p-4 mb-5">
        <h5 class="mb-4 text-primary fw-bold"><%= editComplaint != null ? "Edit Complaint" : "Submit New Complaint" %></h5>
        <form action="${pageContext.request.contextPath}/<%= formAction %>" method="post" novalidate>
            <% if (editComplaint != null) { %>
            <input type="hidden" name="id" value="<%= editComplaint.getId() %>" />
            <% } %>

            <div class="form-floating mb-3" style="max-width: 600px;">
                <input type="text" class="form-control" id="title" name="title" placeholder="Complaint Title" required
                       value="<%= editComplaint != null ? editComplaint.getTitle() : "" %>"/>
                <label for="title">Title</label>
            </div>
            <div class="form-floating mb-3" style="max-width: 600px;">
                <textarea class="form-control" id="description" name="description" placeholder="Complaint Description" style="height: 120px" required><%= editComplaint != null ? editComplaint.getDescription() : "" %></textarea>
                <label for="description">Description</label>
            </div>

            <div class="btn-group">
                <button type="submit" class="btn btn-primary px-4 py-2">
                    <%= editComplaint != null ? "Update" : "Submit" %> Complaint
                </button>
                <% if (editComplaint != null) { %>
                <a href="${pageContext.request.contextPath}/viewMyComplaints" class="btn btn-outline-secondary px-4 py-2">Cancel</a>
                <% } %>
            </div>
        </form>
    </div>

    <div class="card p-4">
        <h5 class="mb-3 text-primary fw-bold">My Complaints</h5>
        <div class="table-responsive" style="max-height: 450px; overflow-y: auto;">
            <table class="table table-bordered table-hover align-middle mb-0">
                <thead class="table-light">
                <tr>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Status</th>
                    <th>Remarks</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th style="min-width: 150px;">Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    if (complaints != null && !complaints.isEmpty()) {
                        for (Complaint c : complaints) {
                            String statusClass = "";
                            if ("PENDING".equalsIgnoreCase(c.getStatus())) statusClass = "status-pending";
                            else if ("IN_PROGRESS".equalsIgnoreCase(c.getStatus())) statusClass = "status-inprogress";
                            else if ("RESOLVED".equalsIgnoreCase(c.getStatus())) statusClass = "status-resolved";
                %>
                <tr>
                    <td><%= c.getTitle() %></td>
                    <td><%= c.getDescription() %></td>
                    <td><span class="status-badge <%= statusClass %>"><%= c.getStatus().replace('_', ' ') %></span></td>
                    <td><%= c.getRemarks() != null && !c.getRemarks().isEmpty() ? c.getRemarks() : "-" %></td>
                    <td><%= c.getDate() %></td>
                    <td><%= c.getTime() %></td>
                    <td class="table-actions">
                        <% if (!"RESOLVED".equalsIgnoreCase(c.getStatus())) { %>
                        <a href="editComplaint?id=<%= c.getId() %>" class="btn btn-sm btn-outline-warning" title="Edit">
                            <i class="bi bi-pencil"></i> Edit
                        </a>
                        <a href="deleteComplaint?id=<%= c.getId() %>" class="btn btn-sm btn-outline-danger"
                           onclick="return confirm('Delete this complaint?')" title="Delete">
                            <i class="bi bi-trash"></i> Delete
                        </a>
                        <% } else { %>
                        <span class="text-muted">N/A</span>
                        <% } %>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="7" class="text-center text-muted py-4">No complaints found.</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
