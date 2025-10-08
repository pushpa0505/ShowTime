package com.showtime.controller;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.showtime.model.Booking;
import com.showtime.model.Showtime;
import com.showtime.model.ShowtimeViewModel;
import com.showtime.model.User;
import com.showtime.service.BookingService;
import com.showtime.service.ShowtimeService;

@Controller
@RequestMapping("/booking")
public class BookingController {
	
	@Autowired
	private ShowtimeService showtimeService;
	
	@Autowired
	private BookingService bookingService;
	
	@Value("${razorpay.key.id}") // Injects the key from config.properties
	private String razorpayKeyId;
	
	private static final double BOOKING_FEE_RATE = 0.10; // 10%
	private static final double GST_RATE = 0.18; // 18%

	@PostMapping("/start")
	public String startBooking(
	        @RequestParam("showtimeId") int showtimeId,
	        @RequestParam("selectedSeats") List<String> selectedSeats,
	        HttpSession session,
	        RedirectAttributes redirectAttributes) { 
		
		// --- PRE-CHECK LOGIC ---
	    
	    // 1. Get all seats that are ALREADY booked for this showtime from the database
	    List<Booking> existingBookings = bookingService.getBookingByShowtime(showtimeId);
	    Set<String> alreadyBookedSeats = new HashSet<>();
	    for (Booking existingBooking : existingBookings) {
	        alreadyBookedSeats.addAll(Arrays.asList(existingBooking.getBookedSeats().split(",")));
	    }

	    // 2. Check if any of the seats the user DESIRES are in the already-booked list
	    for (String desiredSeat : selectedSeats) {
	        if (alreadyBookedSeats.contains(desiredSeat)) {
	            // CONFLICT! The seat was booked by another user while this user was on the selection page.
	            // Redirect back to the seat selection page with an error.
	            redirectAttributes.addFlashAttribute("errorMessage", "Sorry, seat " + desiredSeat + " was just booked. Please select different seats.");
	            return "redirect:/seat-selection/" + showtimeId;
	        }
	    }
	    // --- END OF PRE-CHECK ---
		
	    
	    Showtime showtime = showtimeService.getShowtimeById(showtimeId);
	    int numberOfSeats = selectedSeats.size();
	    
	    // --- PRICE CALCULATION LOGIC ---
	    double basePrice = numberOfSeats * showtime.getTicketPrice();
	    double bookingFee = basePrice * BOOKING_FEE_RATE;
	    double gstOnFee = bookingFee * GST_RATE;
	    double finalTotal = basePrice + bookingFee + gstOnFee;

	    String bookedSeatsString = String.join(",", selectedSeats);

	    if (bookedSeatsString.startsWith(",")) {
	        bookedSeatsString = bookedSeatsString.substring(1);
	    }
	    
	    Booking pendingBooking = new Booking();
	    pendingBooking.setShowtime(showtime);
	    pendingBooking.setBookedSeats(bookedSeatsString);
	    pendingBooking.setTotalPrice(basePrice);
	    pendingBooking.setBookingDate(LocalDate.now());

	    session.setAttribute("pendingBooking", pendingBooking);

	    return "redirect:/booking/details";
	}
	
	@GetMapping("/details")
	public String showBookingDetailsPage(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		
		Booking pendingBooking = (Booking) session.getAttribute("pendingBooking");
		String selectedCity = (String) session.getAttribute("selectedCity");
	    
		User user = (User) session.getAttribute("user");
		
		if(pendingBooking == null || user == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "Please Register/Login to book your desired shows!");
			return "redirect:/";
		}
		
		
		// --- PRICE BREAKDOWN LOGIC ---
	    // double finalTotal = pendingBooking.getTotalPrice();
	    // We need to reverse-calculate the base price to show the breakdown
	    double basePrice = pendingBooking.getTotalPrice();
	    double bookingFee = basePrice * BOOKING_FEE_RATE;
	    double gstOnFee = bookingFee * GST_RATE;
	    double finalTotal = basePrice + bookingFee + gstOnFee;
	    // Pass all price components to the JSP
	    model.addAttribute("basePrice", basePrice);
	    model.addAttribute("bookingFee", bookingFee);
	    model.addAttribute("gstOnFee", gstOnFee);
	    model.addAttribute("finalTotal", finalTotal);
		
	    
		model.addAttribute("booking", pendingBooking);
		model.addAttribute("user", user);
		model.addAttribute("viewModel", new ShowtimeViewModel(pendingBooking.getShowtime()));
		model.addAttribute("selectedCity", selectedCity);
		
