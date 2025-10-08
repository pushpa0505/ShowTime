package com.showtime.controller;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.showtime.model.Theater;
import com.showtime.model.User;
import com.showtime.service.TheaterService;

@Controller
@RequestMapping("/admin/theaters")
public class TheaterController {
	
	@Autowired
	private TheaterService theaterService;
	
	private boolean isAdmin(HttpSession session) {
        User adminUser = (User) session.getAttribute("adminUser");
        return adminUser != null && "ADMIN".equals(adminUser.getRole());
    }
	
	@GetMapping
	public String showTheaterManagementPage(Model model, HttpSession session) {
		if (!isAdmin(session)) return "redirect:/admin/login";
		
		List<Theater> theaterList = theaterService.getAllTheaters();
		model.addAttribute("theaters", theaterList);
		if (!model.containsAttribute("theater")) {
            model.addAttribute("theater", new Theater());
        }
		return "theater-management";
	}
	
	@PostMapping("/add")
	public String addTheater(
			@Valid 
			@ModelAttribute("theater") Theater theater,
			BindingResult bindingResult,
			RedirectAttributes redirectAttributes,
			Model model,
			HttpSession session) {
		
		if (!isAdmin(session)) return "redirect:/admin/login";
		
		if (bindingResult.hasErrors()) {
			model.addAttribute("theaters", theaterService.getAllTheaters());
			return "theater-management";
		}
		
		theaterService.addTheater(theater);
		redirectAttributes.addFlashAttribute("successMessage", "Theater added successfully!");
		
		return "redirect:/admin/theaters";
	}
	
	@PostMapping("/delete/{id}")
	public String deleteTheater(@PathVariable("id") int id, RedirectAttributes redirectAttributes, HttpSession session) {
		if (!isAdmin(session)) return "redirect:/admin/login";
		
		theaterService.deleteTheater(id);
		redirectAttributes.addFlashAttribute("successMessage", "Theater deleted successfullly!");
		return "redirect:/admin/theaters";
	}
	
	@GetMapping("/edit/{id}")
	public String showEditForm(@PathVariable("id") int id, Model model, HttpSession session) {
		if (!isAdmin(session)) return "redirect:/admin/login";
		
		Theater theater = theaterService.getTheaterById(id);
		model.addAttribute("theater", theater);
		model.addAttribute("theaters", theaterService.getAllTheaters());
		return "theater-management";
	}
	
	@PostMapping("/update")
	public String updateTheater(
			@Valid 
			@ModelAttribute Theater theater,
			BindingResult bindingResult,
			Model model,
			RedirectAttributes redirectAttributes,
			HttpSession session) {
		
		if (!isAdmin(session)) return "redirect:/admin/login";
		
		if(bindingResult.hasErrors()) {
			model.addAttribute("theaters", theaterService.getAllTheaters());
			return "theater-management";
		}
		theaterService.updateTheater(theater);
		redirectAttributes.addFlashAttribute("successMessage", "Theater updated successfully!");
		return "redirect:/admin/theaters";
	}
	
	
}
