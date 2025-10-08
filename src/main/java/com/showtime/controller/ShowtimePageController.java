package com.showtime.controller;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.showtime.model.DateChip;
import com.showtime.model.Movie;
import com.showtime.model.Showtime;
import com.showtime.model.ShowtimeViewModel;
import com.showtime.service.BookingService;
import com.showtime.service.MovieService;
import com.showtime.service.ShowtimeService;

@Controller
public class ShowtimePageController {

    @Autowired
    private MovieService movieService;
    
    @Autowired
    private ShowtimeService showtimeService;
    
    @Autowired
    private BookingService bookingService;

    @GetMapping("/showtimes")
    public String showShowtimesPage(
            @RequestParam("movieId") int movieId,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
            @RequestParam(required = false) String language,
            HttpSession session,
            Model model) {

        String selectedCity = (String) session.getAttribute("selectedCity");
        if (selectedCity == null) {
            return "redirect:/";
        }

        LocalDate selectedDate = (date == null) ? LocalDate.now() : date;
        List<DateChip> dateChipList = createDateChipList();
        
        Movie movie = movieService.getMovieById(movieId);
        model.addAttribute("movie", movie);
        model.addAttribute("selectedCity", selectedCity);
        model.addAttribute("selectedDate", selectedDate);
        model.addAttribute("dateList", dateChipList);
        
     // --- UPDATED LANGUAGE & FILTERING LOGIC ---
        List<Showtime> allShowtimesForDay = showtimeService.getByMovieAndCityAndDate(movieId, selectedCity, selectedDate);
        
        List<String> availableLanguages = showtimeService.getLanguagesByMovieAndCity(movieId, selectedCity);
        model.addAttribute("availableLanguages", availableLanguages);
        
//        Set<String> availableLanguages = new HashSet<>();
//        for (Showtime showtime : allShowtimesForDay) {
//            availableLanguages.add(showtime.getLanguage());
//        }

        String selectedLanguage = language;
        // If no language is passed in the URL OR if the passed language is not available, select a default.
        if (selectedLanguage == null || !availableLanguages.contains(selectedLanguage)) {
            if (!availableLanguages.isEmpty()) {
                selectedLanguage = availableLanguages.iterator().next(); // Pick the first available one
            }
        }
        
        model.addAttribute("availableLanguages", availableLanguages);
        model.addAttribute("selectedLanguage", selectedLanguage);

        List<Showtime> filteredShowtimes = new ArrayList<>();
        if (selectedLanguage != null) {
            for (Showtime showtime : allShowtimesForDay) {
                if (showtime.getLanguage().equalsIgnoreCase(selectedLanguage)) {
                    filteredShowtimes.add(showtime);
                }
            }
        } else {
            filteredShowtimes = allShowtimesForDay;
        }

        // Filter for past showtimes on the current day (same as before)
        if (selectedDate.isEqual(LocalDate.now())) {
            LocalTime currentTime = LocalTime.now();
            List<Showtime> futureShowtimes = new ArrayList<>();
            for (Showtime showtime : filteredShowtimes) {
                if (showtime.getStartTime().isAfter(currentTime)) {
                    futureShowtimes.add(showtime);
                }
            }
            filteredShowtimes = futureShowtimes;
        }
        
        // Chef prepares a new list, converting each showtime into a ViewModel with a formatted time string
        List<ShowtimeViewModel> showtimeViewModels = new ArrayList<>();
        for (Showtime showtime : filteredShowtimes) {
            showtimeViewModels.add(new ShowtimeViewModel(showtime));
        }
        
        // The controller sends the final, easy-to-use list to the JSP
        model.addAttribute("showtimes", showtimeViewModels);

        return "showtimes";
    }

    // date list helper method
    private List<DateChip> createDateChipList() {
        List<DateChip> dateChipList = new ArrayList<>();
        DateTimeFormatter dayOfWeekFormatter = DateTimeFormatter.ofPattern("EEE");
        DateTimeFormatter dayAndMonthFormatter = DateTimeFormatter.ofPattern("dd MMM");
        for (int i = 0; i < 7; i++) {
            LocalDate currentDate = LocalDate.now().plusDays(i);
            DateChip chip = new DateChip();
            chip.setDateValue(currentDate);
            chip.setDayOfWeek(currentDate.format(dayOfWeekFormatter));
            chip.setDayAndMonth(currentDate.format(dayAndMonthFormatter));
            dateChipList.add(chip);
        }
        return dateChipList;
    }
    
    // method for showing seat selection page
    @GetMapping("/seat-selection/{showtimeId}")
    public String showSeatSelectionPage(@PathVariable("showtimeId") int showtimeId, Model model, HttpSession session) {
        
        // Check for a selected city, redirect if not present
        String selectedCity = (String) session.getAttribute("selectedCity");
        if (selectedCity == null) {
            return "redirect:/";
        }
        model.addAttribute("selectedCity", selectedCity);

        // Fetch the specific showtime the user clicked on
        Showtime showtime = showtimeService.getShowtimeById(showtimeId);
        
        if (showtime == null) {
            // If the showtime doesn't exist, redirect home
            return "redirect:/";
        }

        // Pass the showtime object to the JSP
        model.addAttribute("showtime", showtime);
        
        // We can also pass a ViewModel for the formatted time, just like before
        model.addAttribute("viewModel", new ShowtimeViewModel(showtime));
        
        List<String> bookingStrings = bookingService.getBookedSeats(showtimeId);
        Set<String> bookedSeats = new HashSet<>();
        for(String bookingString : bookingStrings) {
        	bookedSeats.addAll(Arrays.asList(bookingString.split(",")));
        }

        model.addAttribute("bookedSeats", bookedSeats);
        return "seat-selection";
    }
    
    
}