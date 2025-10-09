<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin - Login</title>
<script src="https://cdn.tailwindcss.com"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700&family=Righteous&display=swap"
	rel="stylesheet">
<style>
body {
	font-family: 'Figtree', sans-serif;
}
.logo-font {
	font-family: 'Righteous', cursive;
}
</style>
</head>
<body class="bg-gray-100">
	<div class="min-h-screen flex items-center justify-center px-4 sm:px-0">
		<div class="w-full max-w-sm sm:max-w-md p-6 sm:p-8 space-y-6 bg-white rounded-lg shadow-md">
			<div class="flex flex-col items-center text-center">
				<span class="text-2xl sm:text-3xl font-bold logo-font text-gray-800">
					ADMIN LOGIN
				</span>
			</div>

			<!-- Success Message -->
			<c:if test="${not empty successMessage}">
				<div
					class="bg-green-100 border border-green-400 text-green-700 px-3 py-2 sm:px-4 sm:py-3 mb-4 rounded relative text-sm sm:text-base"
					role="alert">
					<span class="block sm:inline">${successMessage}</span>
				</div>
			</c:if>

			<!-- Error Message -->
			<c:if test="${not empty error}">
				<div
					class="relative bg-red-100 border border-red-400 text-red-700 px-3 py-2 sm:px-4 sm:py-3 rounded text-sm sm:text-base"
					role="alert">
					<span class="block sm:inline">${error}</span>
					<button type="button"
						class="absolute top-1/2 right-3 transform -translate-y-1/2 text-red-700 hover:text-red-900"
						onclick="this.parentElement.style.display='none';">
						<svg class="h-4 w-4 sm:h-5 sm:w-5" fill="none" viewBox="0 0 24 24"
							stroke="currentColor">
                            <path stroke-linecap="round"
								stroke-linejoin="round" stroke-width="2"
								d="M6 18L18 6M6 6l12 12" />
                        </svg>
					</button>
				</div>
			</c:if>

			<!-- Login Form -->
			<form class="space-y-5 sm:space-y-6"
				action="${pageContext.request.contextPath}/admin/login"
				method="post">
				<div>
					<label for="email" class="block text-sm font-medium text-gray-700">Email
						Address</label> 
					<input type="email" id="email" name="email" required
						class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm
						focus:outline-none focus:ring-red-500 focus:border-red-500 text-sm sm:text-base">
				</div>

				<!-- Password with Eye Toggle -->
				<div>
					<label for="password" class="block text-sm font-medium text-gray-700">Password</label>
					<div class="relative mt-1">
						<input type="password" id="password" name="password" required
							class="block w-full px-3 py-2 pr-10 border border-gray-300 rounded-md shadow-sm
							focus:outline-none focus:ring-red-500 focus:border-red-500 text-sm sm:text-base">

						<!-- Eye Toggle Button -->
						<button type="button" id="toggle-password"
							class="absolute inset-y-0 right-0 flex items-center pr-3 text-gray-500 hover:text-gray-700 focus:outline-none">
							<!-- Eye Open Icon -->
							<svg id="eye-open" xmlns="http://www.w3.org/2000/svg" fill="none"
								viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
								class="w-5 h-5">
								<path stroke-linecap="round" stroke-linejoin="round"
									d="M2.25 12s3.75-6.75 9.75-6.75S21.75 12 21.75 12s-3.75 6.75-9.75 6.75S2.25 12 2.25 12z" />
								<circle cx="12" cy="12" r="3" />
							</svg>

							<!-- Eye Closed Icon -->
							<svg id="eye-closed" xmlns="http://www.w3.org/2000/svg" fill="none"
								viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
								class="w-5 h-5 hidden">
								<path stroke-linecap="round" stroke-linejoin="round"
									d="M3.98 8.223A10.477 10.477 0 001.5 12s3.75 6.75 9.75 6.75a9.7 9.7 0 004.69-1.223m3.93-2.907A10.48 10.48 0 0022.5 12s-3.75-6.75-9.75-6.75a9.71 9.71 0 00-4.69 1.223" />
								<path stroke-linecap="round" stroke-linejoin="round"
									d="M15 12a3 3 0 01-3 3m0-6a3 3 0 013 3M3 3l18 18" />
							</svg>
						</button>
					</div>
				</div>

				<div>
					<button type="submit"
						class="w-full flex justify-center py-2 sm:py-2.5 px-4 border border-transparent rounded-md shadow-sm
						text-sm sm:text-base font-medium text-white bg-red-600 hover:bg-red-700">
						Sign In
					</button>
				</div>
			</form>

			<!-- Register Link -->
			<p class="text-xs sm:text-sm text-center text-gray-600">
				Don't have an account? 
				<a href="register" class="font-medium text-red-600 hover:text-red-500">Register here</a>
			</p>
		</div>
	</div>

	<!-- Password Toggle Script -->
	<script>
		document.addEventListener("DOMContentLoaded", function () {
			const passwordInput = document.getElementById("password");
			const togglePasswordButton = document.getElementById("toggle-password");
			const eyeOpenIcon = document.getElementById("eye-open");
			const eyeClosedIcon = document.getElementById("eye-closed");

			togglePasswordButton.addEventListener("click", function () {
				const type = passwordInput.getAttribute("type") === "password" ? "text" : "password";
				passwordInput.setAttribute("type", type);

				eyeOpenIcon.classList.toggle("hidden");
				eyeClosedIcon.classList.toggle("hidden");
			});
		});
	</script>
</body>
</html>
