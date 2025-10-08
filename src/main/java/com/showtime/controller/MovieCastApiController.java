package com.showtime.controller;

import com.showtime.model.Movie;
import com.showtime.service.MovieService;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

// @RestController tells Spring that this controller returns raw data, not views.
@RestController
@RequestMapping("/api/movies")
public class MovieCastApiController {

    @Autowired
    private MovieService movieService;

    @GetMapping("/{id}/cast")
    public ResponseEntity<List<String>> getMovieCast(@PathVariable("id") int id) {
        Movie movie = movieService.getMovieById(id);

        if (movie == null || movie.getCast() == null || movie.getCast().isEmpty()) {
            // Return an empty list if no movie or cast is found
            return ResponseEntity.ok(Collections.emptyList());
        }

        // Split the comma-separated string into a list of names
        List<String> castList = Arrays.asList(movie.getCast().split("\\s*,\\s*"));
        
        // Spring will automatically convert this List into JSON format
        return ResponseEntity.ok(castList);
    }
}