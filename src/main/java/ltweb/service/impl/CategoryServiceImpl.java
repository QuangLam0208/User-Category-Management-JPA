package ltweb.service.impl;

import java.util.List;

import ltweb.entity.Category;
import ltweb.repository.CategoryRepository;
import ltweb.repository.impl.CategoryRepositoryImpl;
import ltweb.service.CategoryService;

public class CategoryServiceImpl implements CategoryService {
	CategoryRepository categoryRepo = new CategoryRepositoryImpl();
	
	@Override
	public void insert(Category category) {
		categoryRepo.insert(category);
	}
	
	@Override
	public void update(Category category) {
		categoryRepo.update(category);
	}
	
	@Override
	public void delete(int id) throws Exception {
		categoryRepo.delete(id);
	}
	
	@Override
	public Category findById(int id) {
		return categoryRepo.findById(id);
	}
	
	@Override
	public List<Category> findAll() {
		return categoryRepo.findAll();
	}
	
	@Override
	public List<Category> findByName(String name) {
		return categoryRepo.findByName(name);
	}
	
	@Override
	public List<Category> findByUserId(int userId) {
		return categoryRepo.findByUserId(userId);
	}
}
