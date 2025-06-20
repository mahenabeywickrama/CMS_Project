package com.example.controller;

import com.example.dao.ComplaintDAO;
import com.example.model.Complaint;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/complaints")
public class AdminViewServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ServletContext servletContext = req.getServletContext();
        BasicDataSource ds = (BasicDataSource) servletContext.getAttribute("ds");

        ComplaintDAO complaintDAO = new ComplaintDAO(ds);

        List<Complaint> complaints = complaintDAO.getAllComplaints();
        req.setAttribute("complaints", complaints);
        req.getRequestDispatcher("/jsp/admin_dashboard.jsp").forward(req, resp);
    }
}
