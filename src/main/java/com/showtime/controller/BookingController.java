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
	
	@Value("${razorpay.key.id}")
	private String razorpayKeyId;
	
	private static final double BOOKING_FEE_RATE = 0.10; // 10% convenience fee
	private static final double GST_RATE = 0.18; // 18% GST

	@PostMapping("/start")
	public String startBooking(
	        @RequestParam("showtimeId") int showtimeId,
	        @RequestParam("selectedSeats") List<String> selectedSeats,
	        HttpSession session,
	        RedirectAttributes redirectAttributes) { 
		
		// --- PRE-CHECK LOGIC (No changes here) ---
	    List<Booking> existingBookings = bookingService.getBookingByShowtime(showtimeId);
	    Set<String> alreadyBookedSeats = new HashSet<>();
	    for (Booking existingBooking : existingBookings) {
	        alreadyBookedSeats.addAll(Arrays.asList(existingBooking.getBookedSeats().split(",")));
	    }
	    for (String desiredSeat : selectedSeats) {
	        if (alreadyBookedSeats.contains(desiredSeat)) {
	            redirectAttributes.addFlashAttribute("errorMessage", "Sorry, seat " + desiredSeat + " was just booked. Please select different seats.");
	            return "redirect:/seat-selection/" + showtimeId;
	        }
	    }
	    // --- END OF PRE-CHECK ---
		
	    Showtime showtime = showtimeService.getShowtimeById(showtimeId);
	    int numberOfSeats = selectedSeats.size();
	    String bookedSeatsString = String.join(",", selectedSeats);
	    
	    // --- CORRECTED PRICE CALCULATION (SINGLE SOURCE OF TRUTH) ---
	    double basePrice = numberOfSeats * showtime.getTicketPrice();
	    double bookingFee = basePrice * BOOKING_FEE_RATE;
	    double gst = bookingFee * GST_RATE;
	    double finalTotal = basePrice + bookingFee + gst;

	    // Create and populate the booking object with ALL price details
	    Booking pendingBooking = new Booking();
	    pendingBooking.setShowtime(showtime);
	    pendingBooking.setBookedSeats(bookedSeatsString);
	    pendingBooking.setBookingDate(LocalDate.now());

        pendingBooking.setBasePrice(basePrice);
        pendingBooking.setBookingFee(bookingFee);
        pendingBooking.setGst(gst);
	    pendingBooking.setTotalPrice(finalTotal);

	    session.setAttribute("pendingBooking", pendingBooking);

	    return "redirect:/booking/details";
	}
	
	@GetMapping("/details")
	public String showBookingDetailsPage(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		
		Booking pendingBooking = (Booking) session.getAttribute("pendingBooking");
		User user = (User) session.getAttribute("user");
		String selectedCity = (String) session.getAttribute("selectedCity");
	    
		if(pendingBooking == null || user == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "Your session has expired. Please select your seats again.");
			return "redirect:/";
		}
		
		// --- NO RECALCULATION: Retrieve pre-calculated values directly ---
	    model.addAttribute("basePrice", pendingBooking.getBasePrice());
	    model.addAttribute("bookingFee", pendingBooking.getBookingFee());
	    model.addAttribute("gst", pendingBooking.getGst());
	    model.addAttribute("finalTotal", pendingBooking.getTotalPrice());
		
	    model.addAttribute("booking", pendingBooking);
		model.addAttribute("user", user);
		model.addAttribute("viewModel", new ShowtimeViewModel(pendingBooking.getShowtime()));
		model.addAttribute("selectedCity", selectedCity);
		
		model.addAttribute("razorpayKeyId", razorpayKeyId);
	    model.addAttribute("amountInPaise", (int)(pendingBooking.getTotalPrice() * 100));
	    
		return "booking-details";
	}
	
    // --- The rest of the controller methods (confirmBooking, showConfirmationPage, cancelBooking) remain unchanged. ---
	@PostMapping("/confirm")
	@Transactional
	public String confirmBooking(@RequestParam("razorpay_payment_id") String paymentId, HttpSession session, RedirectAttributes redirectAttributes) {
		Booking pendingBooking = (Booking) session.getAttribute("pendingBooking");
		User user = (User) session.getAttribute("user");
		if(pendingBooking == null || user == null) { return "redirect:/"; }
		List<String> desiredSeats = Arrays.asList(pendingBooking.getBookedSeats().split(","));
		List<Booking> existingBookings = bookingService.getBookingByShowtime(pendingBooking.getShowtime().getId());
		Set<String> alreadyBookedSeats = new HashSet<>();
		for(Booking existingBooking : existingBookings) {
			alreadyBookedSeats.addAll(Arrays.asList(existingBooking.getBookedSeats().split(",")));
		}
		for(String desiredSeat : desiredSeats) {
			if(alreadyBookedSeats.contains(desiredSeat)) {
				redirectAttributes.addFlashAttribute("errorMessage", "Sorry, one or more seats (" + desiredSeat + ") were booked by another user. Please select different seats.");
				return "redirect:/seat-selection/" + pendingBooking.getShowtime().getId();
			}
		}
		pendingBooking.setUser(user);
		pendingBooking.setStatus("CONFIRMED");
		pendingBooking.setPaymentId(paymentId);
		bookingService.createBooking(pendingBooking);
		session.removeAttribute("pendingBooking");
		return "redirect:/booking/confirmation/" + pendingBooking.getId();
	}
    
    @GetMapping("/confirmation/{bookingId}")
    @Transactional(readOnly = true)
    public String showConfirmationPage(@PathVariable("bookingId") int bookingId, Model model, HttpSession session) {
    	User loggedInUser = (User) session.getAttribute("user");
    	if(loggedInUser == null) { return "redirect:/"; }
        Booking booking = bookingService.getBookingById(bookingId);
        if(booking == null || booking.getUser().getId() != loggedInUser.getId()) { return "redirect:/"; }
        model.addAttribute("booking", booking);
        model.addAttribute("viewModel", new ShowtimeViewModel(booking.getShowtime()));
        String selectedCity = (String) session.getAttribute("selectedCity");
        model.addAttribute("selectedCity", selectedCity);
        return "confirmation";
    }
    
    @PostMapping("/cancel/{bookingId}")
    public String cancelBooking(@PathVariable("bookingId") int bookingId, HttpSession session, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) { return "redirect:/login"; }
        boolean isSuccessful = bookingService.cancelBooking(bookingId, user.getId());
        if (isSuccessful) {
            redirectAttributes.addFlashAttribute("successMessage", "Booking #" + bookingId + " has been cancelled.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Could not cancel the booking. Please try again.");
        }
        return "redirect:/booking-history";
    }
}
