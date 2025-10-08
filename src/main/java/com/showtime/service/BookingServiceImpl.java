package com.showtime.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.showtime.dao.BookingDao;
import com.showtime.model.Booking;

@Service
public class BookingServiceImpl implements BookingService {
	
	@Autowired
	private BookingDao bookingDao;

	@Override
	@Transactional(readOnly = true)
	public List<String> getBookedSeats(int showtimeId) {
		return bookingDao.findBookedSeatsByShowtimeId(showtimeId);
	}

	@Override
	@Transactional
	public void createBooking(Booking booking) {
		bookingDao.save(booking);
	}
	
	@Override
	@Transactional
	public void updateBooking(Booking booking) {
		bookingDao.update(booking);
	}

	@Override
	@Transactional(readOnly = true)
	public List<Booking> getBookingByShowtime(int showtimeId) {
		return bookingDao.findByShowtimeId(showtimeId);
	}

	@Override
	@Transactional(readOnly = true)
	public Booking getBookingById(int bookingId) {
		return bookingDao.findById(bookingId);
	}

	@Override
	@Transactional(readOnly = true)
	public List<Booking> getBookingsByUserId(int userId) {
		return bookingDao.findByUserId(userId);
	}

	@Override
	@Transactional
	public boolean cancelBooking(int bookingId, int userId) {
		Booking booking = bookingDao.findById(bookingId);
		
		// Make sure the booking exists and belongs to the user trying to cancel it.
		if(booking != null && booking.getUser().getId() == userId) {
			booking.setStatus("CANCELLED");
			bookingDao.update(booking);	
			return true;
		}
		return false;
	}

	@Override
	@Transactional(readOnly = true)
	public List<Booking> getAllBookings() {
		return bookingDao.findAll();
	}	

}
