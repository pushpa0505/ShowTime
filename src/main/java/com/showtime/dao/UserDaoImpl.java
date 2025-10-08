package com.showtime.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.showtime.model.User;

@Repository
public class UserDaoImpl implements UserDao {

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public void save(User user) {
		Session session = sessionFactory.getCurrentSession();
		session.save(user);
	}

	@Override
	public User findByEmail(String email) {
		Session session = sessionFactory.getCurrentSession();
		Query<User> query = session.createQuery("FROM User where email = :email", User.class);
		query.setParameter("email", email);
		try {
			return query.getSingleResult();
		}catch(Exception e) {
			return null;
		}
	}

	@Override
	public User update(User user) {
		Session session = sessionFactory.getCurrentSession();
		return (User) session.merge(user);
	}

	@Override
	public User findById(int userId) {
		Session session = sessionFactory.getCurrentSession();
		return session.get(User.class, userId);
	}

}
