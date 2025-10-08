package com.showtime.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LocationController {

	@PostMapping("/select-city")
	public String selectCity(@RequestParam("city") String city, HttpSession session) {
		session.setAttribute("selectedCity", city);
		return "redirect:/";
	}
}
