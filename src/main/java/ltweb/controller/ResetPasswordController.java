package ltweb.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ltweb.service.UserService;
import ltweb.service.impl.UserServiceImpl;

@WebServlet("/reset-password")
public class ResetPasswordController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/views/resetPassword.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setCharacterEncoding("UTF-8");
		req.setCharacterEncoding("UTF-8");
		
		String password = req.getParameter("password");
		String re_password = req.getParameter("re_password");
		
		// Kiểm tra mật khẩu có khớp không
		if (!password.equals(re_password)) {
			req.setAttribute("alert", "Mật khẩu nhập lại không khớp!");
			req.getRequestDispatcher("/views/resetPassword.jsp").forward(req, resp);
			return;
		}
		
		HttpSession session = req.getSession();
		// Lấy email đã lưu từ bước ForgotPasswordController
		String email = (String) session.getAttribute("resetEmail");
		
		if (email == null) {
			// Nếu session không có email
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}
		
		// Cap nhat password
		UserService service = new UserServiceImpl();
		service.updatePassword(email, password);
		
		// Xóa email khỏi session và chuyển về trang login
		session.removeAttribute("resetEmail");
		resp.sendRedirect(req.getContextPath() + "/login");
	}
	
}
