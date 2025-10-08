package com.showtime.dao;

import java.util.List;

import com.showtime.model.Movie;

public interface MovieDao {

	void save(Movie movie);
	void update(Movie movie);
	Movie findById(int id);
	List<Movie> findAll();
	void deleteById(int id);
	List<Movie> findMovies(String searchTerm);
	List<Movie> findMoviesByStatus(String status);
	List<Movie> findMoviesByStatusAndCity(String status, String city);
	Movie findLatestMovieByCity(String city);
	List<Movie> searchMoviesInCity(String searchTerm, String city);
}
