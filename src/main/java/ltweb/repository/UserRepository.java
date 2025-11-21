package ltweb.repository;

import java.util.List;

import ltweb.entity.User;

public interface UserRepository {

	List<User> findAll();

	User findByUsername(String username);

	void insert(User user);

	boolean checkExistPhone(String phone);

	boolean checkExistEmail(String email);

	void updatePassword(String email, String newPassword);

	List<User> findAll(int page, int pageSize);

	void delete(int id) throws Exception;

	void update(User user);

	boolean checkExistUsername(String username);

	User findById(int id);

}
