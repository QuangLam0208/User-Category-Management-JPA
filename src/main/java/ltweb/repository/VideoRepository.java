package ltweb.repository;

import java.util.List;
import ltweb.entity.Video;

public interface VideoRepository {

	List<Video> findByCategoryId(int categoryId);

	List<Video> findByTitle(String title);

	List<Video> findAll();

	Video findById(int id);

	void delete(int id) throws Exception;

	void update(Video video);

	void insert(Video video);
    
}