package com.showtime.model;

import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;

public class AdminBookingViewModel {

    private Booking booking;
    private String formattedShowDate;
    private String ticketCount;

    public AdminBookingViewModel(Booking booking) {
        this.booking = booking;

        // Pre-format the date to avoid JSP errors
        if (booking.getShowtime() != null && booking.getShowtime().getShowDate() != null) {
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd MMM, yyyy");
            this.formattedShowDate = booking.getShowtime().getShowDate().format(dateFormatter);
        }

        // Pre-calculate the ticket count
        if (booking.getBookedSeats() != null && !booking.getBookedSeats().isEmpty()) {
            this.ticketCount = booking.getBookedSeats();
        } else {
            this.ticketCount = null;
        }
    }

    // Getters
    public Booking getBooking() {
        return booking;
    }

    public String getFormattedShowDate() {
        return formattedShowDate;
    }
    
    public String getTicketCount() {
        return ticketCount;
    }
}