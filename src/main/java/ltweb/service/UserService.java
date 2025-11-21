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

	void updatePassword(String email, String newPassword);

	User findById(int id);

	boolean checkExistUsername(String username);

	void delete(int id) throws Exception;

	void update(User user);

}
