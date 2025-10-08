package com.showtime.service;

import java.util.List;

import com.showtime.model.Movie;

public interface MovieService {

	void addMovie(Movie movie);
	void updateMovie(Movie movie);
	Movie getMovieById(int id);
	List<Movie> getAllMovies();
	void deleteMovie(int id);
	List<Movie> getMovies(String searchTerm);
	List<Movie> getMoviesByStatus(String status);
	List<Movie> getMoviesByStatusAndCity(String status, String city);
	Movie findLatestMovieByCity(String city);
	List<Movie> searchMoviesInCity(String searchTerm, String city);
}
