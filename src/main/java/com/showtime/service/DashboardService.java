package com.showtime.service;

import java.util.List;

import com.showtime.model.Booking;

public interface DashboardService {
	
	double getTodaysRevenue();
	Long getTodaysBookingsCount();
	double getTotalRevenue();
	Long getTotalBookingsCount();
	List<Booking> getRecentBookings(int limit); 
}
