package ltweb.repository;

import java.util.List;

import ltweb.entity.User;

public interface UserRepository {

	List<User> findAll();

}
