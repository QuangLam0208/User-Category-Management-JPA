package ltweb.service;

import java.util.List;

import ltweb.entity.User;

public interface UserService {

	List<User> findAll();

	User login(String username, String password);

	User findByUsername(String username);

	boolean register(String email, String username, String fullname, String password, String phone);

	boolean checkExistPhone(String phone);

	boolean checkExistEmail(String email);

}
