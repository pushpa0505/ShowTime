package com.showtime.service;

import java.time.LocalDate;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.showtime.model.Booking;

@Service
public class DashboardServiceImpl implements DashboardService {
	
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	@Transactional(readOnly = true)
	public double getTodaysRevenue() {
		Session session = sessionFactory.getCurrentSession();
		String hql = "SELECT SUM(b.totalPrice) FROM Booking b WHERE b.bookingDate = :today";
		Query<Double> query = session.createQuery(hql, Double.class);
		query.setParameter("today", LocalDate.now());
		Double result = query.uniqueResult();
		return result == null ? 0 : result;
	}

	@Override
	@Transactional(readOnly = true)
	public Long getTodaysBookingsCount() {
		Session session = sessionFactory.getCurrentSession();
		String hql = "SELECT COUNT(*) FROM Booking b WHERE b.bookingDate = :today";
		Query<Long> query = session.createQuery(hql, Long.class);
		query.setParameter("today", LocalDate.now());
		return query.uniqueResult();
	}

	@Override
	@Transactional(readOnly = true)
	public double getTotalRevenue() {
		Session session = sessionFactory.getCurrentSession();
		String hql = "SELECT SUM(b.totalPrice) FROM Booking b";
		Query<Double> query = session.createQuery(hql, Double.class);
		Double result = query.uniqueResult();
		return result == null ? 0 : result;
	}

	@Override
	@Transactional(readOnly = true)
	public Long getTotalBookingsCount() {
		Session session = sessionFactory.getCurrentSession();
		String hql = "SELECT COUNT(*) FROM Booking";
		Query<Long> query = session.createQuery(hql, Long.class);
		return query.uniqueResult();
	}

	@Override
	@Transactional(readOnly = true)
	public List<Booking> getRecentBookings(int limit) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "FROM Booking b ORDER BY b.bookingDate DESC";
		Query<Booking> query = session.createQuery(hql, Booking.class);
		query.setMaxResults(limit);
		return query.list();
	}

}
