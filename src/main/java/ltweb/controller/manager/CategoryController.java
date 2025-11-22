package ltweb.controller.manager;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import ltweb.entity.Category;
import ltweb.entity.User;
import ltweb.service.CategoryService;
import ltweb.service.impl.CategoryServiceImpl;
import ltweb.util.Constant;

@WebServlet(urlPatterns = { "/manager/category", "/manager/category/add", "/manager/category/edit", "/manager/category/delete" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class CategoryController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	CategoryService categoryService = new CategoryServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String url = req.getRequestURI();
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		
		// Lấy thông tin Manager hiện tại
		HttpSession session = req.getSession();
		User user = (User) session.getAttribute("account");

		if (url.contains("category/add")) {
			req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
		} 
		
		else if (url.contains("category/edit")) {
			int id = Integer.parseInt(req.getParameter("id"));
			Category category = categoryService.findById(id);
			
			// Kiểm tra quyền: Chỉ sửa danh mục của chính mình
			if (category.getUser().getId() != user.getId()) {
				resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền sửa danh mục này!");
				return;
			}
			
			req.setAttribute("category", category);
			req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
		} 

		else if (url.contains("category/delete")) {
			try {
				int id = Integer.parseInt(req.getParameter("id"));
				Category category = categoryService.findById(id);
				
				// Kiểm tra quyền trước khi xóa
				if (category.getUser().getId() == user.getId()) {
					categoryService.delete(id);
				} else {
					resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền xóa danh mục này!");
					return;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			resp.sendRedirect(req.getContextPath() + "/manager/category");
		} 
		
		else {

			List<Category> list = categoryService.findByUserId(user.getId());
			
			req.setAttribute("cateList", list);

			req.setAttribute("myCateList", list); 
			
			req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String url = req.getRequestURI();
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		if (url.contains("category/add")) {
			insertCategory(req, resp);
		} else if (url.contains("category/edit")) {
			updateCategory(req, resp);
		}
	}

	private void insertCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		try {
			String name = req.getParameter("name");
			String imagePath = null;
			
			Part part = req.getPart("icon");
			if (part != null && part.getSize() > 0) {
				String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
				String finalFileName = System.currentTimeMillis() + "_" + filename;
				String uploadFolder = Constant.DIR + File.separator + "category";
				
				File uploadDir = new File(uploadFolder);
				if (!uploadDir.exists()) uploadDir.mkdirs();
				
				part.write(uploadFolder + File.separator + finalFileName);
				imagePath = "category" + File.separator + finalFileName;
			}

			Category category = new Category();
			category.setName(name);
			category.setImages(imagePath);
			category.setActive(1);

			// Gán người tạo là Manager đang đăng nhập
			HttpSession session = req.getSession();
			User user = (User) session.getAttribute("account");
			category.setUser(user);

			categoryService.insert(category);
			resp.sendRedirect(req.getContextPath() + "/manager/category");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void updateCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		try {
			int id = Integer.parseInt(req.getParameter("id"));
			Category category = categoryService.findById(id);
			
			HttpSession session = req.getSession();
			User user = (User) session.getAttribute("account");
			
			// Kiểm tra quyền sở hữu
			if (category.getUser().getId() != user.getId()) {
				resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Không có quyền!");
				return;
			}

			category.setName(req.getParameter("name"));
			
			Part part = req.getPart("icon");
			if (part != null && part.getSize() > 0) {
				String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
				String finalFileName = System.currentTimeMillis() + "_" + filename;
				String uploadFolder = Constant.DIR + File.separator + "category";
				part.write(uploadFolder + File.separator + finalFileName);
				category.setImages("category" + File.separator + finalFileName);
			}

			categoryService.update(category);
			resp.sendRedirect(req.getContextPath() + "/manager/category");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}