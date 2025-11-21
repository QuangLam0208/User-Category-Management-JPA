package ltweb.service;

import java.util.List;

import ltweb.entity.Video;

public interface VideoService {

	List<Video> findByTitle(String title);

	List<Video> findAll();

	Video findById(int id);

	void delete(int id) throws Exception;

	void update(Video video);

	void insert(Video video);

	List<Video> findByCategoryId(int categoryId);

}
