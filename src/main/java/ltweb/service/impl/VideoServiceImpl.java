package ltweb.service.impl;

import java.util.List;

import ltweb.entity.Video;
import ltweb.repository.VideoRepository;
import ltweb.repository.impl.VideoRepositoryImpl;
import ltweb.service.VideoService;

public class VideoServiceImpl implements VideoService {
	VideoRepository videoRepo = new VideoRepositoryImpl();
	
	@Override
	public void insert(Video video) {
		videoRepo.insert(video);
	}
	
	@Override
	public void update(Video video) {
		videoRepo.update(video);
	}
	
	@Override
	public void delete(int id) throws Exception {
		videoRepo.delete(id);
	}
	
	@Override
	public Video findById(int id) {
		return videoRepo.findById(id);
	}
	
	@Override
	public List<Video> findAll() {
		return videoRepo.findAll();
	}
	
	@Override
	public List<Video> findByTitle(String title) {
		return videoRepo.findByTitle(title);
	}
	
	@Override
	public List<Video> findByCategoryId(int categoryId) {
	    return videoRepo.findByCategoryId(categoryId);
	}
	
	@Override
	public List<Video> findByTitleAndCategoryId(String title, int categoryId) {
	    return videoRepo.findByTitleAndCategoryId(title, categoryId);
	}
	
	@Override
	public List<Video> findByManagerId(int managerId) {
	    return videoRepo.findByManagerId(managerId);
	}

	@Override
	public List<Video> findByTitleAndManagerId(String title, int managerId) {
	    return videoRepo.findByTitleAndManagerId(title, managerId);
	}
}
