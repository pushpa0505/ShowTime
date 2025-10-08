<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Register</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700&family=Righteous&display=swap" rel="stylesheet">
    <style> 
        body { 
            font-family: 'Figtree', sans-serif; 
            background-color: #f1f5f9; 
        } 
        .logo-font { 
            font-family: 'Righteous', cursive; 
        }
    </style>
</head>
<body class="text-gray-900">

    <div class="min-h-screen flex items-center justify-center bg-gray-100">
        <div class="w-full max-w-md p-8 space-y-6 bg-white rounded-lg shadow-md">
            <!-- Logo and Title -->
            <div class="flex flex-col items-center">
                <a href="homepage" class="flex items-center space-x-2">
                    <svg class="w-12 h-12 text-red-500" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg"><circle cx="50" cy="50" r="48" fill="#ef4444"/><text x="50" y="46" font-size="22" class="logo-font" fill="white" text-anchor="middle">SHOW</text><text x="50" y="71" font-size="22" class="logo-font" fill="white" text-anchor="middle">TIME</text></svg>
                    <span class="text-3xl font-bold logo-font text-gray-800">ADMIN</span>
                </a>
                <h2 class="mt-4 text-xl text-center text-gray-600">Create your admin account.</h2>
            </div>
            
            <c:if test="${not empty errorMessage}">
    			<div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 mb-4 rounded relative" role="alert">
       				<span class="block sm:inline">${errorMessage}</span>
    			</div>
			</c:if>
            
            <!-- Registration Form -->
            <form:form class="space-y-6" action="register" method="post" modelAttribute="user">
                 <div>
                    <label for="fullName" class="block text-sm font-medium text-gray-700">Full Name</label>
                    <form:input type="text" path="fullName" required="required" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm"/>
                    <form:errors path="fullName" cssClass="text-red-500 text-sm mt-1" />
                </div>
                <div>
                    <label for="email" class="block text-sm font-medium text-gray-700">Email Address</label>
                    <form:input type="email" path="email" required="required" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm"/>
                    <form:errors path="email" cssClass="text-red-500 text-sm mt-1" />
                </div>
                <div>
                    <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                    <form:password path="password" required="required" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm"/>
                    <form:errors path="password" cssClass="text-red-500 text-sm mt-1" />
                </div>
                
                <div>
                    <button type="submit" class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500">
                        Create Account
                    </button>
                </div>
            </form:form>

            <!-- Link to Login Page -->
            <p class="text-sm text-center text-gray-600">
                Already have an account?
                <a href="login" class="font-medium text-red-600 hover:text-red-500">
                    Sign in here
                </a>
            </p>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const passwordInput = document.getElementById('password');
            const togglePasswordButton = document.getElementById('toggle-password');
            const eyeOpenIcon = document.getElementById('eye-open');
            const eyeClosedIcon = document.getElementById('eye-closed');

            if (togglePasswordButton) {
                togglePasswordButton.addEventListener('click', function () {
                    // Toggle the type attribute
                    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                    passwordInput.setAttribute('type', type);

                    // Toggle the icon visibility
                    eyeOpenIcon.classList.toggle('hidden');
                    eyeClosedIcon.classList.toggle('hidden');
                });
            }
        });
    </script>

</body>
</html>
