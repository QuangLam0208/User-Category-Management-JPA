package ltweb.controller.user;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ltweb.entity.Category;
import ltweb.entity.Video;
import ltweb.service.CategoryService;
import ltweb.service.VideoService;
import ltweb.service.impl.CategoryServiceImpl;
import ltweb.service.impl.VideoServiceImpl;

@WebServlet("/user/video")
public class VideoController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	VideoService videoService = new VideoServiceImpl();
	CategoryService categoryService = new CategoryServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cateIdStr = req.getParameter("categoryId");
		
		if (cateIdStr != null) {
			try {
				int cateId = Integer.parseInt(cateIdStr);
				
				// 1. Lấy danh sách video của Category này
				List<Video> list = videoService.findByCategoryId(cateId);
				
				// 2. Lấy thông tin Category để hiện tiêu đề
				Category category = categoryService.findById(cateId);
				
				req.setAttribute("videos", list);
				req.setAttribute("category", category);
				
				req.getRequestDispatcher("/views/user/video-list.jsp").forward(req, resp);
				
			} catch (NumberFormatException e) {
				resp.sendRedirect(req.getContextPath() + "/user/home");
			}
		} else {
			resp.sendRedirect(req.getContextPath() + "/user/home");
		}
	}
}