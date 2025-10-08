package com.showtime.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.showtime.model.User;
import com.showtime.service.UserService;

@Controller
public class AuthController {
	
	@Autowired
	private UserService userService;

	// display registraton page
	@GetMapping("/register")
	public String showRegisterPage(Model model) {
		model.addAttribute("user", new User());
		return "register";
	}
	
	// process register form and register user
	@PostMapping("/register")
	public String registerUser(
			@Valid 
			@ModelAttribute("user") User user, 
			BindingResult bindingResult, 
			RedirectAttributes redirectAttributes) {
		
		if(bindingResult.hasErrors()) {
			return "register";
		}
		
		boolean isSuccessfull = userService.registerUser(user);
		
		if(isSuccessfull) {
			redirectAttributes.addFlashAttribute("successMessage", "Registration successful! Please login.");
			return "redirect:/login";
		}else {
			redirectAttributes.addFlashAttribute("errorMessage","An account with this email already exist.");
			return "redirect:/register";
		}
	}
	
	/// display login page
	@GetMapping("/login")
	public String showLoginPage() {
		return "login";
	}
	
	// process login form
	@PostMapping("/login")
	public String loginUser(@RequestParam("email") String email,
	                        @RequestParam("password") String password,
	                        HttpSession session,
	                        Model model,
	                        RedirectAttributes redirectAttributes) {
	    
	    User user = userService.loginUser(email, password);

	    if (user != null) {
	        // If login is successful, store the user in the session
	        session.setAttribute("user", user);
	        redirectAttributes.addFlashAttribute("successMessage", "Login successful!");
	        return "redirect:/"; // Redirect to the home page
	    } else {
	        // If login fails, show an error message on the login page
	        model.addAttribute("errorMessage", "Invalid email or password.");
	        return "login";
	    }
	}
	
	@GetMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}
}
