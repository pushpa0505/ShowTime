package com.showtime.dao;

import com.showtime.model.User;

public interface UserDao {

	void save(User user);
	User findByEmail(String email);
	User findById(int userId);
	User update(User user);
}
