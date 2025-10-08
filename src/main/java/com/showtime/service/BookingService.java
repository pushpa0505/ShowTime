package com.showtime.service;

import java.util.List;

import com.showtime.model.Booking;

public interface BookingService {
	List<String> getBookedSeats(int showtimeId);
	void createBooking(Booking booking);
	void updateBooking(Booking booking);
	boolean cancelBooking(int bookingId, int userId);
	List<Booking> getBookingByShowtime(int showtimeId);
	Booking getBookingById(int bookingId);
	List<Booking> getBookingsByUserId(int userId);
	List<Booking> getAllBookings();
}
