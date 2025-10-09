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
			<!-- Back arrow -->
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
		
		<!-- User Details -->
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
			
			<!-- Change Password -->
			<div class="bg-white p-6 rounded-2xl shadow-lg mt-8">
			    <h2 class="text-xl font-bold mb-4 border-b pb-2">Change Password</h2>
			
			    <!-- Display success or error messages for the password change -->
			    <c:if test="${not empty passwordSuccessMessage}">
			        <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 mb-4 rounded">${passwordSuccessMessage}</div>
			    </c:if>
			    <c:if test="${not empty passwordErrorMessage}">
			        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 mb-4 rounded">${passwordErrorMessage}</div>
			    </c:if>
			
			    <form action="${pageContext.request.contextPath}/profile/change-password" method="post" class="space-y-6">
			        
			        <!-- Current Password -->
			        <div>
			            <label for="current-password" class="block text-sm font-medium text-gray-700">Current Password</label>
			            <div class="relative mt-1">
			                <input type="password" id="current-password" name="currentPassword" required
			                    class="block w-full pr-10 pl-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm">
			                <button type="button" onclick="togglePassword('current-password', this)" 
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
			
			        <!-- New Password -->
			        <div>
			            <label for="new-password" class="block text-sm font-medium text-gray-700">New Password</label>
			            <div class="relative mt-1">
			                <input type="password" id="new-password" name="newPassword" required
			                    class="block w-full pr-10 pl-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm">
			                <button type="button" onclick="togglePassword('new-password', this)" 
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
			
			        <!-- Confirm Password -->
			        <div>
			            <label for="confirm-password" class="block text-sm font-medium text-gray-700">Confirm New Password</label>
			            <div class="relative mt-1">
			                <input type="password" id="confirm-password" name="confirmPassword" required
			                    class="block w-full pr-10 pl-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm">
			                <button type="button" onclick="togglePassword('confirm-password', this)" 
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
			
			        <div class="pt-4 text-right">
			            <button type="submit"
			                class="inline-flex justify-center rounded-md border border-transparent shadow-sm px-6 py-2 bg-red-600 text-white hover:bg-red-700">
			                Update Password
			            </button>
			        </div>
			    </form>
			</div>
			
		</div>
	</main>

	<!-- FOOTER -->
	<jsp:include page="footer.jsp" />
	
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
