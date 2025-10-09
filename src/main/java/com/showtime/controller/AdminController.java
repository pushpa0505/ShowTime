package com.showtime.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.showtime.model.User;
import com.showtime.service.DashboardService;
import com.showtime.service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private DashboardService dashboardService;
	
	@GetMapping("/register")
	public String showRegisterForm(Model model) {
		model.addAttribute("user", new User());
		return "admin-register";
	}
	
	@PostMapping("/register")
	public String registerAdmin(@Valid @ModelAttribute("user") User user, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
		if(bindingResult.hasErrors()) {
			return "admin-register";
		}
		boolean isSuccessfull = userService.registerAdmin(user);
		if(isSuccessfull) {
			redirectAttributes.addFlashAttribute("successMessage", "Registration successfull! Please login.");
		}else {
			redirectAttributes.addFlashAttribute("errorMessage", "An account with this email already exists.");
			return "redirect:/admin/register";
		}
		return "redirect:/admin/login";
	}
	
	@GetMapping({"/", "/login"})
	public String showLoginForm() {
		return "admin-login";
	}

	
	@PostMapping("/login")
	public String loginAdmin(
			@RequestParam("email") String email, 
			@RequestParam("password") String password,
			HttpSession session,
			Model model
			) {
				
		User adminUser = userService.loginAdmin(email, password);
		if(adminUser != null) {
			session.setAttribute("adminUser", adminUser);
			return "redirect:/admin/dashboard";
		}else {
			model.addAttribute("error", "Invalid email or password");
			return "admin-login";
		}
	}
	
	// logout
	@GetMapping("/logout")
	public String logout(HttpSession session, Model model) {
		session.invalidate();
		model.addAttribute("error", "Admin logged out.");
		return "admin-login";
	}
	
	// Dashboard mapping
	@GetMapping("/dashboard")
	public String showDashboard(HttpSession session, Model model) {
		User adminUser = (User) session.getAttribute("adminUser");
		if(adminUser == null || !adminUser.getRole().equals("ADMIN")) {
			return "redirect:/admin/login";
		}
		
		model.addAttribute("todaysRevenue", dashboardService.getTodaysRevenue());
		model.addAttribute("todaysBookingsCount", dashboardService.getTodaysBookingsCount());
		model.addAttribute("totalRevenue", dashboardService.getTotalRevenue());
		model.addAttribute("totalBookingsCount", dashboardService.getTotalBookingsCount());
		model.addAttribute("recentBookings", dashboardService.getRecentBookings(10));
		
		return "dashboard";
	}
	
	
}




