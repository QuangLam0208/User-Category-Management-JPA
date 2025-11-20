package ltweb.repository;

import java.util.List;

import ltweb.entity.User;

public interface UserRepository {

	List<User> findAll();

	User findByUsername(String username);

	void insert(User user);

	boolean checkExistPhone(String phone);

	boolean checkExistEmail(String email);

}
