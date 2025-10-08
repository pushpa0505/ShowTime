<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${movie.title} - Movie Details</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700&family=Righteous&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Figtree', sans-serif; background-color: #f8f8f8; }
        .hero-bg { 
            background-image: radial-gradient(circle, #f87171, #ef4444, #dc2626); 
            background-size: cover; 
            background-position: center; 
        }
        .custom-scrollbar::-webkit-scrollbar { display: none; }
        .custom-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
        .logo-font { font-family: 'Righteous', cursive; }
    </style>
</head>
<body class="text-gray-900 flex flex-col min-h-screen">

    <!-- Header -->
    <jsp:include page="header.jsp" />

    <main class="flex-grow">
        <section class="hero-bg"> 
            <div class="bg-black/20">
                <div class="container mx-auto px-4 sm:px-6 lg:px-8 py-4">
                	<div class="mb-4"> 
			            <a href="${pageContext.request.contextPath}/" class="text-white hover:text-gray-200 inline-flex items-center">
			                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
			                    <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" />
			                </svg>
			                <span class="ml-2 font-semibold">Home</span>
			            </a>
			        </div>
                    <div class="flex flex-col md:flex-row items-center md:space-x-8">
                        <div class="flex-shrink-0 w-60 md:w-72"><img src="${movie.posterUrl}" alt="${movie.title} Poster" class="rounded-xl shadow-2xl"></div>
                        <div class="flex-1 text-center md:text-left mt-6 md:mt-0 text-white">
                            <h1 class="text-4xl md:text-5xl font-bold text-white">${movie.title}</h1>
                            <div class="flex items-center justify-center md:justify-start space-x-4 mt-4 text-gray-200">
                            	<span>${movie.certificate}</span>
                            	<span> &bull; </span>
                            	<span>${movie.languages}</span>
                            	<span>&bull;</span>
                            	<span>${movie.genre}</span>
                            </div>
                            <p class="mt-2 text-gray-200">
                        		Release Date : <fmt:formatDate value="${movie.releaseDate}" pattern="dd MMM, yyyy" />
                    		</p>
                            
                            <div class="mt-6 flex flex-col md:flex-row items-center justify-center md:justify-start space-y-4 md:space-y-0 md:space-x-4">
                        		<%-- DYNAMIC "BOOK TICKETS" LINK --%>
                        		<button id="book-tickets-button" class="w-full md:w-auto inline-block text-center bg-white hover:bg-gray-200 text-gray-800 font-bold py-3 px-10 rounded-lg transition-colors text-lg">Book Tickets</button>
                        		
                        		<%-- DYNAMIC "WATCH TRAILER" BUTTON (only shows if a trailer link exists) --%>
                       			<c:if test="${not empty movie.trailerUrl}">
                            		<a href="${movie.trailerUrl}" target="_blank" class="w-full md:w-auto inline-flex items-center justify-center bg-transparent hover:bg-white/20 text-white font-bold py-3 px-10 rounded-lg transition-colors text-lg border-2 border-white">
                                	<svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                		Watch Trailer
                            		</a>
                        		</c:if>
                    		</div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="container mx-auto px-4 sm:px-6 lg:px-8 py-10">
            <div class="mb-10">
    			<h2 class="text-2xl font-bold mb-4">About the movie</h2>
    			<p class="text-gray-600 leading-relaxed">${movie.description}</p>
			</div>
			
			<%-- Add this section after the "About the movie" section --%>
			<div class="mb-10">
			    <h2 class="text-2xl font-bold mb-4">Cast</h2>
			    <div id="cast-list" class="flex flex-wrap gap-4">
			        <p class="text-gray-500">Loading cast...</p>
			    </div>
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
            <div class="mt-8 border-t border-gray-200 pt-6 text-center"><p class="text-sm text-gray-500">&copy; 2025 ShowTime. All Rights Reserved.</p></div>
        </div>
    </footer>
    
    <!-- Available Language Modal -->
    <div id="language-modal" class="fixed inset-0 bg-gray-900 bg-opacity-75 flex items-center justify-center p-4 z-50 hidden">
	    <div class="bg-white rounded-2xl shadow-xl w-full max-w-sm transform transition-all">
	        <div class="p-6">
	            <div class="flex justify-between items-center mb-6">
	                <h3 class="text-xl font-bold">Select Language</h3>
	                <button id="close-lang-modal-button" class="text-gray-400 hover:text-gray-600">
	                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>
	                </button>
	            </div>
	
	            <c:choose>
	                <c:when test="${not empty availableLanguages}">
	                    <div class="space-y-3">
	                        <c:forEach var="lang" items="${availableLanguages}">
	                            <a href="${pageContext.request.contextPath}/showtimes?movieId=${movie.id}&language=${lang}" class="block w-full text-center bg-gray-100 hover:bg-red-500 hover:text-white font-semibold p-3 rounded-lg transition-colors border-2 border-red-500">
	                                ${lang}
	                            </a>
	                        </c:forEach>
	                    </div>
	                </c:when>
	                <c:otherwise>
	                    <p class="text-center text-gray-600">No shows currently available for this movie in your selected city.</p>
	                </c:otherwise>
	            </c:choose>
	        </div>
	    </div>
	</div>

    <!-- Available Language Model script-->
    <script>
    document.addEventListener('DOMContentLoaded', function () {
        // --- Logic for the new Language Modal ---
        const bookTicketsButton = document.getElementById('book-tickets-button');
        const languageModal = document.getElementById('language-modal');
        const closeLangModalButton = document.getElementById('close-lang-modal-button');

        if(bookTicketsButton) {
            bookTicketsButton.addEventListener('click', () => languageModal.classList.remove('hidden'));
        }
        if(closeLangModalButton) {
            closeLangModalButton.addEventListener('click', () => languageModal.classList.add('hidden'));
        }
    });
	</script>
	
	<script>
	    document.addEventListener('DOMContentLoaded', function () {
	        // Get the movie ID from the model (passed by the server-side JSP)
	        const movieId = ${movie.id};
	        const castListDiv = document.getElementById('cast-list');
	
	        // Use the Fetch API to call our new REST endpoint
	        fetch('${pageContext.request.contextPath}/api/movies/' + movieId + '/cast')
	            .then(response => response.json()) // Parse the JSON response
	            .then(cast => {
	                // Clear the "Loading..." message
	                castListDiv.innerHTML = '';
	
	                if (cast.length > 0) {
	                    // Loop through the array of cast names
	                    cast.forEach(name => {
	                        // Create a new element for each cast member
	                        const castMemberSpan = document.createElement('span');
	                        castMemberSpan.className = 'bg-gray-200 text-gray-800 text-sm font-semibold px-3 py-1 rounded-full';
	                        castMemberSpan.textContent = name;
	
	                        // Add it to the page
	                        castListDiv.appendChild(castMemberSpan);
	                    });
	                } else {
	                    castListDiv.innerHTML = '<p class="text-gray-500">Cast information not available.</p>';
	                }
	            })
	            .catch(error => {
	                console.error('Error fetching cast:', error);
	                castListDiv.innerHTML = '<p class="text-gray-500">Could not load cast information.</p>';
	            });
	    });
	</script>

</body>
</html>
