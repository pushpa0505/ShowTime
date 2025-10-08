<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Showtime Management</title>
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
        <!-- Mobile menu button -->
        <div class="md:hidden flex justify-between items-center bg-gray-800 text-white p-4">
            <a href="#" class="flex items-center space-x-2">
                <span class="text-xl font-bold logo-font">SHOWTIME MANAGEMENT</span>
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
                <h1 class="text-2xl font-bold text-gray-800">Showtime Management</h1>
                <div class="flex items-center space-x-4"><span class="text-sm font-semibold">${sessionScope.adminUser.fullName}</span></div>
            </header>

            <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-100 p-6">
                <%-- Flash Messages --%>
                <c:if test="${not empty errorMessage}">
                    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">${errorMessage}</div>
                </c:if>
                <c:if test="${not empty successMessage}">
                    <div id="success-alert" class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4">${successMessage}</div>
                </c:if>
                
                <form action="${pageContext.request.contextPath}/admin/showtimes" method="get" class="flex flex-col sm:flex-row items-center justify-between mb-6 gap-4">
                    <div class="flex flex-col sm:flex-row items-center gap-4 w-full sm:w-auto">
                        <select name="theaterId" required class="w-full sm:w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none">
                            <option value="">Select a Theater</option>
                            <c:forEach var="theater" items="${theaters}">
                                <option value="${theater.id}" ${theater.id == selectedTheaterId ? 'selected' : ''}>${theater.name} - ${theater.location}, ${theater.city}</option>
                            </c:forEach>
                        </select>
                        <input name="date" type="date" value="${selectedDate}" required class="w-full sm:w-auto px-4 py-2 border border-gray-300 rounded-lg focus:outline-none">
                        <div class="flex gap-2 w-full sm:w-auto">
    						<button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded-lg flex-1 sm:flex-none">Apply</button>
    						<a href="${pageContext.request.contextPath}/admin/showtimes" class="bg-gray-500 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded-lg flex-1 sm:flex-none text-center">Clear</a>
						</div>

                    </div>
                    <button id="add-showtime-button" type="button" class="bg-red-500 hover:bg-red-600 text-white font-bold py-2 px-4 rounded-lg flex items-center w-full sm:w-auto justify-center">Add Showtime</button>
                </form>

                 <div class="grid grid-cols-2 sm:grid-cols-4 md:grid-cols-6 lg:grid-cols-7 xl:grid-cols-8 gap-6">
                    <c:if test="${empty selectedTheaterId}">
                        <p class="text-center text-gray-500 py-8 col-span-full">Select theater & date to see the showtimes.</p>
                    </c:if>
                    <c:if test="${not empty selectedTheaterId}">
                        <c:if test="${empty showtimes}"><p class="text-center text-gray-500 py-8 col-span-full">No showtimes found for this theater and date.</p></c:if>
                        <c:forEach var="showtime" items="${showtimes}">
                             <div class="showtime-card bg-white rounded-lg shadow-md overflow-hidden flex flex-col">
                                <img src="${showtime.movie.posterUrl}" alt="${showtime.movie.title}" class="w-full h-auto object-cover aspect-[2/3]">
                                <div class="p-3 flex flex-col flex-grow">
                                    <h4 class="font-bold text-base truncate">${showtime.movie.title}</h4>
                                    <span class="bg-green-200 text-gray-800 text-sm font-medium my-2 px-2.5 py-0.5 rounded-full self-start">${showtime.startTime} &bull; ${showtime.language}</span>
                                    <p class="text-gray-800 font-bold text-sm mt-1">₹${showtime.ticketPrice}</p>
                                    <div class="flex justify-end mt-auto pt-2">
                                        <form action="${pageContext.request.contextPath}/admin/showtimes/delete/${showtime.id}" method="post" onsubmit="return confirm('Are you sure?');">
                                            <button type="submit" class="font-medium text-red-600 hover:underline text-sm">Delete</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
            </main>
        </div>
    </div>

    <div id="showtime-modal" class="fixed inset-0 bg-gray-900 bg-opacity-50 flex items-center justify-center p-4 hidden">
        <div class="bg-white rounded-lg shadow-xl w-full max-w-md transform transition-all">
            <div class="flex justify-between items-center p-4 border-b">
                <h3 id="modal-title" class="text-xl font-bold">Add Showtime</h3>
                <button id="close-modal-button" class="text-gray-400 hover:text-gray-600"><svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg></button>
            </div>
            <form id="showtime-form" action="${pageContext.request.contextPath}/admin/showtimes/add" method="post" class="p-6 space-y-4">
                <div>
                    <label for="showtime-movie" class="block text-sm font-medium text-gray-700">Movie</label>
                    <select name="movieId" id="showtime-movie" required class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm rounded-md">
                        <option value="">Select a movie</option>
                        <c:forEach var="movie" items="${movies}"><option value="${movie.id}">${movie.title}</option></c:forEach>
                    </select>
                </div>
                <div>
                    <label for="showtime-theater" class="block text-sm font-medium text-gray-700">Theater</label>
                    <select name="theaterId" id="showtime-theater" required class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm rounded-md">
                        <option value="">Select a theater</option>
                        <c:forEach var="theater" items="${theaters}"><option value="${theater.id}">${theater.name} - ${theater.location}, ${theater.city}</option></c:forEach>
                    </select>
                </div>
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <div>
                        <label for="showtime-language" class="block text-sm font-medium text-gray-700">Language</label>
                        <input type="text" name="language" id="showtime-language" required placeholder="e.g., Hindi" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm">
                    </div>
                </div>
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <div>
                        <label for="showtime-date" class="block text-sm font-medium text-gray-700">Date</label>
                        <input type="date" name="showDate" id="showtime-date" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm">
                    </div>
                    <div>
                        <label for="showtime-time" class="block text-sm font-medium text-gray-700">Show Time</label>
                        <input type="time" name="startTime" id="showtime-time" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm">
                    </div>
                </div>
                <div>
                    <label for="showtime-price" class="block text-sm font-medium text-gray-700">Ticket Price (₹)</label>
                    <input type="number" name="ticketPrice" id="showtime-price" required placeholder="e.g., 250" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm">
                </div>
                <div class="px-6 py-4 bg-gray-50 text-right space-x-2 -m-6 mt-4">
                    <button id="cancel-modal-button" type="button" class="inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50">Cancel</button>
                    <button type="submit" class="inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-red-600 text-base font-medium text-white hover:bg-red-700">Save Showtime</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Mobile sidebar toggle
            const mobileMenuButton = document.getElementById('mobile-menu-button');
            const sidebar = document.getElementById('sidebar');
            if(mobileMenuButton) {
                mobileMenuButton.addEventListener('click', () => {
                    sidebar.classList.toggle('-translate-x-full');
                });
            }

            // Screen accordion toggle
            const screenToggles = document.querySelectorAll('.screen-toggle');
            screenToggles.forEach(toggle => {
                toggle.addEventListener('click', () => {
                    const content = toggle.nextElementSibling;
                    const icon = toggle.querySelector('svg');
                    content.classList.toggle('hidden');
                    icon.classList.toggle('rotate-180');
                });
            });

            // Modal functionality
            const addShowtimeButton = document.getElementById('add-showtime-button');
            const showtimeModal = document.getElementById('showtime-modal');
            const closeModalButton = document.getElementById('close-modal-button');
            const cancelModalButton = document.getElementById('cancel-modal-button');
            const showtimeForm = document.getElementById('showtime-form');

            const openModal = () => showtimeModal.classList.remove('hidden');
            const closeModal = () => showtimeModal.classList.add('hidden');

            if (addShowtimeButton) {
                addShowtimeButton.addEventListener('click', () => {
                    showtimeForm.reset();
                    openModal();
                });
            }
            if (closeModalButton) closeModalButton.addEventListener('click', closeModal);
            if (cancelModalButton) cancelModalButton.addEventListener('click', closeModal);
            showtimeModal.addEventListener('click', function(event) {
                if (event.target === showtimeModal) {
                    closeModal();
                }
            });
             // Auto-dismiss success alert
            const successAlert = document.getElementById('success-alert');
            if (successAlert) {
                setTimeout(() => { 
                    successAlert.classList.add('opacity-0', '-translate-y-4');
                    setTimeout(() => { successAlert.style.display = 'none'; }, 500);
                }, 3000);
            }
        });
    </script>
</body>
</html>