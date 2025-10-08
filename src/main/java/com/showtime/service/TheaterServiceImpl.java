package com.showtime.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.showtime.dao.TheaterDao;
import com.showtime.model.Theater;

@Service
public class TheaterServiceImpl implements TheaterService {
	
	@Autowired
	private TheaterDao theaterDao;

	@Override
	@Transactional
	public void addTheater(Theater theater) {
		theaterDao.save(theater);
	}

	@Override
	@Transactional(readOnly = true)
	public List<Theater> getAllTheaters() {
		return theaterDao.findAll();
	}

	@Override
	@Transactional
	public void deleteTheater(int id) {
		theaterDao.deleteById(id);
	}

	@Override
	@Transactional(readOnly = true)
	public Theater getTheaterById(int id) {
		return theaterDao.findById(id);
	}

	@Override
	@Transactional
	public void updateTheater(Theater theater) {
		theaterDao.update(theater);
	}

}
