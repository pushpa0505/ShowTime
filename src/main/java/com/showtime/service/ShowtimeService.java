package com.showtime.service;

import java.time.LocalDate;
import java.util.List;

import com.showtime.model.Showtime;

public interface ShowtimeService {

	void addShowtime(Showtime showtime);
	List<Showtime> getAllShowtimes();
	Showtime getShowtimeById(int id);
	void deleteShowtime(int id);
	List<Showtime> getShowtimesByTheaterAndDate(int theaterId, LocalDate date);
	List<Showtime> getByMovieAndCityAndDate(int movieId, String city, LocalDate date);
	List<String> getLanguagesByMovieAndCity(int movieId, String city);
	List<Showtime> findByMovieAndTheaterAndDate(int movieId, int theaterId, LocalDate date);
}
