package ltweb.repository;

import java.util.List;

import ltweb.entity.Video;

public interface VideoRepository {

	List<Video> findByTitle(String title);

	List<Video> findAll();

	Video findById(int videoId);

	void delete(int videoId) throws Exception;

	void update(Video video);

	void insert(Video video);

}
