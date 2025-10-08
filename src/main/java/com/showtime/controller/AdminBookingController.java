package com.showtime.controller;

import com.showtime.model.AdminBookingViewModel;
import com.showtime.model.Booking;
import com.showtime.model.User;
import com.showtime.service.BookingService;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/bookings")
public class AdminBookingController {

    @Autowired
    private BookingService bookingService;

    private boolean isAdmin(HttpSession session) {
        User adminUser = (User) session.getAttribute("adminUser");
        return adminUser != null && "ADMIN".equals(adminUser.getRole());
    }

    @GetMapping
    public String showBookingManagementPage(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/admin/login";
        }

        List<Booking> allBookings = bookingService.getAllBookings();
        List<AdminBookingViewModel> bookingViewModels = new ArrayList<>();
        for (Booking booking : allBookings) {
            bookingViewModels.add(new AdminBookingViewModel(booking));
        }
        model.addAttribute("bookings", bookingViewModels);

        return "booking-management";
    }
}