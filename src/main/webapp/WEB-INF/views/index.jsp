<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShowTime - Movie Booking</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700&family=Righteous&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Figtree', sans-serif;
            background-color: #f8f8f8;
        }
        .custom-scrollbar::-webkit-scrollbar { display: none; }
        .custom-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
        .hero-bg-blurry {
            background-image: radial-gradient(circle, #f87171, #ef4444, #dc2626);
            background-size: cover;
            background-position: center;
        }
        .logo-font {
            font-family: 'Righteous', cursive;
        }
    </style>
</head>
<body class="text-gray-900 flex flex-col min-h-screen">

    <!-- Header -->
    <jsp:include page="header.jsp" />

    <!-- Main Content -->
    <main class="container mx-auto px-4 sm:px-6 lg:px-8 py-6 flex-grow">
    	<c:if test="${not empty successMessage}">
	        <div id="success-alert" class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4 transition-all duration-500 ease-in-out" role="alert">
	            <span class="block sm:inline">${successMessage}</span>
	        </div>
	    </c:if>
	    <c:if test="${not empty errorMessage}">
			<div id="error-alert" class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4 transition-all duration-500 ease-in-out" role="alert">
	            <span class="block sm:inline">${errorMessage}</span>
	        </div>
	    </c:if>
    	
    	<!-- search bar -->
        <section class="mb-8">
	        <form action="${pageContext.request.contextPath}/search" method="get">
	            <div class="relative">
	                <span class="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400">
	                    <svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-5.197-5.197m0 0A7.5 7.5 0 105.196 5.196a7.5 7.5 0 0010.607 10.607z" /></svg>
	                </span>
	                <input type="text" name="query" placeholder="Search for movies..." class="bg-white border border-gray-200 text-gray-800 placeholder-gray-500 rounded-xl py-3 pl-12 pr-4 w-full focus:outline-none focus:ring-2 focus:ring-red-500">
	            </div>
		    </form>
        </section>

		<!-- hero section -->
        <c:if test="${not empty latestMovie}">
		    <section class="mb-8">
		        <div class="relative hero-bg-blurry rounded-2xl overflow-hidden">
		            <div class="absolute inset-0 bg-black/20"></div>
		            <div class="relative z-10 p-6 md:p-10">
		                <div class="flex flex-col md:flex-row items-center md:space-x-8">
		                    <div class="flex-1 text-center md:text-left order-2 md:order-1 mt-6 md:mt-0">
		                        <h1 class="text-4xl md:text-5xl font-bold text-white">${latestMovie.title}</h1>
		                        <p class="text-gray-200 mt-2 text-lg">${latestMovie.certificate} • ${latestMovie.languages} • ${latestMovie.duration} • ${latestMovie.genre}</p>
		                        <div class="mt-6">
		                            <a href="${pageContext.request.contextPath}/movie/${latestMovie.id}" class="inline-block text-center bg-white hover:bg-gray-200 text-gray-800 font-bold py-3 px-10 rounded-lg transition-colors text-lg">Book Now</a>
		                        </div>
		                    </div>
		                    <div class="flex-shrink-0 order-1 md:order-2">
		                        <img src="${latestMovie.posterUrl}" alt="Movie Poster" class="rounded-xl shadow-2xl w-60 md:w-72">
		                    </div>
		                </div>
		            </div>
		        </div>
		    </section>
		</c:if>

		<!-- now showing movies -->
        <section class="mb-8">
            <h2 class="text-xl font-bold mb-4">Now Showing</h2>
            <c:choose>
		        <c:when test="${not empty nowShowingMovies}">
		            <div class="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-6 gap-6">
		                <c:forEach var="movie" items="${nowShowingMovies}">
		                    <a href="${pageContext.request.contextPath}/movie/${movie.id}">
		                        <div class="bg-white rounded-lg shadow-sm cursor-pointer transition-shadow hover:shadow-xl">
		                            <img src="${movie.posterUrl}" alt="${movie.title}" class="w-full h-auto rounded-t-lg aspect-[2/3] object-cover">
		                            <div class="p-3">
		                                <h3 class="font-bold text-md truncate">${movie.title}</h3>
		                                <p class="text-gray-600 text-sm truncate">${movie.certificate} &bull; ${movie.languages}</p>
		                            </div>
		                        </div>
		                    </a>
		                </c:forEach>
		            </div>
		        </c:when>
		        <c:otherwise>
		            <div class="flex justify-center items-center h-48 bg-gray-100 rounded-lg">
		                <p class="text-gray-500 italic text-lg">No shows available.</p>
		            </div>
		        </c:otherwise>
		    </c:choose>
        </section>

		<!-- upcoming movies -->
        <section class="mb-8">
            <div class="flex justify-between items-center mb-4">
                <h2 class="text-xl font-bold">Upcoming Movies</h2>
                <!-- <a href="#" class="text-red-500 font-semibold text-sm hover:underline">View All</a> -->
            </div>
            <div class="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-6 gap-6">
    			<c:forEach var="movie" items="${upcomingMovies}">
        			<a href="${pageContext.request.contextPath}/movie/${movie.id}"> <%-- We will make this link dynamic later --%>
            		<div class="bg-white rounded-lg shadow-sm cursor-pointer transition-shadow hover:shadow-xl">
                		<img src="${movie.posterUrl}" alt="${movie.title}" class="w-full h-auto rounded-t-lg aspect-[2/3] object-cover">
                		<div class="p-3">
                    		<h3 class="font-bold text-md truncate">${movie.title}</h3>
                    		<p class="text-gray-600 text-sm truncate">${movie.certificate} &bull; ${movie.languages}</p>
                		</div>
            		</div>
        			</a>
    			</c:forEach>
			</div>
        </section>
    </main>
    
    <footer class="bg-white border-t border-gray-200 mt-auto">
        <div class="container mx-auto px-4 sm:px-6 lg:px-8 py-8">
            <div class="grid grid-cols-2 md:grid-cols-4 gap-8 text-sm">
                <div>
                    <h4 class="font-bold mb-4">Support</h4>
                    <ul class="space-y-2 text-gray-600">
                        <li><a href="#" class="hover:text-red-500">Contact Us</a></li>
                        <li><a href="#" class="hover:text-red-500">FAQs</a></li>
                        <li><a href="#" class="hover:text-red-500">Terms of Service</a></li>
                        <li><a href="#" class="hover:text-red-500">Privacy Policy</a></li>
                    </ul>
                </div>
                <div>
                    <h4 class="font-bold mb-4">ShowTime</h4>
                    <ul class="space-y-2 text-gray-600">
                        <li><a href="#" class="hover:text-red-500">About Us</a></li>
                        <li><a href="#" class="hover:text-red-500">Careers</a></li>
                        <li><a href="#" class="hover:text-red-500">Press</a></li>
                    </ul>
                </div>
                <div class="col-span-2 md:col-span-2">
                    <h4 class="font-bold mb-4">Follow Us</h4>
                    <div class="flex space-x-4">
                        <a href="#" class="text-gray-500 hover:text-red-500"><svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true"><path fill-rule="evenodd" d="M22 12c0-5.523-4.477-10-10-10S2 6.477 2 12c0 4.991 3.657 9.128 8.438 9.878v-6.987h-2.54V12h2.54V9.797c0-2.506 1.492-3.89 3.777-3.89 1.094 0 2.238.195 2.238.195v2.46h-1.26c-1.243 0-1.63.771-1.63 1.562V12h2.773l-.443 2.89h-2.33v6.988C18.343 21.128 22 16.991 22 12z" clip-rule="evenodd"></path></svg></a>
                        <a href="#" class="text-gray-500 hover:text-red-500"><svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true"><path d="M8.29 20.251c7.547 0 11.675-6.253 11.675-11.675 0-.178 0-.355-.012-.53A8.348 8.348 0 0022 5.92a8.19 8.19 0 01-2.357.646 4.118 4.118 0 001.804-2.27 8.224 8.224 0 01-2.605.996 4.107 4.107 0 00-6.993 3.743 11.65 11.65 0 01-8.457-4.287 4.106 4.106 0 001.27 5.477A4.072 4.072 0 012.8 9.71v.052a4.105 4.105 0 003.292 4.022 4.095 4.095 0 01-1.853.07 4.108 4.108 0 003.834 2.85A8.233 8.233 0 012 18.407a11.616 11.616 0 006.29 1.84"></path></svg></a>
                        <a href="#" class="text-gray-500 hover:text-red-500"><svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true"><path fill-rule="evenodd" d="M12.315 2c2.43 0 2.784.013 3.808.06 1.064.049 1.791.218 2.427.465a4.902 4.902 0 011.772 1.153 4.902 4.902 0 011.153 1.772c.247.636.416 1.363.465 2.427.048 1.024.06 1.378.06 3.808s-.012 2.784-.06 3.808c-.049 1.064-.218 1.791-.465 2.427a4.902 4.902 0 01-1.153 1.772 4.902 4.902 0 01-1.772 1.153c-.636.247-1.363.416-2.427.465-1.024.048-1.378.06-3.808.06s-2.784-.012-3.808-.06c-1.064-.049-1.791-.218-2.427-.465a4.902 4.902 0 01-1.772-1.153 4.902 4.902 0 01-1.153-1.772c-.247-.636-.416-1.363-.465-2.427-.048-1.024-.06-1.378-.06-3.808s.012-2.784.06-3.808c.049-1.064.218-1.791.465-2.427a4.902 4.902 0 011.153-1.772A4.902 4.902 0 016.345 2.525c.636-.247 1.363-.416 2.427.465C9.793 2.013 10.147 2 12.315 2zM12 8.118c-2.136 0-3.863 1.727-3.863 3.863s1.727 3.863 3.863 3.863 3.863-1.727 3.863-3.863S14.136 8.118 12 8.118zM12 14.354c-1.306 0-2.363-1.057-2.363-2.363s1.057-2.363 2.363-2.363 2.363 1.057 2.363 2.363-1.057 2.363-2.363 2.363zM16.838 6.838a1.25 1.25 0 100 2.5 1.25 1.25 0 000-2.5z" clip-rule="evenodd"></path></svg></a>
                    </div>
                </div>
            </div>
            <div class="mt-8 border-t border-gray-200 pt-6 text-center"><p class="text-sm text-gray-500">&copy; 2024 ShowTime. All Rights Reserved.</p></div>
        </div>
    </footer>

    <!-- Location Modal -->
    <div id="location-modal" class="fixed inset-0 bg-gray-900 bg-opacity-75 flex items-center justify-center p-4 z-50 hidden">
        <div class="bg-white rounded-2xl shadow-xl w-full max-w-2xl transform transition-all">
            <div class="p-6">
                <div class="flex justify-between items-center mb-6">
                    <h3 class="text-xl font-bold">Select a City</h3>
                    <button id="close-modal-button" class="text-gray-400 hover:text-gray-600">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>
                    </button>
                </div>
                <div class="grid grid-cols-3 sm:grid-cols-5 gap-4">
                    <form action="${pageContext.request.contextPath}/select-city" method="post">
    					<input type="hidden" name="city" value="Mumbai">
    					<button type="submit" class="city-button flex flex-col items-center p-3 bg-violet-50 rounded-lg border-2 border-transparent hover:border-violet-500 transition-colors w-full">
        					<img src="https://b.zmtcdn.com/data/edition_assets/17436021106764.png" alt="Mumbai" class="h-20 w-20 object-contain">
    					</button>
					</form>

					<form action="${pageContext.request.contextPath}/select-city" method="post">
					    <input type="hidden" name="city" value="Delhi">
					    <button type="submit" class="city-button flex flex-col items-center p-3 bg-violet-50 rounded-lg border-2 border-transparent hover:border-violet-500 transition-colors w-full">
					        <img src="https://b.zmtcdn.com/data/edition_assets/174358689776715.png" alt="Delhi" class="h-20 w-20 object-contain">
					    </button>
					</form>
					<form action="${pageContext.request.contextPath}/select-city" method="post">
					    <input type="hidden" name="city" value="Kolkata">
					    <button class="city-button flex flex-col items-center p-3 bg-violet-50 rounded-lg border-2 border-transparent hover:border-violet-500 transition-colors" data-city="Kolkata">
                        	<img src="https://b.zmtcdn.com/data/edition_assets/174360421506910.png" alt="Kolkata" class="h-20 w-20 object-contain">
                    	</button>
					</form>
					<form action="${pageContext.request.contextPath}/select-city" method="post">
					    <input type="hidden" name="city" value="Ahmedabad">
					    <button class="city-button flex flex-col items-center p-3 bg-violet-50 rounded-lg border-2 border-transparent hover:border-violet-500 transition-colors" data-city="Ahmedabad">
                        	<img src="https://b.zmtcdn.com/data/edition_assets/174358689776514.png" alt="Ahmedabad" class="h-20 w-20 object-contain">
                    	</button>
					</form>
					<form action="${pageContext.request.contextPath}/select-city" method="post">
					    <input type="hidden" name="city" value="Chennai">
					    <button class="city-button flex flex-col items-center p-3 bg-violet-50 rounded-lg border-2 border-transparent hover:border-violet-500 transition-colors" data-city="Chennai">
                        	<img src="https://b.zmtcdn.com/data/edition_assets/17436033389708.png" alt="Chennai" class="h-20 w-20 object-contain">
                    	</button>
					</form>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const locationButton = document.getElementById('location-button');
            const locationModal = document.getElementById('location-modal');
            const closeModalButton = document.getElementById('close-modal-button');
            const cityButtons = document.querySelectorAll('.city-button');
            const currentCity = document.getElementById('current-city');

            const openModal = () => locationModal.classList.remove('hidden');

            const showModal = ${showCityModal ? 'true' : 'false'};
            if (showModal) {
                openModal();
            }
            const closeModal = () => locationModal.classList.add('hidden');

            locationButton.addEventListener('click', openModal);
            closeModalButton.addEventListener('click', closeModal);
            
            locationModal.addEventListener('click', function(event) {
                if (event.target === locationModal) {
                    closeModal();
                }
            });
        });
    </script>
    
    <script>
    // login success message timeout
    const successAlert = document.getElementById('success-alert');
    const errorAlert = document.getElementById('error-alert');
    if (successAlert) {
        setTimeout(() => {
            successAlert.style.opacity = '0';
            setTimeout(() => { successAlert.style.display = 'none'; }, 500);
        }, 3000);
    }
    if (errorAlert) {
        setTimeout(() => {
            errorAlert.style.opacity = '0';
            setTimeout(() => { errorAlert.style.display = 'none'; }, 500);
        }, 3000);
    }
    </script>

</body>
</html>


