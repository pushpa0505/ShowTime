<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Personal Info - ShowTime</title>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700&family=Righteous&display=swap"
	rel="stylesheet">
<style>
body {
	font-family: 'Figtree', sans-serif;
	background-color: #f8f8f8;
}

.logo-font {
	font-family: 'Righteous', cursive;
}
</style>
</head>
<body class="text-gray-900 flex flex-col min-h-screen">

	<!-- Header -->
	<jsp:include page="header.jsp" />

	<main class="container mx-auto px-4 sm:px-6 lg:px-8 py-6 flex-grow">
		<div class="flex items-center space-x-4 mb-6 max-w-2xl mx-auto">
			<a href="${pageContext.request.contextPath}/profile"
				class="text-gray-600 hover:text-red-500"> <svg
					xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none"
					viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
	              <path stroke-linecap="round" stroke-linejoin="round"
						d="M15 19l-7-7 7-7" />
	            </svg>
			</a>
			<div>
				<h1 class="text-xl font-bold">Profile Info</h1>
			</div>
		</div>

		<div class="max-w-2xl mx-auto">
			<div class="bg-white p-6 rounded-2xl shadow-lg">
				<form:form modelAttribute="user"
					action="${pageContext.request.contextPath}/profile/update"
					method="post" class="space-y-6">
					<div>
						<label for="fullName"
							class="block text-sm font-medium text-gray-700">Full Name</label>
						<div class="mt-1 relative rounded-md shadow-sm">
							<div
								class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
								<svg xmlns="http://www.w3.org/2000/svg"
									class="h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24"
									stroke="currentColor" stroke-width="2">
									<path stroke-linecap="round" stroke-linejoin="round"
										d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" /></svg>
							</div>
							<form:input type="text" path="fullName" id="fullName"
								class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm" />
						</div>
					</div>

					<div>
						<label for="email" class="block text-sm font-medium text-gray-700">Email
							Address</label>
						<div class="mt-1 relative rounded-md shadow-sm">
							<div
								class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
								<svg xmlns="http://www.w3.org/2000/svg"
									class="h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24"
									stroke="currentColor" stroke-width="2">
									<path stroke-linecap="round" stroke-linejoin="round"
										d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" /></svg>
							</div>
							<%-- Email is the login ID, so we make it read-only --%>
							<form:input type="email" path="email" id="email" readonly="true"
								class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md bg-gray-100 sm:text-sm" />
						</div>
					</div>

					<div class="pt-4 text-right">
						<button type="submit"
							class="inline-flex justify-center rounded-md border border-transparent shadow-sm px-6 py-2 bg-red-600 text-base font-medium text-white hover:bg-red-700">
							Save Changes</button>
					</div>
				</form:form>
			</div>
			
			<%-- This is the updated "Change Password" form --%>
			<div class="bg-white p-6 rounded-2xl shadow-lg mt-8">
			    <h2 class="text-xl font-bold mb-4 border-b pb-2">Change Password</h2>
			
			    <%-- Display success or error messages for the password change --%>
			    <c:if test="${not empty passwordSuccessMessage}">
			        <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 mb-4 rounded">${passwordSuccessMessage}</div>
			    </c:if>
			    <c:if test="${not empty passwordErrorMessage}">
			        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 mb-4 rounded">${passwordErrorMessage}</div>
			    </c:if>
			
			    <form action="${pageContext.request.contextPath}/profile/change-password" method="post" class="space-y-6">
			        <div>
			            <label for="current-password" class="block text-sm font-medium text-gray-700">Current Password</label>
			            <input type="password" id="current-password" name="currentPassword" required class="block w-full pr-10 pl-3 py-2 border border-gray-300 rounded-md ...">
			        </div>
			
			        <div>
			            <label for="new-password" class="block text-sm font-medium text-gray-700">New Password</label>
			            <input type="password" id="new-password" name="newPassword" required class="block w-full pr-10 pl-3 py-2 border border-gray-300 rounded-md ...">
			        </div>
			
			        <%-- NEW: "Confirm New Password" field --%>
			        <div>
			            <label for="confirm-password" class="block text-sm font-medium text-gray-700">Confirm New Password</label>
			            <input type="password" id="confirm-password" name="confirmPassword" required class="block w-full pr-10 pl-3 py-2 border border-gray-300 rounded-md ...">
			        </div>
			
			        <div class="pt-4 text-right">
			            <button type="submit" class="inline-flex justify-center rounded-md border border-transparent shadow-sm px-6 py-2 bg-red-600 text-white ...">
			                Update Password
			            </button>
			        </div>
			    </form>
			</div>
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
						<li><a href="#" class="hover:text-red-500">Terms of
								Service</a></li>
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
						<a href="#" class="text-gray-500 hover:text-red-500"><svg
								class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24"
								aria-hidden="true">
								<path fill-rule="evenodd"
									d="M22 12c0-5.523-4.477-10-10-10S2 6.477 2 12c0 4.991 3.657 9.128 8.438 9.878v-6.987h-2.54V12h2.54V9.797c0-2.506 1.492-3.89 3.777-3.89 1.094 0 2.238.195 2.238.195v2.46h-1.26c-1.243 0-1.63.771-1.63 1.562V12h2.773l-.443 2.89h-2.33v6.988C18.343 21.128 22 16.991 22 12z"
									clip-rule="evenodd"></path></svg></a> <a href="#"
							class="text-gray-500 hover:text-red-500"><svg class="w-6 h-6"
								fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
								<path
									d="M8.29 20.251c7.547 0 11.675-6.253 11.675-11.675 0-.178 0-.355-.012-.53A8.348 8.348 0 0022 5.92a8.19 8.19 0 01-2.357.646 4.118 4.118 0 001.804-2.27 8.224 8.224 0 01-2.605.996 4.107 4.107 0 00-6.993 3.743 11.65 11.65 0 01-8.457-4.287 4.106 4.106 0 001.27 5.477A4.072 4.072 0 012.8 9.71v.052a4.105 4.105 0 003.292 4.022 4.095 4.095 0 01-1.853.07 4.108 4.108 0 003.834 2.85A8.233 8.233 0 012 18.407a11.616 11.616 0 006.29 1.84"></path></svg></a>
						<a href="#" class="text-gray-500 hover:text-red-500"><svg
								class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24"
								aria-hidden="true">
								<path fill-rule="evenodd"
									d="M12.315 2c2.43 0 2.784.013 3.808.06 1.064.049 1.791.218 2.427.465a4.902 4.902 0 011.772 1.153 4.902 4.902 0 011.153 1.772c.247.636.416 1.363.465 2.427.048 1.024.06 1.378.06 3.808s-.012 2.784-.06 3.808c-.049 1.064-.218 1.791-.465 2.427a4.902 4.902 0 01-1.153 1.772 4.902 4.902 0 01-1.772 1.153c-.636.247-1.363.416-2.427.465-1.024.048-1.378.06-3.808.06s-2.784-.012-3.808-.06c-1.064-.049-1.791-.218-2.427-.465a4.902 4.902 0 01-1.772-1.153 4.902 4.902 0 01-1.153-1.772c-.247-.636-.416-1.363-.465-2.427-.048-1.024-.06-1.378-.06-3.808s.012-2.784.06-3.808c.049-1.064.218-1.791.465-2.427a4.902 4.902 0 011.153-1.772A4.902 4.902 0 016.345 2.525c.636-.247 1.363-.416 2.427.465C9.793 2.013 10.147 2 12.315 2zM12 8.118c-2.136 0-3.863 1.727-3.863 3.863s1.727 3.863 3.863 3.863 3.863-1.727 3.863-3.863S14.136 8.118 12 8.118zM12 14.354c-1.306 0-2.363-1.057-2.363-2.363s1.057-2.363 2.363-2.363 2.363 1.057 2.363 2.363-1.057 2.363-2.363 2.363zM16.838 6.838a1.25 1.25 0 100 2.5 1.25 1.25 0 000-2.5z"
									clip-rule="evenodd"></path></svg></a>
					</div>
				</div>
			</div>
			<div class="mt-8 border-t border-gray-200 pt-6 text-center">
				<p class="text-sm text-gray-500">&copy; 2024 ShowTime. All
					Rights Reserved.</p>
			</div>
		</div>
	</footer>

	<script>
		function togglePassword(inputId, button) {
			const input = document.getElementById(inputId);
			const svg = button.querySelector('svg');
			const showing = input.type === 'text';

			input.type = showing ? 'password' : 'text';
			svg.innerHTML = showing ? `<path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/><path stroke-linecap="round" stroke-linejoin="round" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.477 0 8.268 2.943 9.542 7-1.274 4.057-5.065 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>`
					: `<path stroke-linecap="round" stroke-linejoin="round" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.477 0-8.268-2.943-9.542-7a9.96 9.96 0 012.766-4.15M6.31 6.31L17.69 17.69M9.88 9.88a3 3 0 014.24 4.24"/>`;
		}
	</script>

</body>
</html>
