package ltweb.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ltweb.entity.User;


@WebFilter(urlPatterns = { "/admin/*", "/manager/*", "/user/*" })
public class AuthorizationFilter implements Filter {
	
	@SuppressWarnings("unused")
	private ServletContext context; // Ghi log hệ thống
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		this.context = filterConfig.getServletContext();
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		HttpSession session = req.getSession(false);
		
		boolean loggedIn = (session != null && session.getAttribute("account") != null);
		
		if (!loggedIn) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}
		
		User user = (User) session.getAttribute("account");
		int roleId = user.getRoleid();
		
		String uri = req.getRequestURI();
		
		boolean authorized = false;
		
		if (uri.contains("/admin/") && roleId == 3) {
			authorized = true;
		} else if (uri.contains("/manager/") && roleId == 2) {
			authorized = true;
		} else if (uri.contains("/user/") && roleId == 1) {
			authorized = true;
		}
		
		if (authorized) {
			chain.doFilter(request, response);
		} else {
			if (roleId == 3) resp.sendRedirect(req.getContextPath() + "/admin/home");
            else if (roleId == 2) resp.sendRedirect(req.getContextPath() + "/manager/home");
            else resp.sendRedirect(req.getContextPath() + "/user/home");
		}
	}
	
	@Override
	public void destroy() {}
}
