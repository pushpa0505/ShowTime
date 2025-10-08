<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Showtime - War 2</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700&family=Righteous&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Figtree', sans-serif; background-color: #f8f8f8; }
        .custom-scrollbar::-webkit-scrollbar { display: none; }
        .custom-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
        .date-chip { transition: all 0.2s ease-in-out; }
        .date-chip.active { background-color: #ef4444; color: white; border-color: #ef4444; }
        .time-chip { transition: all 0.2s ease-in-out;  white-space: nowrap; }
        .time-chip:hover { border-color: #16a34a; color: #16a34a; }
        .logo-font { font-family: 'Righteous', cursive; }
    </style>
</head>
<body class="text-gray-900 flex flex-col min-h-screen">

    <!-- Header -->
    <jsp:include page="header.jsp" />

    <!-- Main Content -->
    <main class="container mx-auto px-4 sm:px-6 lg:px-8 py-6 flex-grow">
        <div class="flex items-center space-x-4 mb-6">
            <a href="${pageContext.request.contextPath}/movie/${movie.id}" class="text-gray-600 hover:text-red-500">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" />
                </svg>
            </a>
            <div>
                <h1 class="text-xl font-bold">${movie.title}</h1>
                <p class="text-sm text-gray-500">${movie.certificate} • ${selectedLanguage} • ${movie.duration}</p>
            </div>
        </div>

        <div class="mb-8">
            <div class="flex space-x-3 overflow-x-auto pb-2">
                 <c:forEach var="dateChip" items="${dateList}">
                    <c:set var="isActive" value="${dateChip.dateValue.equals(selectedDate) ? 'active' : ''}" />
                    <a href="?movieId=${movie.id}&date=${dateChip.dateValue}&language=${selectedLanguage}" class="date-chip ${isActive} flex-shrink-0 text-center border-2 border-gray-300 rounded-lg px-4 py-2">
                        <p class="font-bold text-sm">${dateChip.dayOfWeek}</p>
                        <p class="text-xs">${dateChip.dayAndMonth}</p>
                    </a>
                </c:forEach>
            </div>
        </div>
        
        <!-- language filter -->
		<c:if test="${availableLanguages.size() > 1}">
		    <div class="mb-8">
		        <div class="flex items-center space-x-3 overflow-x-auto pb-2">
		            <c:forEach var="lang" items="${availableLanguages}">
		                <c:set var="isLangActive" value="${lang.equals(selectedLanguage) ? 'active' : ''}" />
		                <a href="?movieId=${movie.id}&date=${selectedDate}&language=${lang}" class="date-chip ${isLangActive} flex-shrink-0 text-center border-2 border-gray-300 rounded-lg px-4 py-2">
		                    ${lang}
		                </a>
		            </c:forEach>
		        </div>
		    </div>
		</c:if>

        <div class="space-y-6">
            <c:choose>
                <c:when test="${not empty showtimes}">
                    <c:set var="currentTheaterId" value="0" />
                    
                    <c:forEach var="viewModel" items="${showtimes}">
                        <c:if test="${viewModel.showtime.theater.id != currentTheaterId}">
                            <c:if test="${currentTheaterId != 0}">
                                </div> </div>
                            </c:if>
                            
                            <div class="bg-white p-4 rounded-xl shadow">
                                <h3 class="font-bold text-lg">${viewModel.showtime.theater.name}, ${viewModel.showtime.theater.location}</h3>
                                <div class="mt-4 grid grid-cols-3 sm:grid-cols-4 md:grid-cols-5 gap-3">
                            <c:set var="currentTheaterId" value="${viewModel.showtime.theater.id}" />
                        </c:if>
                        
                        <a href="${pageContext.request.contextPath}/seat-selection/${viewModel.showtime.id}" class="time-chip text-center border-2 border-gray-300 text-green-600 font-semibold py-2 px-2 rounded-lg">
                           ${viewModel.formattedStartTime}
                        </a>
                    </c:forEach>
                    
                    <c:if test="${currentTheaterId != 0}">
                        </div> </div>
                    </c:if>
                    
                </c:when>

                <c:otherwise>
                    <div class="text-center py-10">
                        <p class="text-gray-600">Sorry, no showtimes available for this movie on the selected date.</p>
                    </div>
                </c:otherwise>

            </c:choose>
        </div>
    </main>
    
    <!-- FOOTER -->
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
</body>
</html>
