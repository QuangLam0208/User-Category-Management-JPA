package ltweb.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ltweb.service.impl.UserServiceImpl;
import ltweb.service.UserService;

@WebServlet("/register")
public class RegisterController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	UserService service = new UserServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session != null && session.getAttribute("account") != null) {
			resp.sendRedirect(req.getContextPath() + "/home");
			return;
		}
		req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		resp.setCharacterEncoding("UTF-8");
		req.setCharacterEncoding("UTF-8");
		
		// Lấy tham số từ request
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		String email = req.getParameter("email");
		String fullname = req.getParameter("fullname");
		String phone = req.getParameter("phone");
		String re_password = req.getParameter("re_password");
		
		String alertMsg = "";
		
		// Kiểm tra mật khẩu nhập lại
		if (!password.equals(re_password)) {
			alertMsg = "Mật khẩu nhập lại không khớp!";
			req.setAttribute("alert", alertMsg);
			req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
			return;
		}
		
		// Kiểm tra email đã tồn tại
		if (service.checkExistEmail(email)) {
			alertMsg = "Email đã tồn tại!";
			req.setAttribute("alert", alertMsg);
			req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
			return;
		}
		
		// Kiem tra username đã tồn tại
		if (service.findByUsername(username) != null) {
			alertMsg = "Tên đăng nhập đã tồn tại!";
			req.setAttribute("alert", alertMsg);
			req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
			return;
		}
		
		// Kiem tra phone đã tồn tại
		if (service.checkExistPhone(phone)) {
			alertMsg = "Số điện thoại đã tồn tại!";
			req.setAttribute("alert", alertMsg);
			req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
			return;
		}
		
		// Đăng ký tài khoản
		boolean isSuccess = service.register(email, username, fullname, password, phone);
		if (isSuccess) {
			resp.sendRedirect(req.getContextPath() + "/login");
		} else {
			alertMsg = "Đăng ký thất bại! Vui lòng thử lại.";
			req.setAttribute("alert", alertMsg);
			req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
		}
	}
}
