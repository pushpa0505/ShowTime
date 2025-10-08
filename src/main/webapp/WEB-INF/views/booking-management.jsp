<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Bookings Management</title> 
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700&family=Righteous&display=swap" rel="stylesheet">
    <style> 
        body { font-family: 'Figtree', sans-serif; background-color: #f1f5f9; } 
        .logo-font { font-family: 'Righteous', cursive; }
        .sidebar-link { transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out; }
        .sidebar-link.active { background-color: #ef4444; color: white; }
        .sidebar-link:not(.active):hover { background-color: #f87171; color: white; }
        #sidebar { transition: transform 0.3s ease-in-out; }
    </style>
</head>
<body class="text-gray-900">
    <div class="relative h-screen md:flex">
    
        <div class="md:hidden flex justify-between items-center bg-gray-800 text-white p-4">
            <a href="#" class="flex items-center space-x-2">
                <span class="text-xl font-bold logo-font">BOOKINGS</span>
            </a>
            <button id="mobile-menu-button" class="focus:outline-none">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16m-7 6h7"></path></svg>
            </button>
        </div>

        <aside id="sidebar" class="w-64 bg-gray-800 text-white flex-col fixed inset-y-0 left-0 transform -translate-x-full md:translate-x-0 z-30 flex">
            <jsp:include page="sidebar.jsp" /> 
        </aside>

        <div class="flex-1 flex flex-col overflow-hidden md:ml-64">
            
            <header class="hidden md:flex justify-between items-center p-6 bg-white border-b">
                <h1 class="text-2xl font-bold text-gray-800">Bookings Management</h1>
                <div class="flex items-center space-x-4">
                    <span class="text-sm font-semibold">${sessionScope.adminUser.fullName}</span>
                </div>
            </header>

            <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-100 p-4 md:p-6">
      
                <div class="bg-white p-4 md:p-6 rounded-lg shadow-md">
                    <h3 class="text-xl font-bold mb-4 md:hidden">Booking List</h3>
                    <div class="overflow-x-auto">
                        <table class="w-full text-sm text-left text-gray-500">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                                <tr>
                                    <th scope="col" class="px-6 py-3">ID</th>
                                    <th scope="col" class="px-6 py-3 md:w-40">User/Date</th>
                                    <th scope="col" class="px-6 py-3">Movie</th>
                                    <th scope="col" class="px-6 py-3 hidden md:table-cell">Theater</th>
                                    <th scope="col" class="px-6 py-3 hidden md:table-cell">City</th>
                                    <th scope="col" class="px-6 py-3">Ticket</th>
                                    <th scope="col" class="px-6 py-3 hidden md:table-cell">Show Date</th>
                                    <th scope="col" class="px-6 py-3">Amount</th>
                                    <th scope="col" class="px-6 py-3">Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="vm" items="${bookings}">
                                    <tr class="bg-white border-b">
                                        <th scope="row" class="px-6 py-4 font-mono text-gray-900 whitespace-nowrap">
                                            SHOWTIME-${vm.booking.id}
                                        </th>
                                        
                                        <td class="px-6 py-4">
                                            <div class="font-semibold text-gray-900">${vm.booking.user.email}</div>
                                            <div class="text-xs text-gray-500">${vm.booking.bookingDate}</div>
                                        </td>
                                        
                                        <td class="px-6 py-4">${vm.booking.showtime.movie.title}</td>
                                        
                                        <td class="px-6 py-4 hidden md:table-cell">${vm.booking.showtime.theater.name}, ${vm.booking.showtime.theater.location}</td>
                                        
                                        <td class="px-6 py-4 hidden md:table-cell">${vm.booking.showtime.theater.city}</td>
                                        
                                        <td class="px-6 py-4">${vm.ticketCount}</td>
                                        
                                        <td class="px-6 py-4 hidden md:table-cell">${vm.formattedShowDate}</td>
                                        
                                        <td class="px-6 py-4">
                                            ₹<fmt:formatNumber value="${vm.booking.totalPrice}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                                        </td>
                                        
                                        <td class="px-6 py-4">
                                            <c:choose>
                                                <c:when test="${vm.booking.status == 'CONFIRMED'}">
                                                    <span class="bg-green-100 text-green-800 text-xs font-medium px-2.5 py-0.5 rounded-full">Confirmed</span>
                                                </c:when>
                                                <c:when test="${vm.booking.status == 'CANCELLED'}">
                                                    <span class="bg-red-100 text-red-800 text-xs font-medium px-2.5 py-0.5 rounded-full">Cancelled</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const button = document.getElementById('mobile-menu-button');
            const sidebar = document.getElementById('sidebar');

            if (button && sidebar) {
                button.addEventListener('click', () => {
                    sidebar.classList.toggle('-translate-x-full');
                });
            }
        });
    </script>
</body>
</html>