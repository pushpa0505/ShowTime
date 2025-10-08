package com.showtime.dao;

import java.util.List;

import com.showtime.model.Theater;

public interface TheaterDao {

	void save(Theater theater);
	List<Theater> findAll();
	void deleteById(int id);
	Theater findById(int id);
	void update(Theater theater);
}
