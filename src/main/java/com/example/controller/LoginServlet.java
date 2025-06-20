package com.example.controller;

import com.example.dao.UserDAO;
import com.example.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = userDAO.validateUser(username, password);

        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);

            if ("ADMIN".equals(user.getRole())) {
                resp.sendRedirect("jsp/admin_dashboard.jsp");
            } else {
                resp.sendRedirect("jsp/employee_dashboard.jsp");
            }
        } else {
            req.setAttribute("error", "Invalid username or password");
            req.getRequestDispatcher("jsp/login.jsp").forward(req, resp);
        }
    }
}
