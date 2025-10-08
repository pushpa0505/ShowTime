package com.showtime.dao;

import java.time.LocalDate;
import java.util.List;

import com.showtime.model.Showtime;

public interface ShowtimeDao {

	void save(Showtime showtime);
	List<Showtime> findAll();
	Showtime findById(int id);
	void deleteById(int id);
	List<Showtime> findByTheaterAndDate(int theaterId, LocalDate date);
	List<Showtime> findByMovieAndCityAndDate(int movieId, String city, LocalDate date);
	List<String> findLanguagesByMovieAndCity(int movieId, String city);
	List<Showtime> findByMovieAndTheaterAndDate(int movieId, int theaterId, LocalDate date);
}
