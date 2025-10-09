<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - ShowTime</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700&family=Righteous&display=swap" rel="stylesheet">
    <style> 
        body { font-family: 'Figtree', sans-serif; background-color: #f8f8f8; } 
        .logo-font { font-family: 'Righteous', cursive; }
    </style>
</head>
<body class="text-gray-900 flex flex-col min-h-screen">

    <!-- Header -->
    <jsp:include page="header.jsp" />

    <main class="container mx-auto px-4 sm:px-6 lg:px-8 py-12 flex-grow flex items-center justify-center">
	    <div class="bg-white p-8 rounded-2xl shadow-lg w-full max-w-md">
	        <h2 class="text-3xl font-bold text-center mb-6">Login to ShowTime</h2>
	
	        <%-- Display success message from registration --%>
	        <c:if test="${not empty successMessage}">
	            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 mb-4 rounded" role="alert">
	                ${successMessage}
	            </div>
	        </c:if>
	        
	        <%-- Display error message from failed login --%>
	        <c:if test="${not empty errorMessage}">
	            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 mb-4 rounded" role="alert">
	                ${errorMessage}
	            </div>
	        </c:if>
			
			<!-- Login form -->
	        <form class="space-y-6" action="${pageContext.request.contextPath}/login" method="post">
	            <div>
	                <label for="email" class="block text-sm font-medium text-gray-700">Email Address</label>
	                <input type="email" id="email" name="email" required 
	                    class="mt-1 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500">
	            </div>

	            <!-- Password with eye toggle -->
	            <div>
	                <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
	                <div class="relative mt-1">
	                    <input type="password" id="password" name="password" required
	                        class="block w-full pr-10 pl-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500">
	                    <button type="button" onclick="togglePassword('password', this)" 
	                        class="absolute inset-y-0 right-0 flex items-center pr-3 text-gray-500 hover:text-red-600">
	                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
	                            stroke="currentColor" stroke-width="2" class="h-5 w-5">
	                            <path stroke-linecap="round" stroke-linejoin="round"
	                                d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
	                            <path stroke-linecap="round" stroke-linejoin="round"
	                                d="M2.458 12C3.732 7.943 7.523 5 12 5c4.477 0 
	                                   8.268 2.943 9.542 7-1.274 4.057-5.065 
	                                   7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
	                        </svg>
	                    </button>
	                </div>
	            </div>

	            <div>
	                <button type="submit" 
	                    class="w-full bg-red-500 hover:bg-red-600 text-white font-bold py-3 px-6 rounded-lg transition-colors">
	                    Login
	                </button>
	            </div>

	            <div class="text-center text-sm text-gray-600">
	                <p>Don't have an account? 
	                    <a href="register" class="font-semibold text-red-500 hover:underline">Register here</a>
	                </p>
	            </div>
	        </form>
	    </div>
	</main>
    
    <!-- Footer -->
    <jsp:include page="footer.jsp"></jsp:include>

    <!-- Password toggle script -->
    <script>
        function togglePassword(inputId, button) {
            const input = document.getElementById(inputId);
            const svg = button.querySelector('svg');
            const isShowing = input.type === 'text';

            input.type = isShowing ? 'password' : 'text';
            svg.innerHTML = isShowing
                ? `<path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/><path stroke-linecap="round" stroke-linejoin="round" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.477 0 8.268 2.943 9.542 7-1.274 4.057-5.065 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>`
                : `<path stroke-linecap="round" stroke-linejoin="round" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.477 0-8.268-2.943-9.542-7a9.96 9.96 0 012.766-4.15M6.31 6.31L17.69 17.69M9.88 9.88a3 3 0 014.24 4.24"/>`;
        }
    </script>

</body>
</html>
