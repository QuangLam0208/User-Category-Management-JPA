package ltweb.service.impl;

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
	public User login(String username, String password) {
	    User user = userRepo.findByUsername(username);
	    
	    if (user != null && user.getPassword().equals(password)) {
	        return user;
	    }
	    return null;
	}
	
	@Override
	public User findByUsername(String username) {
		return userRepo.findByUsername(username);
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
	public boolean register(String email, String username, String fullname, String password, String phone) {
		if (userRepo.checkExistEmail(email) || userRepo.checkExistPhone(phone) || userRepo.findByUsername(username) != null) {
			return false;
		}
		
		User user = new User();
		user.setEmail(email);
		user.setUsername(username);
		user.setFullname(fullname);
		user.setPassword(password);
		user.setPhone(phone);
		user.setRoleid(1); // Mặc định roleid là 1 (user)
		
		userRepo.insert(user);
		return true;
	}
	
	@Override
	public void updatePassword(String email, String newPassword) {
		userRepo.updatePassword(email, newPassword);
	}
}
