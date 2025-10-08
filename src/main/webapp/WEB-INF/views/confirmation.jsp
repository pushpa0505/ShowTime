<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmed - ShowTime</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700&family=Righteous&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Figtree', sans-serif; background-color: #f8f8f8; }
        .logo-font { font-family: 'Righteous', cursive; }
        .ticket-cutout { position: relative; }
        .ticket-cutout::before, .ticket-cutout::after { content: ''; position: absolute; width: 30px; height: 30px; background: #f8f8f8; border-radius: 50%; }
        .ticket-cutout::before { top: 50%; left: -15px; transform: translateY(-50%); }
        .ticket-cutout::after { top: 50%; right: -15px; transform: translateY(-50%); }
        .checkmark{width:64px;height:64px;border-radius:50%;display:block;stroke-width:2;stroke:#fff;stroke-miterlimit:10;margin:10% auto;box-shadow:inset 0 0 0 #4caf50;animation:fill-it .4s ease-in-out .4s forwards,scale .3s ease-in-out .9s both}.checkmark-circle{stroke-dasharray:166;stroke-dashoffset:166;stroke-width:2;stroke-miterlimit:10;stroke:#4caf50;fill:none;animation:stroke .6s cubic-bezier(.65,0,.45,1) forwards}.checkmark-check{transform-origin:50% 50%;stroke-dasharray:48;stroke-dashoffset:48;animation:stroke .3s cubic-bezier(.65,0,.45,1) .8s forwards}@keyframes stroke{100%{stroke-dashoffset:0}}@keyframes scale{0%,100%{transform:none}50%{transform:scale3d(1.1,1.1,1)}}@keyframes fill-it{100%{box-shadow:inset 0 0 0 32px #4caf50}}
    </style>
</head>
<body class="text-gray-900 flex flex-col min-h-screen">

    <jsp:include page="header.jsp" />

    <main class="container mx-auto px-4 sm:px-6 lg:px-8">
            <div class="max-w-md mx-auto">
            <div class="text-center mb-2">
                <svg class="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
                    <circle class="checkmark-circle" cx="26" cy="26" r="25" fill="none"/>
                    <path class="checkmark-check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
                </svg>
                <h2 class="text-2xl font-bold">Booking Confirmed!</h2>
                <p class="text-gray-500">Your ticket has been sent to your email.</p>
				<a href="${pageContext.request.contextPath}/booking-history"
				   class="inline-flex items-center text-gray-700 font-semibold underline hover:text-gray-900 transition-colors">
				   View Bookings
				   <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
				        stroke-width="2" stroke="currentColor"
				        class="w-4 h-4 ml-1 transform transition-transform duration-200 group-hover:translate-x-0.5">
				       <path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7" />
				   </svg>
				</a>
            </div>

            <div id="e-ticket" class="bg-white rounded-2xl shadow-lg overflow-hidden">
                <div class="p-4">
                    <div class="flex items-start space-x-4">
                        <img src="${booking.showtime.movie.posterUrl}" alt="Movie Poster" class="w-20 rounded-lg">
                        <div class="flex-1">
                            <h3 class="font-bold text-2xl">${booking.showtime.movie.title}</h3>
                            <p class="text-sm text-gray-500">${booking.showtime.theater.name}, ${booking.showtime.theater.location}</p>
                            <p class="text-sm text-gray-500">${booking.showtime.movie.certificate} • ${booking.showtime.language}</p>
                            <p class="text-sm text-gray-500">${viewModel.formattedDayOfWeek}, ${viewModel.formattedDayAndMonth}, ${viewModel.formattedStartTime}</p>
                            <div class="mt-4 space-y-1">
                                <div>
                                    <p class="text-xs font-bold text-gray-400">SEATS</p>
                                    <c:set var="seatCount" value="${fn:length(fn:split(booking.bookedSeats, ','))}" />
                                    <p class="font-semibold">${booking.bookedSeats} (${seatCount} ${seatCount > 1 ? 'Tickets' : 'Ticket'})</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="relative ticket-cutout">
                    <div class="border-t-2 border-dashed border-gray-300"></div>
                </div>
                
                <div class="p-4 flex flex-col items-center">
                    <img src="https://api.qrserver.com/v1/create-qr-code/?color=000000&amp;bgcolor=FFFFFF&amp;data=BOOKING-ID:${bookingId}&amp;qzone=1&amp;margin=0&amp;size=400x400&amp;ecc=L" alt="QR Code" class="w-48 h-48 rounded-lg">
                    <p class="mt-4 text-sm font-semibold">Booking ID: <span class="font-mono text-red-500">SHOWTIME-${booking.id}</span></p>
                    <p class="mt-4 text-sm font-semibold">Payment ID: <span class="font-mono text-red-500">${booking.paymentId}</span></p>
                    <p class="mt-1 text-xs text-gray-500 text-center">Show this QR code at the cinema entrance.</p>
                </div>
            </div>

            <div class="mt-2 flex flex-col items-center space-y-16">
                <button id="download-button" class="w-full max-w-xs bg-gray-800 hover:bg-gray-900 text-white font-bold py-3 px-6 rounded-lg transition-colors">
                    Download Ticket
                </button>
            </div>
        </div>
    </main>
    
    <script>
	    document.addEventListener('DOMContentLoaded', function() {
	        const downloadButton = document.getElementById('download-button');
	        const ticketElement = document.getElementById('e-ticket');
	
	        if (downloadButton) {
	            downloadButton.addEventListener('click', function() {
	                // Use html2canvas with the useCORS option
	                html2canvas(ticketElement, { useCORS: true }).then(canvas => {
	                    const link = document.createElement('a');
	                    link.href = canvas.toDataURL('image/png');
	                    link.download = 'ShowTime-Ticket-${booking.id}.png';
	                    link.click();
	                });
	            });
	        }
	    });
	</script>
</body>
</html>