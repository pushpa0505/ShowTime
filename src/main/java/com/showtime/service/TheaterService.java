package com.showtime.service;

import java.util.List;

import com.showtime.model.Theater;

public interface TheaterService {

	void addTheater(Theater theater);
	List<Theater> getAllTheaters();
	void deleteTheater(int id);
	Theater getTheaterById(int id);
	void updateTheater(Theater theater);
}
