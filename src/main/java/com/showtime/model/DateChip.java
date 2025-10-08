package com.showtime.model;

import java.time.LocalDate;

public class DateChip {

	private LocalDate dateValue; // actual date
	private String dayOfWeek; // Mon, Tue, ...
	private String dayAndMonth; // "01 JAN"
	public LocalDate getDateValue() {
		return dateValue;
	}
	public void setDateValue(LocalDate dateValue) {
		this.dateValue = dateValue;
	}
	public String getDayOfWeek() {
		return dayOfWeek;
	}
	public void setDayOfWeek(String dayOfWeek) {
		this.dayOfWeek = dayOfWeek;
	}
	public String getDayAndMonth() {
		return dayAndMonth;
	}
	public void setDayAndMonth(String dayAndMonth) {
		this.dayAndMonth = dayAndMonth;
	}
	
	
	
}
