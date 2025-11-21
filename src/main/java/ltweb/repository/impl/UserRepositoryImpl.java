package ltweb.repository.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import ltweb.config.JPAConfig;
import ltweb.entity.User;
import ltweb.repository.UserRepository;

public class UserRepositoryImpl implements UserRepository {
	
	@Override
    public void insert(User user) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(user); // Hàm persist dùng để thêm mới
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }
	
	@Override
	public void update(User user) {
		EntityManager enma = JPAConfig.getEntityManager();
		EntityTransaction trans = enma.getTransaction();
		try {
			trans.begin();
			enma.merge(user); // Hàm merge dùng để cập nhật
			trans.commit();
		} catch (Exception e) {
			e.printStackTrace();
			trans.rollback();
			throw e;
		} finally {
			enma.close();
		}
	}
	
	@Override
	public void delete(int id) throws Exception {
		EntityManager enma = JPAConfig.getEntityManager();
		EntityTransaction trans = enma.getTransaction();
		try {
			trans.begin();
			User user = enma.find(User.class, id);
			if (user != null) {
				enma.remove(user);
			} else {
				throw new Exception("Không tìm thấy người dùng để xóa");
			}
			trans.commit();
		} catch (Exception e) {
			e.printStackTrace();
			trans.rollback();
			throw e;
		} finally {
			enma.close();
		}
	}
	
	@Override
	public void updatePassword(String email, String newPassword) {
		EntityManager enma = JPAConfig.getEntityManager();
		EntityTransaction trans = enma.getTransaction();
		try {
			trans.begin();
			String jpql = "UPDATE User u SET u.password = :newPassword WHERE u.email = :email";
			Query query = enma.createQuery(jpql);
			query.setParameter("newPassword", newPassword);
			query.setParameter("email", email);
			query.executeUpdate();
			trans.commit();
		} catch (Exception e) {
			e.printStackTrace();
			trans.rollback();
			throw e;
		} finally {
			enma.close();
		}
	}
	
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
		} catch (jakarta.persistence.NoResultException e) {
			return null; 
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@Override
	public User findById(int id) {
		EntityManager emma = JPAConfig.getEntityManager();
		return emma.find(User.class, id);
	}
	
	@Override
	public List<User> findAll(int page, int pageSize) {
		EntityManager emma = JPAConfig.getEntityManager();
		String jpql = "Select c from User c";
		TypedQuery<User> query = emma.createQuery(jpql, User.class);
		query.setFirstResult((page - 1) * pageSize);
		query.setMaxResults(pageSize);
		return query.getResultList();
	}
	
	@Override 
	public boolean checkExistUsername(String username) {
		EntityManager enma = JPAConfig.getEntityManager();
		String jpql = "SELECT u FROM User u WHERE u.username = :username";
		TypedQuery<User> query = enma.createQuery(jpql, User.class);
		query.setParameter("username", username);
		return !query.getResultList().isEmpty();
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
}