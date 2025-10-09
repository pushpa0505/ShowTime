//package com.showtime.model;
//
//import java.time.Instant;
//import java.time.LocalDate;
//
//import javax.persistence.Column;
//import javax.persistence.Entity;
//import javax.persistence.GeneratedValue;
//import javax.persistence.GenerationType;
//import javax.persistence.Id;
//import javax.persistence.JoinColumn;
//import javax.persistence.ManyToOne;
//import javax.persistence.Table;
//
//@Entity
//@Table(name = "bookings")
//public class Booking {
//
//	@Id
//	@GeneratedValue(strategy = GenerationType.IDENTITY)
//	private int id;
//	
//	@ManyToOne
//	@JoinColumn(name = "showtime_id", nullable = false)
//	private Showtime showtime;
//	
//    @ManyToOne
//    @JoinColumn(name = "user_id", nullable = false)
//    private User user;
//	
//	private LocalDate bookingDate;
//	
//	@Column(name = "bookedSeats")
//	private String bookedSeats; // eg : A1, B1, C3 
//	
//	private double totalPrice;
//	
//	@Column(name = "paymentId")
//    private String paymentId;
//	
//	@Column(name = "status") // e.g., "CONFIRMED", "CANCELLED"
//    private String status;
//	
//
//	// GETTERS AND SETTERS
//	
//	public int getId() {
//		return id;
//	}
//
//	public void setId(int id) {
//		this.id = id;
//	}
//
//	public Showtime getShowtime() {
//		return showtime;
//	}
//
//	public void setShowtime(Showtime showtime) {
//		this.showtime = showtime;
//	}
//
//	public LocalDate getBookingDate() {
//		return bookingDate;
//	}
//
//	public void setBookingDate(LocalDate bookingDate) {
//		this.bookingDate = bookingDate;
//	}
//
//	public String getBookedSeats() {
//		return bookedSeats;
//	}
//
//	public void setBookedSeats(String bookedSeats) {
//		this.bookedSeats = bookedSeats;
//	}
//
//	public double getTotalPrice() {
//		return totalPrice;
//	}
//
//	public void setTotalPrice(double totalPrice) {
//		this.totalPrice = totalPrice;
//	}
//	
//	public User getUser() {
//		return user;
//	}
//
//	public void setUser(User user) {
//		this.user = user;
//	}
//
//	public String getPaymentId() {
//		return paymentId;
//	}
//
//	public void setPaymentId(String paymentId) {
//		this.paymentId = paymentId;
//	}
//
//	public String getStatus() {
//		return status;
//	}
//
//	public void setStatus(String status) {
//		this.status = status;
//	}
//	
//
//}


package com.showtime.model;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "bookings")
public class Booking {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@ManyToOne
	@JoinColumn(name = "showtime_id", nullable = false)
	private Showtime showtime;
	
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
	
	private LocalDate bookingDate;
	
	@Column(name = "bookedSeats")
	private String bookedSeats; // eg : A1, B1, C3 
	
	// --- NEW FIELDS FOR PRICE BREAKDOWN ---
	private double basePrice;   // Price of tickets only
	private double bookingFee;  // Convenience fee
	private double gst;         // Goods and Services Tax
	// --- ----------------------------- ---
	
	private double totalPrice;  // Final amount paid by user
	
	@Column(name = "paymentId")
    private String paymentId;
	
	@Column(name = "status") // e.g., "CONFIRMED", "CANCELLED"
    private String status;
	

	// GETTERS AND SETTERS
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Showtime getShowtime() {
		return showtime;
	}

	public void setShowtime(Showtime showtime) {
		this.showtime = showtime;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public LocalDate getBookingDate() {
		return bookingDate;
	}

	public void setBookingDate(LocalDate bookingDate) {
		this.bookingDate = bookingDate;
	}

	public String getBookedSeats() {
		return bookedSeats;
	}

	public void setBookedSeats(String bookedSeats) {
		this.bookedSeats = bookedSeats;
	}

	public double getBasePrice() {
		return basePrice;
	}

	public void setBasePrice(double basePrice) {
		this.basePrice = basePrice;
	}

	public double getBookingFee() {
		return bookingFee;
	}

	public void setBookingFee(double bookingFee) {
		this.bookingFee = bookingFee;
	}

	public double getGst() {
		return gst;
	}

	public void setGst(double gst) {
		this.gst = gst;
	}

	public double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getPaymentId() {
		return paymentId;
	}

	public void setPaymentId(String paymentId) {
		this.paymentId = paymentId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}