		// --- Add Razorpay Key and Amount to the model ---
	    model.addAttribute("razorpayKeyId", razorpayKeyId);
	    // Razorpay requires the amount in the smallest currency unit (e.g., paise for INR)
	    model.addAttribute("amountInPaise", (int)(finalTotal * 100));
	    
		return "booking-details";
	}
	
	@PostMapping("/confirm")
	@Transactional
	public String confirmBooking(@RequestParam("razorpay_payment_id") String paymentId, HttpSession session, RedirectAttributes redirectAttributes) {
		
		Booking pendingBooking = (Booking) session.getAttribute("pendingBooking");
		User user = (User) session.getAttribute("user");
		
		if(pendingBooking == null || user == null) {
			return "redirect:/";
		}
				
		// get all seats user wants to book
		List<String> desiredSeats = Arrays.asList(pendingBooking.getBookedSeats().split(","));
		
		// get all seats that are already booked for this showtime
		List<Booking> existingBookings = bookingService.getBookingByShowtime(pendingBooking.getShowtime().getId());
		Set<String> alreadyBookedSeats = new HashSet<>();
		for(Booking existingBooking : existingBookings) {
			alreadyBookedSeats.addAll(Arrays.asList(existingBooking.getBookedSeats().split(",")));
		}
		
		// check for any overlap (2 user booking same ticket at a time)
		for(String desiredSeat : desiredSeats) {
			if(alreadyBookedSeats.contains(desiredSeat)) {
				// CONFLICT! One of the seats was just booked.
				redirectAttributes.addFlashAttribute("errorMessage", "Sorry, one or more seat (" + desiredSeat + ") were booked by another user. Please select diiferent seats.");
				return "redirect:/seat-selection/" + pendingBooking.getShowtime().getId();
			}
		}
		
		pendingBooking.setUser(user);
		pendingBooking.setStatus("CONFIRMED");
		pendingBooking.setPaymentId(paymentId);
		
		System.out.println("--- PAYMENT SUCCESSFUL ---");
	    System.out.println("Razorpay Payment ID: " + paymentId);
	    
		bookingService.createBooking(pendingBooking);
		session.removeAttribute("pendingBooking");
		
		
		
		return "redirect:/booking/confirmation/" + pendingBooking.getId();
	}
    
    @GetMapping("/confirmation/{bookingId}")
    @Transactional(readOnly = true)
    public String showConfirmationPage(@PathVariable("bookingId") int bookingId, Model model, HttpSession session) {
    	
    	User loggedInUser = (User) session.getAttribute("user");
    	if(loggedInUser == null) {
    		return "redirect:/";
    	}
    	
    	// If booking doesn't exist OR if the booking's user ID doesn't match the logged-in user's ID
        Booking booking = bookingService.getBookingById(bookingId);
        if(booking == null || booking.getUser().getId() != loggedInUser.getId()) {
        	return "redirect:/"; // Redirect them away.
        }
        
        model.addAttribute("booking", booking);
        model.addAttribute("viewModel", new ShowtimeViewModel(booking.getShowtime()));
        
        String selectedCity = (String) session.getAttribute("selectedCity");
        model.addAttribute("selectedCity", selectedCity);

        return "confirmation";
    }
    
    // Cancel booking 
    @PostMapping("/cancel/{bookingId}")
    public String cancelBooking(@PathVariable("bookingId") int bookingId, HttpSession session, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        boolean isSuccessful = bookingService.cancelBooking(bookingId, user.getId());

        if (isSuccessful) {
            redirectAttributes.addFlashAttribute("successMessage", "Booking #" + bookingId + " has been cancelled.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Could not cancel the booking. Please try again.");
        }

        return "redirect:/booking-history";
    }
}
