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

@WebServlet(urlPatterns = "/image")
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

		if (file.exists()) {

			String mimeType = getServletContext().getMimeType(file.getName());

			if (mimeType == null) {
				//mặc định là binary
				mimeType = "application/octet-stream"; 
			}

			resp.setContentType(mimeType);

			resp.setContentLength((int) file.length());

			try (FileInputStream in = new FileInputStream(file)) {
				IOUtils.copy(in, resp.getOutputStream());
			}

		} else {
			resp.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found.");
		}
	}
}
