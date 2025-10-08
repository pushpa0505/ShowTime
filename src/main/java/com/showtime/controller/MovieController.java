package com.showtime.controller;

import com.showtime.model.Movie;
import com.showtime.model.User;
import com.showtime.service.MovieService;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/movies")
public class MovieController {

    @Autowired
    private MovieService movieService;
    
    private boolean isAdmin(HttpSession session) {
        User adminUser = (User) session.getAttribute("adminUser");
        return adminUser != null && "ADMIN".equals(adminUser.getRole());
    }

    @GetMapping
    public String showMovieManagementPage(@RequestParam(value = "search", required = false) String search, Model model, HttpSession session) {
    	if (!isAdmin(session)) return "redirect:/admin/login";
        List<Movie> movieList = movieService.getMovies(search);
        model.addAttribute("movies", movieList);
        model.addAttribute("currentSearch", search);

        if (!model.containsAttribute("movie")) {
            model.addAttribute("movie", new Movie());
        }
        return "movie-management";
    }

    @PostMapping("/add")
    public String addMovie(@Valid @ModelAttribute("movie") Movie movie,
                           BindingResult bindingResult,
                           Model model,
                           RedirectAttributes redirectAttributes,
                           HttpSession session) {
        
    	if (!isAdmin(session)) return "redirect:/admin/login";
    	
        if(bindingResult.hasErrors()) {
            model.addAttribute("movies", movieService.getAllMovies());
            return "movie-management";
        }
        
        movieService.addMovie(movie);
        redirectAttributes.addFlashAttribute("successMessage", "Movie added successfully!");
        return "redirect:/admin/movies";
    }
    
    @GetMapping("/edit/{id}")
    public String editMovie(@PathVariable("id") int id, Model model, HttpSession session) {
    	if (!isAdmin(session)) return "redirect:/admin/login";
    	
        Movie movie = movieService.getMovieById(id);
        model.addAttribute("movie", movie);
        model.addAttribute("movies", movieService.getAllMovies());
        return "movie-management"; 
    }
    
    @PostMapping("/update")
    public String updateMovie(@Valid @ModelAttribute("movie") Movie movie,
                              BindingResult bindingResult, // <-- CORRECTED ORDER
                              Model model,
                              RedirectAttributes redirectAttributes,
                              HttpSession session) {
        
    	if (!isAdmin(session)) return "redirect:/admin/login";
    	
        if(bindingResult.hasErrors()) {
            model.addAttribute("movies", movieService.getAllMovies());
            return "movie-management";
        }
        
        movieService.updateMovie(movie);
        redirectAttributes.addFlashAttribute("successMessage", "Movie : "+movie.getTitle() +" updated successfully!");
        return "redirect:/admin/movies";
    }
    
    @PostMapping("/delete/{id}")
    public String deleteMovie(@PathVariable("id") int id, RedirectAttributes redirectAttributes, HttpSession session) {
    	if (!isAdmin(session)) return "redirect:/admin/login";
    	Movie movie = movieService.getMovieById(id);
        movieService.deleteMovie(id); 
        redirectAttributes.addFlashAttribute("successMessage", "Movie : " +movie.getTitle()+ " deleted successfully!");
        return "redirect:/admin/movies";
    }
}