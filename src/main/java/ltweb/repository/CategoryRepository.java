package ltweb.repository;

import java.util.List;

import ltweb.entity.Category;

public interface CategoryRepository {

	List<Category> findByName(String name);

	List<Category> findAll();

	Category findById(int id);

	void delete(int id) throws Exception;

	void update(Category category);

	void insert(Category category);

	List<Category> findByUserId(int userId);

}
