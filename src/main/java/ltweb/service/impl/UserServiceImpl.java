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
}
