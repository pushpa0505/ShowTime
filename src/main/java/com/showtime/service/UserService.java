package com.showtime.service;

import com.showtime.model.User;

public interface UserService {

	boolean registerAdmin(User user);
	User loginAdmin(String email, String password);
	boolean registerUser(User user);
	User loginUser(String email, String password);
	User updateUser(User user);
	boolean changeUserPassword(int userId, String currentPassword, String newPassword);
}
