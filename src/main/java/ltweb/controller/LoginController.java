package ltweb.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ltweb.entity.User;
import ltweb.service.UserService;
import ltweb.service.impl.UserServiceImpl;

@WebServlet("/login")
public class LoginController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	UserService service = new UserServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session != null && session.getAttribute("account") != null) {
			User user = (User) session.getAttribute("account");
			redirectByRole(req, resp, user); // Chuyển hướng theo role
			return;
		}
		
		// Check cookie
		Cookie[] cookies = req.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("username")) { 
					String username = cookie.getValue();
					User user = service.findByUsername(username); 
					
					if (user != null) {
						// Tự động đăng nhập lại
						session = req.getSession(true);
						session.setAttribute("account", user); 
						
						redirectByRole(req, resp, user); // Chuyển hướng theo role
						return;
					}
				}
			}
		}
		
		req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		resp.setCharacterEncoding("UTF-8");
		req.setCharacterEncoding("UTF-8");

		// Lấy tham số từ request
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		
		// Kiểm tra checkbox Remember Me
		String remember = req.getParameter("rememberMe"); 
		boolean isRememberMe = "on".equals(remember);
		
		String alertMsg = "";
		
		// Xác thực người dùng
		if (username.isEmpty() || password.isEmpty()) {
			alertMsg = "Tài khoản hoặc mật khẩu không được rỗng";
			req.setAttribute("alert", alertMsg);
			req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
			return;
		}
		
		User user = service.login(username, password);
		
		if (user != null) {
			// Login thành công
			HttpSession session = req.getSession(true);
			session.setAttribute("account", user); // Lưu thông tin user vào session
			
			// Xử lý Remember Me
			if (isRememberMe) {
				saveRememberMe(req, resp, username);
			}
			
			redirectByRole(req, resp, user); // Chuyển hướng theo role
			
		} else {
			// Login thất bại
			alertMsg = "Tài khoản hoặc mật khẩu không đúng";
			req.setAttribute("alert", alertMsg);
			req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
		}
	}
	
	private void saveRememberMe(HttpServletRequest req, HttpServletResponse resp, String username) {
		Cookie cookie = new Cookie("username", username);
		cookie.setMaxAge(1 * 24 * 60 * 60); // Lưu trong 1 ngày
		cookie.setPath(req.getContextPath());
		resp.addCookie(cookie);
	}
	
	private void redirectByRole(HttpServletRequest req, HttpServletResponse resp, User user) throws IOException {
		// 1-User, 2-Manager, 3-Admin
		int roleId = user.getRoleid();
		
		String contextPath = req.getContextPath();
		
		if (roleId == 3) {
			resp.sendRedirect(contextPath + "/admin/home");
		} else if (roleId == 2) {
			resp.sendRedirect(contextPath + "/manager/home");
		} else {
			resp.sendRedirect(contextPath + "/user/home");
		}
	}
}
