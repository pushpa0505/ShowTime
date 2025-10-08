package com.showtime.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.showtime.model.Movie;
import com.showtime.service.MovieService;
import com.showtime.service.ShowtimeService;

@Controller
public class HomeController {

	@Autowired
	private MovieService movieService;
	
	@Autowired
	private ShowtimeService showtimeService;
	
	@GetMapping("/")
	public String showHomePage(Model model, HttpSession session) {
        String selectedCity = (String) session.getAttribute("selectedCity");
        if(selectedCity == null) {
        	model.addAttribute("showCityModal", true);
        }else {
        	model.addAttribute("showCityModal", false);
        	model.addAttribute("selectedCity", selectedCity);
        	
        	Movie latestMovie = movieService.findLatestMovieByCity(selectedCity);
            model.addAttribute("latestMovie", latestMovie);
        	
        	List<Movie> nowShowingMovies = movieService.getMoviesByStatusAndCity("Now Showing", selectedCity);
            List<Movie> upcomingMovies = movieService.getMoviesByStatus("Upcoming");

            // Add these lists to the model to make them available in the JSP
            model.addAttribute("nowShowingMovies", nowShowingMovies);
            model.addAttribute("upcomingMovies", upcomingMovies);

        }
        // Return the name of the JSP file
        return "index";	
    }
	
	@GetMapping("/movie/{id}")
	public String movieDetailPage(@PathVariable("id") int id, Model model, HttpSession session) {
		String selectedCity = (String) session.getAttribute("selectedCity");
		if (selectedCity == null) {
		    // If no city is selected, redirect to home to force selection
		    return "redirect:/";
		}
		
	    model.addAttribute("selectedCity", selectedCity);
	    
		Movie movie = movieService.getMovieById(id);
		
		if(movie == null) {
			return "redirect:/";
		}
		
		model.addAttribute("movie", movie);
		
		if (selectedCity != null) {
	        List<String> availableLanguages = showtimeService.getLanguagesByMovieAndCity(id, selectedCity);
	        model.addAttribute("availableLanguages", availableLanguages);
	    }
		return "movie-details";
	}
	
	@GetMapping("/search")
	public String searchMovies(@RequestParam("query") String query, Model model, HttpSession session) {
		String selectedCity = (String) session.getAttribute("selectedCity");
		if(selectedCity == null) {
			return "redirect:/";
		}
		
		if (query == null || query.trim().isEmpty()) {
	        // If the search is empty, just redirect back to the home page.
	        return "redirect:/";
	    }
		
		List<Movie> searchResults = movieService.searchMoviesInCity(query, selectedCity);
		
		model.addAttribute("searchResults", searchResults);
		model.addAttribute("selectedCity", selectedCity);
		model.addAttribute("searchQuery", query);
		
		return "search-results";
	}
}
