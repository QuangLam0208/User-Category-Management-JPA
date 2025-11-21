package ltweb.controller;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import ltweb.entity.User;
import ltweb.service.UserService;
import ltweb.service.impl.UserServiceImpl;
import ltweb.util.Constant;

@WebServlet(urlPatterns = {"/profile", "/admin/profile", "/manager/profile"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,
		maxFileSize = 1024 * 1024 * 10,
		maxRequestSize = 1024 * 1024 * 50)
public class ProfileController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	UserService userService = new UserServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("account") == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("account") == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}
		
		User user = (User) session.getAttribute("account");

		String fullname = req.getParameter("fullname");
		String phone = req.getParameter("phone");

		Part part = req.getPart("images");
		
		String fileName = null;
		if (part != null && part.getSize() > 0) {
			
			String submittedFileName = part.getSubmittedFileName();
			if (submittedFileName != null && !submittedFileName.isEmpty()) {
				String ext = submittedFileName.substring(submittedFileName.lastIndexOf(".") + 1);
				fileName = System.currentTimeMillis() + "." + ext;
				
				String uploadPath = Constant.DIR + File.separator + "user";
				File uploadDir = new File(uploadPath);
				if (!uploadDir.exists()) {
					uploadDir.mkdirs();
				}
				
				part.write(uploadPath + File.separator + fileName);
				
				user.setImages("user" + File.separator + fileName);
			}
		}
		
		user.setFullname(fullname);
		user.setPhone(phone);

		try {
			userService.update(user);
			
			session.setAttribute("account", user);
			
			req.setAttribute("message", "Cập nhật thông tin thành công!");
		} catch (Exception e) {
			e.printStackTrace();
			req.setAttribute("error", "Cập nhật thất bại: " + e.getMessage());
		}

		req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
	}
}