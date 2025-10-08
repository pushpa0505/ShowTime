<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Details</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700&family=Righteous&display=swap" rel="stylesheet">
    <style> 
        body { font-family: 'Figtree', sans-serif; background-color: #f8f8f8; } 
        .logo-font { font-family: 'Righteous', cursive; }
        /* Custom rotation for the arrow */
        .rotate-0 { transform: rotate(0deg); }
        .rotate-180 { transform: rotate(180deg); }
        .transition-transform { transition-property: transform; transition-duration: 300ms; }
    </style>
</head>
<body class="text-gray-900 flex flex-col min-h-screen">

    <!-- HEADER -->
	<jsp:include page="header.jsp" />

    <main class="container mx-auto px-4 sm:px-6 lg:px-8 py-6 flex-grow pb-24">
	    <div class="flex items-center space-x-4 mb-6 max-w-2xl mx-auto">
	        <a href="${pageContext.request.contextPath}/seat-selection/${booking.showtime.id}" class="text-gray-600 hover:text-red-500">
	            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
	                <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" />
	            </svg>
	        </a>
	        <div>
	            <h1 class="text-xl font-bold">Booking Details</h1>
	        </div>
	    </div>
	
	    <div class="max-w-2xl mx-auto space-y-4">
	        <div class="bg-white p-4 rounded-xl shadow-md border border-gray-100">
	            <div class="flex space-x-4 pb-4"> 
	                <img src="${booking.showtime.movie.posterUrl}" alt="Movie Poster" class="w-20 h-28 object-cover rounded-lg flex-shrink-0">
	                <div class="flex-1 flex flex-col"> 
	                    <h3 class="font-bold text-xl mb-1">${booking.showtime.movie.title}</h3>
	                    <p class="text-sm text-gray-600 space-x-1 mb-2">
	                        <span class="font-semibold">${booking.showtime.movie.certificate}</span>
	                        <span class="text-gray-400">•</span>
	                        <span>${booking.showtime.language}</span>
	                        <span class="text-gray-400">•</span>
	                        <span>${booking.showtime.movie.duration}</span>
	                    </p>
	                    <p class="text-sm text-gray-500">${booking.showtime.theater.name}, ${booking.showtime.theater.location}, ${booking.showtime.theater.city}</p> 
	                </div>
	            </div>
	            <hr class="my-3 border-t border-gray-200">
	            <div class="py-2">
	                <div class="flex items-center justify-start space-x-4 text-base font-semibold mb-3">
	                    <p>${viewModel.formattedDayOfWeek}, ${viewModel.formattedDayAndMonth}</p>
	                    <p class="text-red-600">|</p>
	                    <p>${viewModel.formattedStartTime}</p>
	                </div>
	                <div class="flex justify-between items-center text-gray-800">
	                    <div class="text-base">
	                        <%-- Calculate number of tickets from the bookedSeats string --%>
	                        <c:set var="seatCount" value="${fn:length(fn:split(booking.bookedSeats, ','))}" />
	                        <span class="font-semibold">${seatCount} ${seatCount > 1 ? 'tickets' : 'ticket'}</span>
	                        <p class="text-sm text-gray-500 font-normal mt-0.5">${booking.bookedSeats}</p>
	                    </div>
	                </div>
	            </div>
	        </div>
			
			<!-- PAYMENT SUMMARY -->
	        <h2 class="text-xl font-bold mt-6 mb-4">Payment summary</h2>
				<div class="bg-white p-6 rounded-xl shadow-md border border-gray-100">
				    
				    <div class="space-y-3 text-gray-800">
				        <button class="flex justify-between items-center w-full text-base font-medium toggle-details" data-target="order-details" data-arrow="order-arrow">
				            <div class="flex items-center space-x-2 text-gray-900">
				                <span>Order amount</span>
				                <svg id="order-arrow" xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-400 rotate-0 transition-transform flex-shrink-0" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" /></svg>
				            </div>
				            <span class="font-medium text-gray-900 flex-shrink-0">₹<fmt:formatNumber value="${basePrice}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
				        </button>
				        
				        <div id="order-details" class="space-y-3 hidden">
				            <div class="flex justify-between items-center text-sm ml-4 text-gray-600">
				                <span>${seatCount} x ticket</span>
				                <span>₹<fmt:formatNumber value="${basePrice}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
				                
				            </div>
				        </div>
				        
				        <button class="flex justify-between items-start w-full text-base font-medium toggle-details" data-target="booking-details" data-arrow="booking-arrow">
				            <div class="flex items-center space-x-2 text-gray-900">
				                <span class="text-left leading-tight">Booking charge<br>(inc. of GST)</span>
				                <svg id="booking-arrow" xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-400 rotate-0 transition-transform flex-shrink-0" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" /></svg>
				            </div>
				            <span class="font-medium text-gray-900 flex-shrink-0">₹<fmt:formatNumber value="${bookingFee + gstOnFee}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
				            
				        </button>
				
				        <div id="booking-details" class="space-y-3 hidden">
				            <div class="flex justify-between items-center text-sm ml-4 text-gray-600">
				                <span>Booking Charge</span>
				                <span>₹<fmt:formatNumber value="${bookingFee}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
				                
				            </div>
				            <div class="flex justify-between items-center text-sm ml-4 text-gray-600">
				                <span>IGST</span>
				                <span>₹<fmt:formatNumber value="${gstOnFee}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
				                
				            </div>
				        </div>
				    </div>
				
				    <hr class="my-4 border-t border-gray-200">
				    
				    <div class="flex justify-between items-center text-lg font-bold">
				        <span>To be paid</span>
				        <span class="text-lg">₹<fmt:formatNumber value="${finalTotal}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
				        
				    </div>
				</div>
	
	        <div class="bg-white p-6 rounded-xl shadow-md border border-gray-100">
	            <h2 class="text-xl font-bold mb-4">Your details</h2>
	            <div class="flex items-start p-4 bg-gray-50 rounded-lg">
	                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-gray-600 mr-3 mt-1 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" /></svg>
	                <div>
	                    <p class="font-semibold text-base mb-1">${user.fullName}</p>
	                    <p class="text-sm text-gray-600">${user.email}</p>
	                </div>
	            </div>
	        </div>
	    </div>
	</main>
	
	<div class="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 shadow-xl z-40">
	    <div class="container mx-auto max-w-2xl px-4 sm:px-6 lg:px-8 py-2">
	        <form id="payment-form" action="${pageContext.request.contextPath}/booking/confirm" method="post">	
		    <input type="hidden" name="razorpay_payment_id" id="razorpay_payment_id">
		    
		    <button type="button" id="pay-button" class="w-full flex justify-between items-center bg-red-500 hover:bg-red-600 text-white font-bold py-2 px-6 rounded-lg transition-colors text-lg shadow-md">
		        <div class="text-left">
		            <span class="block text-xs font-normal opacity-80">TOTAL</span>
		            <span class="block text-xl">₹<fmt:formatNumber value="${finalTotal}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
		        </div>
		        <span class="text-xl">Proceed To Pay</span>
		    </button>
		</form>
	    </div>
	</div>

    <script>
	        // --- NEW: COLLAPSIBLE PAYMENT SUMMARY LOGIC ---
	        const toggleButtons = document.querySelectorAll('.toggle-details');
	
	        toggleButtons.forEach(button => {
	            button.addEventListener('click', function() {
	                const targetId = this.dataset.target;
	                const arrowId = this.dataset.arrow;
	                const targetElement = document.getElementById(targetId);
	                const arrowElement = document.getElementById(arrowId);
	
	                targetElement.classList.toggle('hidden');
	                arrowElement.classList.toggle('rotate-180');
	            });
	        });
	</script>
	
	<!-- Razorpay script -->
	<script>
	    document.getElementById('pay-button').onclick = function(e){
	        var options = {
	            "key": "${razorpayKeyId}",
	            "amount": "${amountInPaise}", // Amount is in currency subunits. Default currency is INR.
	            "currency": "INR",
	            "name": "ShowTime",
	            "description": "Movie Ticket Booking",
	            "image": "https://your_logo_url", //Optional
	            "handler": function (response){
	                // This function is called on a successful payment
	                console.log("Payment successful!");
	                console.log("Payment ID: " + response.razorpay_payment_id);
	
	                // Add the payment ID to our hidden form input
	                document.getElementById('razorpay_payment_id').value = response.razorpay_payment_id;
	
	                // Submit the form to our server to confirm the booking
	                document.getElementById('payment-form').submit();
	            },
	            "prefill": {
	                "name": "${user.fullName}",
	                "email": "${user.email}"
	            },
	            "theme": {
	                "color": "#ef4444"
	            }
	        };
	        var rzp1 = new Razorpay(options);
	        rzp1.open();
	        e.preventDefault();
	    };
	</script>
</body>

</html>
