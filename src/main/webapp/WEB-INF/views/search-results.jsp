<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- important for mobile -->
    <title>Search Results</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700&family=Righteous&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Figtree', sans-serif; background-color: #f8f8f8; }
        .logo-font { font-family: 'Righteous', cursive; }
    </style>
</head>
<body class="text-gray-900 flex flex-col min-h-screen">

    <jsp:include page="header.jsp" />

    <main class="container mx-auto px-4 sm:px-6 lg:px-8 py-6 flex-grow">
        <div class="flex items-center space-x-4 mb-8">
		    <a href="${pageContext.request.contextPath}/" class="text-gray-600 hover:text-red-500 transition-colors">
		      <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
		        <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" />
		      </svg>
		    </a>
		    <h2 class="text-xl font-bold">Search Results for '<c:out value="${searchQuery}"/>'</h2>
		</div>

        <c:choose>
            <c:when test="${not empty searchResults}">
                <div class="grid grid-cols-2 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-6 gap-4 sm:gap-6">
                    <c:forEach var="movie" items="${searchResults}">
                        <a href="${pageContext.request.contextPath}/movie/${movie.id}" class="group">
                            <div class="bg-white rounded-lg shadow-sm cursor-pointer transition-shadow hover:shadow-lg overflow-hidden">
                                <div class="w-full aspect-[2/3] relative">
                                    <img src="${movie.posterUrl}" alt="${movie.title}" class="w-full h-full object-cover rounded-t-lg">
                                </div>
                                <div class="p-3">
								    <c:choose>
								        <c:when test="${movie.status == 'Now Showing'}">
								            <span class="bg-green-100 text-green-800 text-xs font-medium mb-2 inline-block px-2.5 py-0.5 rounded-full">Now Showing</span>
								        </c:when>
								        <c:when test="${movie.status == 'Upcoming'}">
								            <span class="bg-blue-100 text-blue-800 text-xs font-medium mb-2 inline-block px-2.5 py-0.5 rounded-full">Upcoming</span>
								        </c:when>
								    </c:choose>
								    <h3 class="font-bold text-md truncate">${movie.title}</h3>
								    <p class="text-gray-600 text-sm">${movie.certificate} &bull; ${movie.languages}</p>
								</div>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <p class="text-gray-600 mt-8 text-center text-sm sm:text-base">No movies found matching your search in ${selectedCity}.</p>
            </c:otherwise>
        </c:choose>
    </main>

</body>
</html>
