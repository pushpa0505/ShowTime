package com.showtime.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.showtime.model.Booking;

@Repository
public class BookingDaoImpl implements BookingDao {
	
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<String> findBookedSeatsByShowtimeId(int showtimeId) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "SELECT b.bookedSeats FROM Booking b WHERE b.showtime.id = :showtimeId";
		Query<String> query = session.createQuery(hql, String.class);
		query.setParameter("showtimeId", showtimeId);
		return query.list();
	}

	@Override
	public void save(Booking booking) {
		Session session = sessionFactory.getCurrentSession();
		session.save(booking);
	}

	@Override
	public List<Booking> findByShowtimeId(int showtimeId) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "FROM Booking b WHERE b.showtime.id = :showtimeId";
		Query<Booking> query = session.createQuery(hql, Booking.class);
		query.setParameter("showtimeId", showtimeId);
		return query.list();
	}

	@Override
	public Booking findById(int bookingId) {
		Session session = sessionFactory.getCurrentSession();
		return session.get(Booking.class, bookingId);
	}

	@Override
	public List<Booking> findByUserId(int userId) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "FROM Booking b WHERE b.user.id = :userId ORDER BY b.showtime.showDate DESC";
		Query<Booking> query = session.createQuery(hql, Booking.class);
		query.setParameter("userId", userId);
		return query.list();
		
	}

	@Override
	public void update(Booking booking) {
		Session session = sessionFactory.getCurrentSession();
		session.update(booking);
	}

	@Override
	public List<Booking> findAll() {
		Session session = sessionFactory.getCurrentSession();		
		String hql = "FROM Booking ORDER BY id DESC";
		Query<Booking> query = session.createQuery(hql , Booking.class);
		return query.list();
	}


}
