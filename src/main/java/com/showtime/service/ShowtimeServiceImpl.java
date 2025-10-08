package com.showtime.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.showtime.dao.ShowtimeDao;
import com.showtime.model.Showtime;

@Service
public class ShowtimeServiceImpl implements ShowtimeService {
	
	@Autowired
	private ShowtimeDao showtimeDao;

	@Override
	@Transactional
	public void addShowtime(Showtime showtime) {
		showtimeDao.save(showtime);
	}

	@Override
	@Transactional(readOnly = true)
	public List<Showtime> getAllShowtimes() {
		return showtimeDao.findAll();
	}

	@Override
	@Transactional(readOnly = true)
	public Showtime getShowtimeById(int id) {
		return showtimeDao.findById(id);
	}

	@Override
	@Transactional
	public void deleteShowtime(int id) {
		showtimeDao.deleteById(id);
	}

	@Override
	@Transactional
	public List<Showtime> getShowtimesByTheaterAndDate(int theaterId, LocalDate date) {
		return showtimeDao.findByTheaterAndDate(theaterId, date);
	}

	@Override
	@Transactional(readOnly = true)
	public List<Showtime> getByMovieAndCityAndDate(int movieId, String city, LocalDate date) {
		return showtimeDao.findByMovieAndCityAndDate(movieId, city, date);
	}

	@Override
	@Transactional(readOnly = true)
	public List<String> getLanguagesByMovieAndCity(int movieId, String city) {
		return showtimeDao.findLanguagesByMovieAndCity(movieId, city);
	}
	
	@Override
	@Transactional(readOnly = true)
	public List<Showtime> findByMovieAndTheaterAndDate(int movieId, int theaterId, LocalDate date) {
	    return showtimeDao.findByMovieAndTheaterAndDate(movieId, theaterId, date);
	}

}
