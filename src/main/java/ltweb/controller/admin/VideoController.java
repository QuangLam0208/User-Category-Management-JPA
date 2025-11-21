package ltweb.controller.admin;

import java.io.File;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import ltweb.entity.Category;
import ltweb.entity.Video;
import ltweb.service.CategoryService;
import ltweb.service.VideoService;
import ltweb.service.impl.CategoryServiceImpl;
import ltweb.service.impl.VideoServiceImpl;
import ltweb.util.Constant;

@WebServlet(urlPatterns = { "/admin/video", "/admin/video/add", "/admin/video/edit", "/admin/video/delete" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class VideoController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	VideoService videoService = new VideoServiceImpl();
	CategoryService categoryService = new CategoryServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String url = req.getRequestURI().toString();
		
		if (url.contains("video/add")) {
			
			req.setAttribute("categories", categoryService.findAll());
			req.getRequestDispatcher("/views/admin/video-add.jsp").forward(req, resp);
			
		} else if (url.contains("video/edit")) {
			
			int id = Integer.parseInt(req.getParameter("id"));
            Video video = videoService.findById(id);
            req.setAttribute("video", video);
            req.setAttribute("categories", categoryService.findAll());
            req.getRequestDispatcher("/views/admin/video-edit.jsp").forward(req, resp);
            
		} else if (url.contains("video/delete")) {
			
			try {
                int id = Integer.parseInt(req.getParameter("id"));
                videoService.delete(id);
                req.getSession().setAttribute("message", "Xóa video thành công!");
            } catch (Exception e) {
                req.getSession().setAttribute("error", "Xóa thất bại: " + e.getMessage());
            }
            resp.sendRedirect(req.getContextPath() + "/admin/video");
            
		} else {
			
			String categoryIdStr = req.getParameter("categoryId");
	        String keyword = req.getParameter("keyword");
	        
	        List<Video> list;
	        
	        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
	            int cateId = Integer.parseInt(categoryIdStr);
	            list = videoService.findByCategoryId(cateId);
	            Category cate = categoryService.findById(cateId);
	            req.setAttribute("selectedCategory", cate);     
	        } else if (keyword != null && !keyword.isEmpty()) {
	            list = videoService.findByTitle(keyword);
	        } else {
	            list = videoService.findAll();
	        }
	        
	        req.setAttribute("videos", list);
	        req.getRequestDispatcher("/views/admin/video-list.jsp").forward(req, resp);
            
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String url = req.getRequestURI().toString();
		
		if (url.contains("video/add")) {
			insertVideo(req, resp);
		} else if (url.contains("video/edit")) {
			updateVideo(req, resp);
		}
	}
	
	private void insertVideo(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		try {
			String title = req.getParameter("title");
			String description = req.getParameter("description");
			int active = Integer.parseInt(req.getParameter("active"));
			int categoryId = Integer.parseInt(req.getParameter("categoryId"));
			
			Video video = new Video();
			video.setTitle(title);
			video.setDescription(description);
			video.setActive(active);
			video.setViews(0);
			Category cate = categoryService.findById(categoryId);
			video.setCategory(cate);
			
			Part filePart = req.getPart("videoFile");
			if (filePart != null && filePart.getSize() > 0) {
				String filename = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
				String uploadPath = Constant.DIR + File.separator + "video";
				File uploadDir = new File(uploadPath);
				if (!uploadDir.exists()) {
					uploadDir.mkdirs();
				}
				filePart.write(uploadPath + File.separator + filename);
				video.setPoster("video/" + filename);
			} else {
				video.setPoster("video/default.png");
			}
			
			videoService.insert(video);
			resp.sendRedirect(req.getContextPath() + "/admin/video");
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}
	
	private void updateVideo(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		try {
			int id = Integer.parseInt(req.getParameter("id"));
			String title = req.getParameter("title");
			String description = req.getParameter("description");
			int active = Integer.parseInt(req.getParameter("active"));
			int categoryId = Integer.parseInt(req.getParameter("categoryId"));
			
			Video video = videoService.findById(id);
			video.setTitle(title);
			video.setDescription(description);
			video.setActive(active);
			Category cate = categoryService.findById(categoryId);
			video.setCategory(cate);
			
			Part filePart = req.getPart("poster");
			if (filePart != null && filePart.getSize() > 0) {
				String filename = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
				String uploadPath = Constant.DIR + File.separator + "video";
				File uploadDir = new File(uploadPath);
				if (!uploadDir.exists()) {
					uploadDir.mkdirs();
				}
				filePart.write(uploadPath + File.separator + filename);
				video.setPoster("video/" + filename);
			}
			
			videoService.update(video);
			resp.sendRedirect(req.getContextPath() + "/admin/video");
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}
}
