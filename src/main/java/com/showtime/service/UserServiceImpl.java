package com.showtime.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.showtime.dao.UserDao;
import com.showtime.model.User;

@Service
@Transactional
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;
 	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Override
	public boolean registerAdmin(User user) {
		// Check if user with this email already exist
		if(userDao.findByEmail(user.getEmail()) != null) {
			return false;
		}
		
		String hashedPassword = passwordEncoder.encode(user.getPassword());
		user.setPassword(hashedPassword);
		user.setRole("ADMIN");
		userDao.save(user);
		
		return true;
	}

	@Override
	@Transactional(readOnly = true)
	public User loginAdmin(String email, String password) {
		User user = userDao.findByEmail(email);
		if(user != null && user.getRole().equals("ADMIN")) {
			if(passwordEncoder.matches(password, user.getPassword())) {
				return user;
			}
		}
		return null;
	}

	@Override
	public boolean registerUser(User user) {
		if(userDao.findByEmail(user.getEmail()) != null) {
			return false;
		}
		
		String hashedPassword = passwordEncoder.encode(user.getPassword());
		user.setPassword(hashedPassword);
		user.setRole("USER");
		userDao.save(user);
		return true;
	}

	@Override
	@Transactional(readOnly = true)
	public User loginUser(String email, String password) {
	    User user = userDao.findByEmail(email);

	    // Check if user exists and the role is "USER"
	    if (user != null && user.getRole().equals("USER")) {
	        // Check if the provided password matches the stored hashed password
	        if (passwordEncoder.matches(password, user.getPassword())) {
	            return user; // Login successful
	        }
	    }

	    return null; // Login failed
	}

	@Override
	@Transactional
	public User updateUser(User user) {
		return userDao.update(user);
	}

	@Override
	@Transactional
	public boolean changeUserPassword(int userId, String currentPassword, String newPassword) {
		User user = userDao.findById(userId);
		if(user == null) {
			return false;
		}
		
		if(!passwordEncoder.matches(currentPassword, user.getPassword())) {
			return false;
		}
		
		user.setPassword(passwordEncoder.encode(newPassword));
		userDao.update(user);
		
		return true;
	}

}
