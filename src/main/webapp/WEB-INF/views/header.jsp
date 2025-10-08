<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header class="bg-white sticky top-0 z-50 py-2 px-4 sm:px-6 lg:px-8 border-b border-gray-200">
    <div class="container mx-auto flex items-center justify-between">
        <div class="flex items-center space-x-1">
            <a href="${pageContext.request.contextPath}/" class="flex-shrink-0">
                <svg class="w-12 h-12" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                    <circle cx="50" cy="50" r="48" fill="#ef4444"/>
                    <text x="50" y="46" font-size="22" class="logo-font" fill="white" text-anchor="middle">SHOW</text>
                    <text x="50" y="71" font-size="22" class="logo-font" fill="white" text-anchor="middle">TIME</text>
                </svg>
            </a>
            <button id="location-button" class="flex items-center space-x-1"> 
                <svg class="w-6 h-6 text-gray-800" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z" /><path stroke-linecap="round" stroke-linejoin="round" d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1115 0z" /></svg>
                <div class="text-left">
                    <h1 id="current-city" class="text-lg font-bold">${not empty selectedCity ? selectedCity : 'Select City'}</h1>
                    <p class="text-xs text-gray-500">India</p>
                </div>
            </button>
        </div>
        
        <div class="flex items-center space-x-3">
            <c:choose>
                <%-- This block runs IF a user is logged in --%>
                <c:when test="${not empty sessionScope.user}">
				    <%-- This is now a single icon that links to the user's profile page --%>
				    <a href="${pageContext.request.contextPath}/profile" class="flex-shrink-0">
				        <svg class="w-10 h-10" viewBox="0 0 24 24" fill="#25314C" xmlns="http://www.w3.org/2000/svg">
				            <path d="M12 2a10 10 0 1 0 10 10A10 10 0 0 0 12 2Zm.008 5a3 3 0 1 1-3 3 3 3 0 0 1 3-3ZM12 20.5a8.456 8.456 0 0 1-5.74-2.24 3.829 3.829 0 0 1 4.03-2.69h3.42a3.856 3.856 0 0 1 4.03 2.69A8.456 8.456 0 0 1 12 20.5Z"></path>
				        </svg>
				    </a>
				</c:when>

                <%-- This block runs IF no user is logged in --%>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/register" class="bg-red-500 text-white font-semibold py-1.5 px-2 rounded-lg transition-colors">
                        Register
                    </a>
                    <a href="${pageContext.request.contextPath}/login" class="bg-white-100 text-red-500 font-semibold py-1.5 px-2 rounded-lg transition-colors border border-red-500">
                        Login
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>