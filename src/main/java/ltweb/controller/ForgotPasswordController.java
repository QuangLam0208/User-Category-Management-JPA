package ltweb.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ltweb.service.UserService;
import ltweb.service.impl.UserServiceImpl;

@WebServlet("/forgot-password")
public class ForgotPasswordController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/views/forgotPassword.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setCharacterEncoding("UTF-8");
		req.setCharacterEncoding("UTF-8");
		
		UserService service = new UserServiceImpl();
		String email = req.getParameter("email");
		
		boolean emailExists = service.checkExistEmail(email);
		
		if (emailExists) {
			// Email tồn tại, lưu email vào session để dùng ở ResetPasswordController
			req.getSession().setAttribute("resetEmail", email);
			resp.sendRedirect(req.getContextPath()+"/reset-password");
		} else {
			req.setAttribute("alert", "Email does not exist!");
			req.getRequestDispatcher("/views/forgotPassword.jsp").forward(req, resp);
		}
	}
}
