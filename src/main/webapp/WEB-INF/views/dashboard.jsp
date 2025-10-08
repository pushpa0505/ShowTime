<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - ShowTime</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700&family=Righteous&display=swap" rel="stylesheet">
    <style> 
        body { font-family: 'Figtree', sans-serif; background-color: #f1f5f9; } 
        .logo-font { font-family: 'Righteous', cursive; }
        .sidebar-link {
            transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
        }
        .sidebar-link.active {
            background-color: #ef4444;
            color: white;
        }
        .sidebar-link:not(.active):hover {
            background-color: #f87171;
            color: white;
        }
        #sidebar {
            transition: transform 0.3s ease-in-out;
        }
    </style>
</head>
<body class="text-gray-900">

    <div class="relative h-screen md:flex">
        <!-- Mobile menu button -->
        <div class="md:hidden flex justify-between items-center bg-gray-800 text-white p-4">
            <a href="#" class="flex items-center space-x-2">
                <span class="text-xl font-bold logo-font">DASHBOARD</span>
            </a>
            <button id="mobile-menu-button" class="focus:outline-none">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16m-7 6h7"></path></svg>
            </button>
        </div>

        <!-- Sidebar -->
        <aside id="sidebar" class="w-64 bg-gray-800 text-white flex-col fixed inset-y-0 left-0 transform -translate-x-full md:translate-x-0 z-30 flex">
            <jsp:include page="sidebar.jsp" />
        </aside>

        <!-- Main content -->
        <div class="flex-1 flex flex-col overflow-hidden md:ml-64">
            <header class="hidden md:flex justify-between items-center p-6 bg-white border-b">
                <h1 class="text-2xl font-bold text-gray-800">Dashboard</h1>
                <div class="flex items-center space-x-4"><span class="text-sm font-semibold">${sessionScope.adminUser.fullName}</span></div>
            </header>

            <!-- Content -->
            <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-100 p-6">
                <!-- Stat Cards -->
				<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
				    <div class="bg-white p-6 rounded-lg shadow-md">
				        <h3 class="text-sm font-medium text-gray-500">Today's Revenue</h3>
				        <p class="text-3xl font-bold text-gray-800 mt-2">
				            ₹<fmt:formatNumber value="${todaysRevenue}" type="number" minFractionDigits="0" maxFractionDigits="0"/>
				        </p>
				    </div>
				    <div class="bg-white p-6 rounded-lg shadow-md">
				        <h3 class="text-sm font-medium text-gray-500">Today's Bookings</h3>
				        <p class="text-3xl font-bold text-gray-800 mt-2">${todaysBookingsCount}</p>
				    </div>
				    <div class="bg-white p-6 rounded-lg shadow-md">
				        <h3 class="text-sm font-medium text-gray-500">Total Revenue</h3>
				        <p class="text-3xl font-bold text-gray-800 mt-2">
				            ₹<fmt:formatNumber value="${totalRevenue}" type="number" minFractionDigits="0" maxFractionDigits="0"/>
				        </p>
				    </div>
				    <div class="bg-white p-6 rounded-lg shadow-md">
				        <h3 class="text-sm font-medium text-gray-500">Total Bookings</h3>
				        <p class="text-3xl font-bold text-gray-800 mt-2">${totalBookingsCount}</p>
				    </div>
				</div>

                <!-- Today's Bookings Table -->
                <div class="bg-white p-6 rounded-lg shadow-md">
                    <h3 class="text-xl font-bold mb-4">Recent Bookings</h3>
                    <div class="overflow-x-auto">
                        <table class="w-full text-sm text-left text-gray-500">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                                <tr>
                                    <th scope="col" class="px-6 py-3">Booking ID</th>
                                    <th scope="col" class="px-6 py-3">User</th>
                                    <th scope="col" class="px-6 py-3">Movie</th>
                                    <th scope="col" class="px-6 py-3">Amount</th>
                                    <th scope="col" class="px-6 py-3">Status</th>
                                </tr>
                            </thead>
                            <tbody>
				                <c:choose>
				                    <c:when test="${not empty recentBookings}">
				                        <c:forEach var="booking" items="${recentBookings}">
				                            <tr class="bg-white border-b">
				                                <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">SHOWTIME-${booking.id}</th>
				                                <td class="px-6 py-4">${booking.user.fullName}</td>
				                                <td class="px-6 py-4">${booking.showtime.movie.title}</td>
				                                <td class="px-6 py-4">₹<fmt:formatNumber value="${booking.totalPrice}" type="number" minFractionDigits="2" maxFractionDigits="2"/></td>
				                                <td class="px-6 py-4">
				                                    <c:choose>
				                                        <c:when test="${booking.status == 'CONFIRMED'}">
				                                            <span class="bg-green-100 text-green-800 text-xs font-medium mr-2 px-2.5 py-0.5 rounded-full">Confirmed</span>
				                                        </c:when>
				                                        <c:when test="${booking.status == 'CANCELLED'}">
				                                            <span class="bg-red-100 text-red-800 text-xs font-medium mr-2 px-2.5 py-0.5 rounded-full">Cancelled</span>
				                                        </c:when>
				                                        <c:otherwise>
				                                            <span class="bg-yellow-100 text-yellow-800 text-xs font-medium mr-2 px-2.5 py-0.5 rounded-full">Pending</span>
				                                        </c:otherwise>
				                                    </c:choose>
				                                </td>
				                            </tr>
				                        </c:forEach>
				                    </c:when>
				                    <c:otherwise>
				                        <tr>
				                            <td colspan="5" class="px-6 py-4 text-center text-gray-500">No recent bookings found.</td>
				                        </tr>
				                    </c:otherwise>
				                </c:choose>
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

            button.addEventListener('click', () => {
                sidebar.classList.toggle('-translate-x-full');
            });
        });
    </script>
</body>
</html>
