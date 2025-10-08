package com.showtime.dao;

import java.time.LocalDate;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.showtime.model.Showtime;

@Repository
public class ShowtimeDaoImpl implements ShowtimeDao {
	
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void save(Showtime showtime) {
		Session session = sessionFactory.getCurrentSession();
		session.save(showtime);
	}

	@Override
	public List<Showtime> findAll() {
		Session session = sessionFactory.getCurrentSession();
		Query<Showtime> query = session.createQuery("FROM Showtime ORDER BY showDate, startTime", Showtime.class);
		return query.list();
	}

	@Override
	public Showtime findById(int id) {
		Session session = sessionFactory.getCurrentSession();
		return session.get(Showtime.class, id);
	}

	@Override
	public void deleteById(int id) {
		Session session = sessionFactory.getCurrentSession();
		Showtime showtime = session.get(Showtime.class, id);
		if(showtime != null) {
			session.delete(showtime);
		}
	}

	@Override
	public List<Showtime> findByTheaterAndDate(int theaterId, LocalDate date) {
		Session session = sessionFactory.getCurrentSession();
		Query<Showtime> query = session.createQuery("FROM Showtime where theater.id = :theaterId and showDate = :showDate order by startTime", Showtime.class);
		query.setParameter("theaterId", theaterId);
		query.setParameter("showDate", date);		
		return query.list();
	}

	@Override
	public List<Showtime> findByMovieAndCityAndDate(int movieId, String city, LocalDate date) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "FROM Showtime s WHERE s.movie.id = :movieId AND s.theater.city = :city AND s.showDate = :date ORDER BY s.theater.name, s.startTime";
		Query<Showtime> query = session.createQuery(hql, Showtime.class);
		query.setParameter("movieId", movieId);
		query.setParameter("city", city);
		query.setParameter("date", date);
		return query.list();
	}

	@Override
	public List<String> findLanguagesByMovieAndCity(int movieId, String city) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "SELECT DISTINCT s.language FROM Showtime s WHERE s.movie.id = :movieId AND s.theater.city = :city ORDER BY language";
		Query<String> query = session.createQuery(hql, String.class);
		query.setParameter("movieId", movieId);
		query.setParameter("city", city);
		return query.list();
	}
	
	@Override
	public List<Showtime> findByMovieAndTheaterAndDate(int movieId, int theaterId, LocalDate date) {
	    Session session = sessionFactory.getCurrentSession();
	    String hql = "FROM Showtime s WHERE s.movie.id = :movieId AND s.theater.id = :theaterId AND s.showDate = :date ORDER BY s.startTime";
	    Query<Showtime> query = session.createQuery(hql, Showtime.class);
	    query.setParameter("movieId", movieId);
	    query.setParameter("theaterId", theaterId);
	    query.setParameter("date", date);
	    return query.list();
	}

}
