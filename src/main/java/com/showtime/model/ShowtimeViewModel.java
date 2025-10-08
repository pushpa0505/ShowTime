package com.showtime.model;

import java.time.format.DateTimeFormatter;

// This class holds a showtime and its pre-formatted start time.
public class ShowtimeViewModel {

    private Showtime showtime;
    private String formattedStartTime;
    private String formattedDayOfWeek; // e.g., "Tue"
    private String formattedDayAndMonth; // e.g., "26 Aug"


    public ShowtimeViewModel(Showtime showtime) {
        this.showtime = showtime;
        
        // The "chef" formats the time into a simple String here.
        if (showtime != null && showtime.getStartTime() != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("hh:mm a");
            this.formattedStartTime = showtime.getStartTime().format(formatter);
        }
        
        if (showtime != null && showtime.getShowDate() != null) {
            DateTimeFormatter dayOfWeekFormatter = DateTimeFormatter.ofPattern("EEE");
            DateTimeFormatter dayAndMonthFormatter = DateTimeFormatter.ofPattern("dd MMM, yyyy");
            this.formattedDayOfWeek = showtime.getShowDate().format(dayOfWeekFormatter);
            this.formattedDayAndMonth = showtime.getShowDate().format(dayAndMonthFormatter);
        }
    }

    // --- Getters ---
    public Showtime getShowtime() {
        return showtime;
    }

    public String getFormattedStartTime() {
        return formattedStartTime;
    }

    public String getFormattedDayOfWeek() {
        return formattedDayOfWeek;
    }

    public String getFormattedDayAndMonth() {
        return formattedDayAndMonth;
    }
}