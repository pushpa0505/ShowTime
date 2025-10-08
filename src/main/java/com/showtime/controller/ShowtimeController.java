package com.showtime.controller;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.showtime.model.Movie;
import com.showtime.model.Showtime;
import com.showtime.model.Theater;
import com.showtime.model.User;
import com.showtime.service.MovieService;
import com.showtime.service.ShowtimeService;
import com.showtime.service.TheaterService;

@Controller
@RequestMapping("/admin/showtimes")
public class ShowtimeController {

	@Autowired
	private ShowtimeService showtimeService;
	
	@Autowired
	private MovieService movieService;
	
	@Autowired
	private TheaterService theaterService;
	
	private boolean isAdmin(HttpSession session) {
        User adminUser = (User) session.getAttribute("adminUser");
        return adminUser != null && "ADMIN".equals(adminUser.getRole());
    }
	
	@GetMapping
	public String showShowtimeManagementPage(
			@RequestParam(value = "theaterId", required = false) Integer theaterId,
			@RequestParam(value = "date", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date,
			Model model,
			HttpSession session) {
		if (!isAdmin(session)) return "redirect:/admin/login";
		
		// load all the theaters
		model.addAttribute("theaters", theaterService.getAllTheaters());
		
		if(theaterId != null && date != null) {
			List<Showtime> showtimeList = showtimeService.getShowtimesByTheaterAndDate(theaterId, date);
			model.addAttribute("showtimes", showtimeList);
		}
		
		// Add selected values back to the model to keep the filters populated
		model.addAttribute("selectedTheaterId", theaterId);
		model.addAttribute("selectedDate", date);
		
		// for add show time drop-down of movies field
		model.addAttribute("movies", movieService.getAllMovies());
		
		return "showtime-management";
	}
	
	@PostMapping("/add")
	public String addShowtime(
			@RequestParam(value = "movieId", required = false) Integer movieId,
			@RequestParam(value = "theaterId", required = false) Integer theaterId,
			@RequestParam(value = "showDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate showDate,
			@RequestParam(value = "startTime", required = false) @DateTimeFormat(pattern = "HH:mm") LocalTime startTime,
			@RequestParam(value = "ticketPrice", required = false) Double ticketPrice,
			@RequestParam("language") String language,		
			RedirectAttributes redirectAttributes,
			HttpSession session) {
		if (!isAdmin(session)) return "redirect:/admin/login";
		
		if(movieId == null || movieId == 0) {
			redirectAttributes.addFlashAttribute("errorMessage", "Please select a movie.");
			return "redirect:/admin/showtimes";
		}
		if (theaterId == null || theaterId == 0) {
	        redirectAttributes.addFlashAttribute("errorMessage", "Please select a theater.");
	        return "redirect:/admin/showtimes";
	    }
	    if (showDate == null) {
	        redirectAttributes.addFlashAttribute("errorMessage", "Please select a valid date.");
	        return "redirect:/admin/showtimes";
	    }
	    if (startTime == null) {
	        redirectAttributes.addFlashAttribute("errorMessage", "Please select a valid time.");
	        return "redirect:/admin/showtimes";
	    }
	    if (ticketPrice == null || ticketPrice <= 0) {
	        redirectAttributes.addFlashAttribute("errorMessage", "Please enter a valid ticket price.");
	        return "redirect:/admin/showtimes";
	    }
	    if (language == null || language.trim().isEmpty()) {
	        redirectAttributes.addFlashAttribute("errorMessage", "Please enter a language.");
	        return "redirect:/admin/showtimes";
	    }
	    
	    Movie movie = movieService.getMovieById(movieId);
	    Theater theater = theaterService.getTheaterById(theaterId);
	    
	    Showtime showtime = new Showtime();
	    showtime.setMovie(movie);
	    showtime.setTheater(theater);
	    showtime.setShowDate(showDate);
	    showtime.setStartTime(startTime);
	    showtime.setTicketPrice(ticketPrice);
	    showtime.setLanguage(language);
	    
		showtimeService.addShowtime(showtime);
		
		redirectAttributes.addFlashAttribute("successMessage", "Showtime added successfully!");
		return "redirect:/admin/showtimes";
	}
	
	@PostMapping("/delete/{id}")
	public String deleteShowtime(@PathVariable("id") int id, RedirectAttributes redirectAttributes, HttpSession session) {
		if (!isAdmin(session)) return "redirect:/admin/login";
		
		showtimeService.deleteShowtime(id);
		redirectAttributes.addFlashAttribute("successMessage", "Showtime added successfully!");
		return "redirect:/admin/showtimes";
	}
}
