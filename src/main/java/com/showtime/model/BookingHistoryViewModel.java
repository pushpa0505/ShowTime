package com.showtime.model;

import java.time.format.DateTimeFormatter;

public class BookingHistoryViewModel {
	private Booking booking;
    private String formattedShowDateTime;

    public BookingHistoryViewModel(Booking booking) {
        this.booking = booking;

        if (booking != null && booking.getShowtime() != null) {
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("EEE, dd MMM yyyy");
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("hh:mm a");

            String date = booking.getShowtime().getShowDate().format(dateFormatter);
            String time = booking.getShowtime().getStartTime().format(timeFormatter);

            this.formattedShowDateTime = date + " • " + time;
        }
    }

	public Booking getBooking() {
		return booking;
	}

	public String getFormattedShowDateTime() {
		return formattedShowDateTime;
	}
	
}
