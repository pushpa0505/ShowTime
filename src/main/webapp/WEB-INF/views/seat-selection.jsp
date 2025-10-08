<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Seats - ${showtime.movie.title}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700&family=Righteous&display=swap" rel="stylesheet">
    <style>
	    body { font-family: 'Figtree', sans-serif; background-color: #ffffff; }
	    .seat { 
	        width: 30px; height: 30px; display: flex; align-items: center; justify-content: center; 
	        font-size: 11px; font-weight: 500; border-radius: 4px; cursor: pointer; 
	        transition: all 0.2s ease; border: 1px solid #cbd5e1; color: #475569; 
	    }
	    @media (max-width: 640px) { .seat { width: 22px; height: 22px; font-size: 8px; border-radius: 3px; } }
	
	    /* 1. Hide the actual checkbox completely */
	    input[type="checkbox"].seat-checkbox {
	        display: none;
	    }
	
	    /* 2. Style the seat based on its state */
	    .seat.available:hover { border-color: #ef4444; }
	    .seat.booked { background-color: #e5e7eb; border-color: #e5e7eb; cursor: not-allowed; }
	
	    /* 3. When the hidden checkbox is checked, style the .seat label that comes after it */
	    input[type="checkbox"].seat-checkbox:checked + .seat {
	        background-color: #ef4444;
	        color: white;
	        border-color: #ef4444;
	    }

	    .time-chip.active { background-color: #ef4444; color: white; border-color: #ef4444; }
	    .logo-font { font-family: 'Righteous', cursive; }
	</style>
</head>
<body class="text-gray-900 flex flex-col min-h-screen">

    <!-- Header -->
    <jsp:include page="header.jsp" />

    <main id="main-container" class="container mx-auto px-2 sm:px-6 lg:px-8 py-6 flex-grow mb-24">
    	
    	<!-- Error Messages -->
    	<div id="flash-error-message" class="hidden fixed top-5 left-1/2 -translate-x-1/2 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-lg shadow-lg z-50 transition-opacity duration-300" role="alert">
	        <span class="block sm:inline">Maximum 10 seats at a time.</span> 
	    </div>
    	<c:if test="${not empty errorMessage}">
	        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4 max-w-4xl mx-auto" role="alert">
	            <span class="block sm:inline">${errorMessage}</span>
	        </div>
	    </c:if>
	    
	    <!-- Movie and showtime details -->
        <div class="flex items-center space-x-4 mb-6">
            <a href="${pageContext.request.contextPath}/showtimes?movieId=${showtime.movie.id}&date=${showtime.showDate}" class="text-gray-600 hover:text-red-500">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" />
                </svg>
            </a>
            <div>
                <h1 class="text-lg font-bold">${showtime.movie.title}</h1>
                <p class="text-xs text-gray-500">${showtime.theater.name}, ${showtime.theater.location}, ${showtime.theater.city}</p>
                <p class="text-xs text-gray-500 mt-1">${showtime.movie.certificate} • ${showtime.language} • ${showtime.movie.duration}</p>
            </div>
        </div>
        <div class="mb-6 flex items-center space-x-4 ml-10">
            <div class="text-center flex-shrink-0">
                 <p class="font-bold text-sm">${viewModel.formattedDayOfWeek}</p>
                 <p class="text-xs text-gray-500">${viewModel.formattedDayAndMonth}</p>
            </div>
            
            <div class="flex items-center space-x-2">
                <button class="time-chip active text-sm font-semibold py-2 px-4 rounded-md flex-shrink-0">
                    ${viewModel.formattedStartTime}
                </button>
            </div>  
        </div>

		<!-- Form for submitting seats data -->
        <form id="booking-form" action="${pageContext.request.contextPath}/booking/start" method="post">
            <input type="hidden" name="showtimeId" value="${showtime.id}">
            
            <div class="flex flex-col items-center">
            
	            <!-- Movie Ticket price -->
                <div class="w-full text-center mb-4">
                    <p class="text-gray-600 font-semibold border-b pb-2">CLASSIC : ₹ <fmt:formatNumber value="${showtime.ticketPrice}" type="number" minFractionDigits="2" maxFractionDigits="2"/></p>
                </div>
                
                <!-- seating chart -->
                <div id="seating-chart" class="flex flex-col items-center space-y-2 sm:space-y-3 mb-8 overflow-x-auto pb-4">
				    <c:set var="rows" value="ABCDEFGH" />
				    <c:forEach var="row" items="${rows.split('')}">
				        <div class="flex items-center space-x-1 sm:space-x-2">
				            <span class="w-6 text-center font-semibold text-gray-500 text-xs sm:text-base">${row}</span>
				            
				            <!-- Loop for generating seat blocks as available & booked, setting seat name as A-1,B-4 hidden. -->
				            <c:forEach var="i" begin="1" end="10">
				                <c:if test="${i == 4 || i == 8}"><div class="w-4 sm:w-8"></div></c:if>
				
				                <c:set var="seatId" value="${row}-${i}" />
				                <c:choose>
				                    <c:when test="${bookedSeats.contains(seatId)}">
				                        <%-- A booked seat: disabled checkbox and a label with the "booked" class --%>
				                        <input type="checkbox" id="seat-${seatId}" class="seat-checkbox" disabled>
				                        <label class="seat booked">${i}</label>
				                    </c:when>
				                    <c:otherwise>
				                        <%-- An available seat: a hidden checkbox and a label styled with the "seat" class --%>
				                        <input type="checkbox" id="seat-${seatId}" name="selectedSeats" value="${seatId}" class="seat-checkbox">
				                        
				                        <label for="seat-${seatId}" class="seat available">${i}</label>
				                    </c:otherwise>
				                </c:choose>
				            </c:forEach>
				        </div>
				    </c:forEach>
				</div>
    
    			<!-- Screen & labels -->
                <div class="flex flex-col items-center">
                     <img src="https://cdn.district.in/movies-web/_next/static/media/screen-img-light.b7b18ffd.png" alt="Screen" class="w-full max-w-sm">
                    <p class="text-gray-400 text-xs font-semibold tracking-widest mt-1">SCREEN THIS WAY</p>
                    <div class="flex justify-center items-center space-x-4 sm:space-x-6 mt-6">
                        <div class="flex items-center space-x-2"><div class="w-4 h-4 rounded border border-slate-300"></div><span class="text-xs text-gray-600">Available</span></div>
                        <div class="flex items-center space-x-2"><div class="w-4 h-4 rounded bg-gray-200"></div><span class="text-xs text-gray-600">Occupied</span></div>
                        <div class="flex items-center space-x-2"><div class="w-4 h-4 rounded bg-red-500"></div><span class="text-xs text-gray-600">Selected</span></div>
                    </div>
                </div>
                
            </div>
            
            <!-- Proceed button -->
            <div id="proceed-bar" class="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 p-4 transform translate-y-full transition-transform duration-300 ease-in-out shadow-[0_-4px_10px_rgba(0,0,0,0.05)]">
                <div class="container mx-auto flex items-center justify-center w-full max-w-md">
                    <button id="proceed-button" type="submit" form="booking-form" class="w-full bg-red-500 hover:bg-red-600 text-white font-bold py-3 px-10 rounded-lg transition-colors"></button>
                </div>
            </div>
        </form>
    </main>
    
    <script>
    document.addEventListener('DOMContentLoaded', function() {
    	
    	
    	// -- Getting elements id's ---
        const seatingChart = document.getElementById('seating-chart');
        const proceedBar = document.getElementById('proceed-bar');
        const proceedButton = document.getElementById('proceed-button');
        const TICKET_PRICE = ${showtime.ticketPrice};
        const flashError = document.getElementById('flash-error-message');
        let errorTimeout; // This will hold our timer

        seatingChart.addEventListener('change', function(event) {
            
            const selectedCount = document.querySelectorAll('.seat-checkbox:checked').length;
            if (selectedCount > 10) {
                event.target.checked = false; 

                // --- Call our function to show the flash message ---
                showFlashError("You can select a maximum of 10 seats.");

                return; 
            }

            updateSummary();
        });
        
        // --- Function to show and then hide the error message ---
        function showFlashError(message) {
            flashError.textContent = message;
            flashError.classList.remove('hidden'); // Make it visible
            
            // Clear any existing timer
            clearTimeout(errorTimeout);

            // Set a timer to hide the message after 3 seconds (3000ms)
            errorTimeout = setTimeout(() => {
                flashError.classList.add('hidden');
            }, 3000);
        }

        // --- Updating Proceed button data based on no. of seats selected ---
        function updateSummary() {
            const selectedCount = document.querySelectorAll('.seat-checkbox:checked').length;

            if (selectedCount > 0) {
                proceedButton.textContent = 'Proceed (' + selectedCount + (selectedCount === 1 ? ' Seat)' : ' Seats)');
                proceedBar.classList.remove('translate-y-full');
            } else {
                proceedBar.classList.add('translate-y-full');
            }
        }
    });
</script>

</body>
</html>