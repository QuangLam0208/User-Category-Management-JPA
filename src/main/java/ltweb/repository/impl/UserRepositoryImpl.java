package ltweb.repository.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
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
	
	@Override
	public User findByUsername(String username) {
		EntityManager emma = JPAConfig.getEntityManager();
		String jpql = "Select c from User c where c.username = :username";
		try {
			TypedQuery<User> query = emma.createQuery(jpql, User.class);
			query.setParameter("username", username);
			return query.getSingleResult();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@Override
    public boolean checkExistEmail(String email) {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT u FROM User u WHERE u.email = :email";
        TypedQuery<User> query = enma.createQuery(jpql, User.class);
        query.setParameter("email", email);
        return !query.getResultList().isEmpty();
    }
	
	@Override
    public boolean checkExistPhone(String phone) {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT u FROM User u WHERE u.phone = :phone";
        TypedQuery<User> query = enma.createQuery(jpql, User.class);
        query.setParameter("phone", phone);
        return !query.getResultList().isEmpty();
    }
	
	@Override
    public void insert(User user) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(user); // Hàm persist dùng để thêm mới trong JPA
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }
}