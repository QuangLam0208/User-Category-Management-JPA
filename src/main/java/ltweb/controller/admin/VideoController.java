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
			
			String preCateId = req.getParameter("categoryId");
			if (preCateId != null) {
				req.setAttribute("preCateId", preCateId);
			}
			
			req.getRequestDispatcher("/views/admin/video-add.jsp").forward(req, resp);
			
		} else if (url.contains("video/edit")) {
			
			try {
				int id = Integer.parseInt(req.getParameter("id"));
				Video video = videoService.findById(id);
				req.setAttribute("video", video);
				req.setAttribute("categories", categoryService.findAll());
				req.getRequestDispatcher("/views/admin/video-edit.jsp").forward(req, resp);
			} catch (Exception e) {
				resp.sendRedirect(req.getContextPath() + "/admin/video");
			}
			
		} else if (url.contains("video/delete")) {
			
			try {
				int id = Integer.parseInt(req.getParameter("id"));
				videoService.delete(id);
				req.getSession().setAttribute("message", "Xóa video thành công!");
			} catch (Exception e) {
				req.getSession().setAttribute("error", "Xóa thất bại: " + e.getMessage());
			}
			
			String rolePrefix = req.getRequestURI().contains("/manager/") ? "/manager" : "/admin";
			String cateId = req.getParameter("categoryId");
			if (cateId != null && !cateId.isEmpty()) {
		        // nếu xóa khi đang ở trong danh mục -> quay lại danh mục đó
		        resp.sendRedirect(req.getContextPath() + rolePrefix + "/video?categoryId=" + cateId);
		    } else {
		        // nếu xóa ở trang tất cả -> quay lại trang tất cả
		        resp.sendRedirect(req.getContextPath() + rolePrefix + "/video");
		    }
			
			
		} else {
			
			String categoryIdStr = req.getParameter("categoryId");
			String keyword = req.getParameter("keyword");
			
			List<Video> list;
			
			// Kiểm tra xem có đang lọc theo Category không
		    if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
		        try {
		            int cateId = Integer.parseInt(categoryIdStr);
		            
		            // Lấy thông tin Category để hiển thị tiêu đề
		            Category cate = categoryService.findById(cateId);
		            req.setAttribute("selectedCategory", cate);
		            
		            // có từ khóa -> tìm trong category đó
		            if (keyword != null && !keyword.isEmpty()) {
		                list = videoService.findByTitleAndCategoryId(keyword, cateId);
		            } 
		            // ko có từ khóa -> lấy hết video của category đó
		            else {
		                list = videoService.findByCategoryId(cateId);
		            }
		            
		        } catch (NumberFormatException e) {
		            // id lỗi -> tìm kiếm toàn cục
		            if (keyword != null && !keyword.isEmpty()) {
		                list = videoService.findByTitle(keyword);
		            } else {
		                list = videoService.findAll();
		            }
		        }
		    } 
		    // ko lọc category -> tìm kiếm toàn cục
		    else {
		        if (keyword != null && !keyword.isEmpty()) {
		            list = videoService.findByTitle(keyword);
		        } else {
		            list = videoService.findAll();
		        }
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
			} else {
				video.setPoster("video/default.png");
			}
			
			videoService.insert(video);
			

			String fromCateId = req.getParameter("fromCateId");
			String rolePrefix = req.getRequestURI().contains("/manager/") ? "/manager" : "/admin";
			
			if (fromCateId != null && !fromCateId.isEmpty()) {
				resp.sendRedirect(req.getContextPath() + rolePrefix + "/video?categoryId=" + fromCateId);
			} else {
				resp.sendRedirect(req.getContextPath() + rolePrefix + "/video");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}
	
	private void updateVideo(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		try {
	        int id = Integer.parseInt(req.getParameter("id"));
	        Video video = videoService.findById(id);
	        
	        video.setTitle(req.getParameter("title"));
	        video.setDescription(req.getParameter("description"));
	        video.setActive(Integer.parseInt(req.getParameter("active")));
	        
	        int categoryId = Integer.parseInt(req.getParameter("categoryId"));
	        Category cate = categoryService.findById(categoryId);
	        video.setCategory(cate);
	        
	        Part part = req.getPart("poster");
	        if (part.getSize() > 0) {
	             String filename = System.currentTimeMillis() + "_" + part.getSubmittedFileName();
	             String uploadPath = Constant.DIR + File.separator + "video";
	             File uploadDir = new File(uploadPath); 
	             if (!uploadDir.exists()) uploadDir.mkdirs();
	             
	             part.write(uploadPath + File.separator + filename);
	             video.setPoster("video/" + filename);
	        }
	        
	        videoService.update(video);
	        
	        String currentUrl = req.getRequestURI();
	        String rolePrefix = currentUrl.contains("/admin/") ? "/admin" : "/manager";
	        String fromCateId = req.getParameter("fromCateId");
	        
	        if (fromCateId != null && !fromCateId.isEmpty()) {
	            resp.sendRedirect(req.getContextPath() + rolePrefix + "/video?categoryId=" + fromCateId);
	        } else {
	            resp.sendRedirect(req.getContextPath() + rolePrefix + "/video");
	        }
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	    }
	}
}