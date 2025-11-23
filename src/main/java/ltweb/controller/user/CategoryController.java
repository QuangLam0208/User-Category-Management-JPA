package ltweb.controller.user;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ltweb.entity.Category;
import ltweb.service.CategoryService;
import ltweb.service.impl.CategoryServiceImpl;

@WebServlet("/user/category")
public class CategoryController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	CategoryService categoryService = new CategoryServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<Category> list = categoryService.findAll();
        req.setAttribute("cateList", list);
        
        req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.sendError(HttpServletResponse.SC_FORBIDDEN, "User không có quyền thực hiện hành động này!");
	}
	
}