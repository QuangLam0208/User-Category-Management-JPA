package ltweb.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import org.apache.commons.io.IOUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ltweb.util.Constant;

@WebServlet(urlPatterns = "/image") // URL pattern: /image?fname=...
public class DownloadImageController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String fileName = req.getParameter("fname");
		if (fileName == null || fileName.isEmpty()) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "File name is missing.");
			return;
		}

		File file = new File(Constant.DIR, fileName);
		
		// Đặt content type (ví dụ: image/jpeg, image/png)
		// Tạm thời để chung là image/jpeg
		resp.setContentType("image/jpeg");
		
		if (file.exists()) {
			try (FileInputStream in = new FileInputStream(file)) {
				IOUtils.copy(in, resp.getOutputStream());
			}
		} else {
			// (Có thể trả về ảnh mặc định nếu không tìm thấy)
			resp.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found.");
		}
	}
}
