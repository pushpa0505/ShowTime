package com.showtime.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.showtime.dao.MovieDao;
import com.showtime.model.Movie;

@Service
public class MovieServiceImpl implements MovieService {
	
	@Autowired
	private MovieDao movieDao;

	@Override
	@Transactional
	public void addMovie(Movie movie) {
		movieDao.save(movie);
	}

	@Override
	@Transactional
	public void updateMovie(Movie movie) {
		movieDao.update(movie);
	}

	@Override
	@Transactional(readOnly = true)
	public Movie getMovieById(int id) {
		return movieDao.findById(id);
	}

	@Override
	@Transactional(readOnly = true)
	public List<Movie> getAllMovies() {
		return movieDao.findAll();
	}

	@Override
    @Transactional
    public void deleteMovie(int id) {
        movieDao.deleteById(id);
    }

	@Override
	@Transactional
	public List<Movie> getMovies(String searchTerm) {
		if(searchTerm == null || searchTerm.trim().isEmpty()) {
			return movieDao.findAll();
		}
		return movieDao.findMovies(searchTerm);
	}

	@Override
	@Transactional
	public List<Movie> getMoviesByStatus(String status) {
		return movieDao.findMoviesByStatus(status);
	}

	@Override
	@Transactional(readOnly = true)
	public List<Movie> getMoviesByStatusAndCity(String status, String city) {
		return movieDao.findMoviesByStatusAndCity(status, city);
	}
	
	@Override
	@Transactional(readOnly = true)
	public Movie findLatestMovieByCity(String city) {
	    return movieDao.findLatestMovieByCity(city);
	}

	@Override
	@Transactional(readOnly = true)
	public List<Movie> searchMoviesInCity(String searchTerm, String city) {
		return movieDao.searchMoviesInCity(searchTerm, city);
	}	

}
