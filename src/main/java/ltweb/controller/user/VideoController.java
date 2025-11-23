package ltweb.controller.user;

import java.io.IOException;
import java.util.ArrayList;
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
		String keyword = req.getParameter("keyword");
		
		List<Video> list = new ArrayList<>();
		Category category = null;
		
		try {
			// có categoryid (Vào từ trang Home hoặc tìm kiếm trong Category)
			if (cateIdStr != null && !cateIdStr.isEmpty()) {
				int cateId = Integer.parseInt(cateIdStr);
				category = categoryService.findById(cateId);
				
				if (keyword != null && !keyword.isEmpty()) {
					// tìm trong Category cụ thể
					list = videoService.findByTitleAndCategoryId(keyword, cateId);
				} else {
					// lấy tất cả video của Category
					list = videoService.findByCategoryId(cateId);
				}
			} 
			// chỉ có Keyword (tìm kiếm từ Header)
			else if (keyword != null && !keyword.isEmpty()) {
				list = videoService.findByTitle(keyword);
			} 
			// ko có gì -> Home
			else {
				resp.sendRedirect(req.getContextPath() + "/user/home");
				return;
			}
			
			// đẩy dữ liệu ra View
			req.setAttribute("videos", list);
			req.setAttribute("category", category); 
			req.setAttribute("searchKeyword", keyword); 
			
			req.getRequestDispatcher("/views/user/video-list.jsp").forward(req, resp);
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendRedirect(req.getContextPath() + "/user/home");
		}
	}
}