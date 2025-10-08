package com.showtime.model;

import java.time.LocalDate;
import java.time.LocalTime;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "showtimes")
public class Showtime {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@NotNull(message = "Show date cannot be empty.")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate showDate;
	
	@NotNull(message = "Show time cannot be empty.")
	@DateTimeFormat(pattern = "HH:mm")
	private LocalTime startTime;
	
	@NotNull(message = "Ticket price cannot be empty.")
	private Double ticketPrice;
	
	@NotEmpty(message = "Language cannot be empty.")
	private String language;
	
	// HIBERNATE RELTIONSHIPS
	
	@ManyToOne
	@JoinColumn(name = "movie_id", nullable = false)
	@NotNull(message = "A movie must be selected.")
	private Movie movie;
	
	@ManyToOne
	@JoinColumn(name = "theater_id", nullable = false)
	@NotNull(message = "A theater must be selected.")
	private Theater theater;

	// GETTER SETTER
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public LocalDate getShowDate() {
		return showDate;
	}

	public void setShowDate(LocalDate showDate) {
		this.showDate = showDate;
	}

	public LocalTime getStartTime() {
		return startTime;
	}

	public void setStartTime(LocalTime startTime) {
		this.startTime = startTime;
	}

	public double getTicketPrice() {
		return ticketPrice;
	}

	public void setTicketPrice(double ticketPrice) {
		this.ticketPrice = ticketPrice;
	}

	public Movie getMovie() {
		return movie;
	}

	public void setMovie(Movie movie) {
		this.movie = movie;
	}

	public Theater getTheater() {
		return theater;
	}

	public void setTheater(Theater theater) {
		this.theater = theater;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}
	
}
