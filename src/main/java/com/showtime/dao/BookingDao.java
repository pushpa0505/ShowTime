package com.showtime.dao;

import java.util.List;

import com.showtime.model.Booking;

public interface BookingDao {
	List<String> findBookedSeatsByShowtimeId(int showtimeId);
	void save(Booking booking);
	void update(Booking booking);
	List<Booking> findByShowtimeId(int showtimeId);
	Booking findById(int bookingId);
	List<Booking> findByUserId(int userId);
	List<Booking> findAll();
	
}
