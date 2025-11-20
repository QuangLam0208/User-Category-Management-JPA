package ltweb.repository.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import ltweb.config.JPAConfig;
import ltweb.entity.User;
import ltweb.repository.UserRepository;

public class UserRepositoryImpl implements UserRepository {
	
	@Override
	public List<User> findAll() {
		EntityManager emma = JPAConfig.getEntityManager();
		String jpql = "Select c from User c";
		TypedQuery<User> query = emma.createQuery(jpql, User.class);
		return query.getResultList();
	}
	
	
	
}
