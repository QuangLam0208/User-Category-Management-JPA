package ltweb.service;

import java.util.List;

import ltweb.entity.Category;

public interface CategoryService {

	List<Category> findByName(String name);

	List<Category> findAll();

	Category findById(int id);

	void delete(int id) throws Exception;

	void update(Category category);

	void insert(Category category);

	List<Category> findByUserId(int userId);

}
