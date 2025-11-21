package ltweb.controller.admin;

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

@WebServlet(urlPatterns = { "/admin/category/list", "/admin/category/add", "/admin/category/edit", "/admin/category/delete" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class CategoryController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	CategoryService categoryService = new CategoryServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String url = req.getRequestURI().toString();
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		
		if (url.contains("category/add")) {
			req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
			
		} else if (url.contains("category/edit")) {
			int id = Integer.parseInt(req.getParameter("id"));
			req.setAttribute("category", categoryService.findById(id));
			req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
			
		} else if (url.contains("category/delete")) {
			try {
				int id = Integer.parseInt(req.getParameter("id"));
				categoryService.delete(id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			resp.sendRedirect(req.getContextPath() + "/admin/category/list");
			
		} else {
			List<Category> list = categoryService.findAll();
            req.setAttribute("cateList", list);
            
            HttpSession session = req.getSession();
            User user = (User) session.getAttribute("account");
            if (user != null) {
                List<Category> myList = categoryService.findByUserId(user.getId());
                req.setAttribute("myCateList", myList);
            }
            
			req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);
		}
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String url = req.getRequestURI().toString();
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		
		if (url.contains("category/add")) {
			insertCategory(req, resp);
		} else if (url.contains("category/edit")) {
			updateCategory(req, resp);
		}
	}
	
	private void insertCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		try {
			String name = req.getParameter("name");
			
			String imagePath = null;
			Part part = req.getPart("icon"); // "icon" là name của input file trong JSP
			
			if (part != null && part.getSize() > 0) {
				String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
				
				String finalFileName = System.currentTimeMillis() + "_" + filename;
				String uploadFolder = Constant.DIR + File.separator + "category";
				File uploadDir = new File(uploadFolder);
				if (!uploadDir.exists()) {
					uploadDir.mkdirs();
				}
				
				part.write(uploadFolder + File.separator + finalFileName);
				imagePath = "category" + File.separator + finalFileName;
			}
			
			Category category = new Category();
			category.setName(name);
			category.setImages(imagePath);
			category.setActive(1);
			
			HttpSession session = req.getSession();
            User user = (User) session.getAttribute("account");
            category.setUser(user); // Gán User hiện tại là người tạo
			
			categoryService.insert(category);
			resp.sendRedirect(req.getContextPath() + "/admin/category/list");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void updateCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		try {
			
			int id = Integer.parseInt(req.getParameter("id"));
			String name = req.getParameter("name");
			
			Category category = categoryService.findById(id);
			category.setName(name);
			
			Part part = req.getPart("icon");
			if (part != null && part.getSize() > 0) {
				String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
				
				String finalFileName = System.currentTimeMillis() + "_" + filename;
				String uploadFolder = Constant.DIR + File.separator + "category";
				File uploadDir = new File(uploadFolder);
				if (!uploadDir.exists()) {
					uploadDir.mkdirs();
				}
				
				part.write(uploadFolder + File.separator + finalFileName);
				String imagePath = "category" + File.separator + finalFileName;
				category.setImages(imagePath);
			}
			
			categoryService.update(category);
			resp.sendRedirect(req.getContextPath() + "/admin/category/list");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
