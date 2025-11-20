package ltweb.controller.admin;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ltweb.entity.User;
import ltweb.service.UserService;
import ltweb.service.impl.UserServiceImpl;

@WebServlet("/admin/users")
public class UserController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	UserService userService = new UserServiceImpl();
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<User> list = userService.findAll();
		req.setAttribute("list", list);
		
		RequestDispatcher rd = req.getRequestDispatcher("/views/admin/users/list.jsp");
		rd.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
}
