package com.showtime.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.showtime.model.Booking;
import com.showtime.model.BookingHistoryViewModel;
import com.showtime.model.User;
import com.showtime.service.BookingService;
import com.showtime.service.UserService;

@Controller
public class ProfileController {
	
	@Autowired
	private BookingService bookingService;
	
	@Autowired
	private UserService userService;

	@GetMapping("/profile")
	public String showProfilePage(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		String selectedCity = (String) session.getAttribute("selectedCity");
		
		if(user == null) {
			return "redirect:/login";
		}
		
		model.addAttribute("user", user);
		model.addAttribute(selectedCity);
		
		return "profile";
	}
	
	// show personal info form
	@GetMapping("/profile/edit")
	public String showEditProfileForm(HttpSession session, Model model) {
		String selectedCity = (String) session.getAttribute("selectedCity");
		
		User user = (User) session.getAttribute("user");
		if(user == null) {
			return "redirect:/";
		}
		
		// pass user object to pre-fill the form
		model.addAttribute("user", user);
		model.addAttribute("selectedCity", selectedCity);
		
		return "personal-info";
	}
	
	// process personal info form
	@PostMapping("/profile/update")
	public String updateProfile(@ModelAttribute("user") User formData, HttpSession session, RedirectAttributes redirectAttributes) {
		User loggedInUser = (User) session.getAttribute("user");
		if(loggedInUser == null) {
			return "redirect:/login";
		}
		
		loggedInUser.setFullName(formData.getFullName());
		User updatedUser = userService.updateUser(loggedInUser);
		session.setAttribute("user", updatedUser);
		
		redirectAttributes.addFlashAttribute("successMessage", "Your profile has been updated successfully!");
		return "redirect:/profile";
	}
	
	
	@GetMapping("/booking-history")
	@Transactional(readOnly = true)
	public String showBookingHistoryPage(HttpSession session, Model model) {
		String selectedCity = (String) session.getAttribute("selectedCity");
		
		User user = (User) session.getAttribute("user");
		if(user == null) {
			return "redirect:/login";
		}
		
		List<Booking> allBookings = bookingService.getBookingsByUserId(user.getId());
		
		List<BookingHistoryViewModel> upcomingBookings = new ArrayList<>();
		List<BookingHistoryViewModel> pastBookings = new ArrayList<>();
		
		for(Booking booking : allBookings) {
			if(booking.getShowtime().getShowDate().isBefore(LocalDate.now())) {
				pastBookings.add(new BookingHistoryViewModel(booking));
			}else {
				upcomingBookings.add(new BookingHistoryViewModel(booking));
			}
		}
		
		model.addAttribute("upcomingBookings", upcomingBookings);
		model.addAttribute("pastBookings", pastBookings);
		model.addAttribute("user", user);
		model.addAttribute("selectedCity", selectedCity);
		
		return "booking-history";
	}
	
	
	// password change
	@PostMapping("/profile/change-password")
	public String changePassword(
			@RequestParam("currentPassword") String currentPassword,
			@RequestParam("newPassword") String newPassword,
			@RequestParam("confirmPassword") String confirmPassword,
			HttpSession session,
			RedirectAttributes redirectAttributes
			) {
		
		User user = (User) session.getAttribute("user");
		if(user == null) {
			return "redirect:/login";
		}
		
		// check new and confirm password matches or not
		if(!newPassword.equals(confirmPassword)) {
			redirectAttributes.addFlashAttribute("passwordErrorMessage", "New password and confirm password do not match.");
			return "redirect:/profile/edit";
		}
		
		boolean isSuccessfull = userService.changeUserPassword(user.getId(), currentPassword, newPassword);
		if(isSuccessfull) {
			redirectAttributes.addFlashAttribute("passwordSuccessMessage", "Password changed successfully!");
			return "redirect:/profile/edit";
		}else {
			redirectAttributes.addFlashAttribute("passwordErrorMessage", "Incorrect current password.");			
		}
		return "redirect:/profile/edit";
	} 
}
