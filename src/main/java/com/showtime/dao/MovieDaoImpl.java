package com.showtime.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.showtime.model.Movie;

@Repository
public class MovieDaoImpl implements MovieDao {

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public void save(Movie movie) {
		Session session = sessionFactory.getCurrentSession();
		session.save(movie);
	}

	@Override
	public void update(Movie movie) {
		Session session = sessionFactory.getCurrentSession();
		session.update(movie);
	}

	@Override
	public Movie findById(int id) {
		Session session = sessionFactory.getCurrentSession();
		return session.get(Movie.class, id);
	}

	@Override
	public List<Movie> findAll() {
		Session session = sessionFactory.getCurrentSession();
		Query<Movie> query = session.createQuery("FROM Movie", Movie.class);
		return query.list();
	}

	@Override
	public void deleteById(int id) {
		Session session = sessionFactory.getCurrentSession();
		Movie movie = session.get(Movie.class, id);
		if(movie != null) {
			session.delete(movie);
		}
	}

	@Override
	public List<Movie> findMovies(String searchTerm) {
		Session session = sessionFactory.getCurrentSession();
		
		StringBuilder hql = new StringBuilder("FROM Movie m");
		
		if (searchTerm != null && !searchTerm.isEmpty()) {
			hql.append(" where lower(m.title) like :searchTerm");
		}
		
		Query<Movie> query = session.createQuery(hql.toString(), Movie.class);
		
		if (searchTerm != null && !searchTerm.isEmpty()) {
			query.setParameter("searchTerm","%" + searchTerm.toLowerCase() + "%");
		}
		
		return query.list();
	}

	@Override
	public List<Movie> findMoviesByStatus(String status) {
		Session session = sessionFactory.getCurrentSession();
		Query<Movie> query = session.createQuery("FROM Movie WHERE status = :status", Movie.class);
		query.setParameter("status", status);
		return query.list();
	}
	
	@Override
	public List<Movie> findMoviesByStatusAndCity(String status, String city){
		Session session = sessionFactory.getCurrentSession();
		Query<Movie> query = session.createQuery("SELECT DISTINCT s.movie FROM Showtime s WHERE s.theater.city = :city AND s.movie.status = :status ORDER BY s.movie.releaseDate DESC", Movie.class);
		query.setParameter("city", city);
		query.setParameter("status", status);
		return query.list();
	}

	@Override
	public Movie findLatestMovieByCity(String city) {
	    Session session = sessionFactory.getCurrentSession();
	 // In MovieDaoImpl.java
	    String hql = "SELECT s.movie FROM Showtime s WHERE s.theater.city = :city AND s.movie.status = 'Now Showing' ORDER BY s.movie.releaseDate DESC";
	    Query<Movie> query = session.createQuery(hql, Movie.class);
	    query.setParameter("city", city);
	    query.setMaxResults(1); // We only want the top one

	    List<Movie> result = query.getResultList();
	    return result.isEmpty() ? null : result.get(0);
	}

	@Override
	public List<Movie> searchMoviesInCity(String searchTerm, String city) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "SELECT m FROM Movie m WHERE lower(m.title) LIKE :searchTerm AND ("
	               + "m.status = 'Upcoming' OR "
	               + "m.id IN (SELECT s.movie.id FROM Showtime s WHERE s.theater.city = :city AND s.movie.status = 'Now Showing')"
	               + ")";
		Query<Movie> query = session.createQuery(hql, Movie.class);
		query.setParameter("city", city);
		query.setParameter("searchTerm", "%" + searchTerm.toLowerCase() + "%");
		return query.list();
	}

}
