package ltweb.controller.user;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ltweb.entity.Category;
import ltweb.service.CategoryService;
import ltweb.service.impl.CategoryServiceImpl;

@WebServlet("/user/home")
public class HomeController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	CategoryService categoryService = new CategoryServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<Category> list = categoryService.findAll();
		req.setAttribute("cateList", list);
		
		RequestDispatcher rd = req.getRequestDispatcher("/views/user/home.jsp");
		rd.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	}
}