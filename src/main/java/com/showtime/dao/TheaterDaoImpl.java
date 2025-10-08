package com.showtime.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.showtime.model.Theater;

@Repository
public class TheaterDaoImpl implements TheaterDao {

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public void save(Theater theater) {
		Session session = sessionFactory.getCurrentSession();
		session.save(theater);
	}

	@Override
	public List<Theater> findAll() {
		Session session = sessionFactory.getCurrentSession();
		Query<Theater> query = session.createQuery("FROM Theater t ORDER BY t.name ASC", Theater.class);
		
		return query.list();
	}

	@Override
	public void deleteById(int id) {
		Session session = sessionFactory.getCurrentSession();	
		Theater theater = session.get(Theater.class, id);
		if(theater != null) {
			session.delete(theater);
		}
	}

	@Override
	public Theater findById(int id) {
		Session session = sessionFactory.getCurrentSession();
		return session.get(Theater.class, id);
	}

	@Override
	public void update(Theater theater) {
		Session session = sessionFactory.getCurrentSession();
		session.update(theater);
	}

}
