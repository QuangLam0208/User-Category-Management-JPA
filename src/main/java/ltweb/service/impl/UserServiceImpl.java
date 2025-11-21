package ltweb.service.impl;

import java.sql.Date;
import java.util.List;

import ltweb.entity.User;
import ltweb.repository.UserRepository;
import ltweb.repository.impl.UserRepositoryImpl;
import ltweb.service.UserService;

public class UserServiceImpl implements UserService {
	
	UserRepository userRepo = new UserRepositoryImpl();
	
	@Override
	public List<User> findAll() {
		return userRepo.findAll();
	}
	
	@Override
	public User findById(int id) {
		return userRepo.findById(id);
	}
	
	@Override
	public User findByUsername(String username) {
		return userRepo.findByUsername(username);
	}

	@Override
	public User login(String username, String password) {
		User user = userRepo.findByUsername(username);
		
		if (user != null && user.getPassword().equals(password)) {
			return user;
		}
		return null;
	}
	
	@Override
	public boolean register(String email, String username, String fullname, String password, String phone) {
		
		if (userRepo.checkExistEmail(email) || 
			userRepo.checkExistPhone(phone) || 
			userRepo.checkExistUsername(username)) {
			return false;
		}
		
		User user = new User();
		user.setEmail(email);
		user.setUsername(username);
		user.setFullname(fullname);
		user.setPassword(password);
		user.setPhone(phone);
		user.setRoleid(1);
		user.setActive(1); 
		user.setCreateddate(new Date(System.currentTimeMillis()));
		user.setImages(null); 
		
		userRepo.insert(user);
		return true;
	}
	
	@Override
	public void update(User user) {
		userRepo.update(user);
	}
	
	@Override
	public void delete(int id) throws Exception {
		userRepo.delete(id);
	}

	@Override
	public boolean checkExistEmail(String email) {
		return userRepo.checkExistEmail(email);
	}
	
	@Override
	public boolean checkExistPhone(String phone) {
		return userRepo.checkExistPhone(phone);
	}

	@Override
	public boolean checkExistUsername(String username) {
		return userRepo.checkExistUsername(username);
	}
	
	@Override
	public void updatePassword(String email, String newPassword) {
		userRepo.updatePassword(email, newPassword);
	}
}