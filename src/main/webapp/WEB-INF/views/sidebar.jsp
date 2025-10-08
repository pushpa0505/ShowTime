<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Sidebar Header (Static) -->
            <div class="h-20 flex items-center justify-center bg-gray-900 flex-shrink-0">
                 <a href="${pageContext.request.contextPath}/admin/dashboard" class="flex items-center space-x-2">
                    <svg class="w-10 h-10 text-red-500" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg"><circle cx="50" cy="50" r="48" fill="#ef4444"/><text x="50" y="46" font-size="22" class="logo-font" fill="white" text-anchor="middle">SHOW</text><text x="50" y="71" font-size="22" class="logo-font" fill="white" text-anchor="middle">TIME</text></svg>
                    <span class="text-xl font-bold logo-font">ADMIN</span>
                </a>
            </div>
            
            <!-- Scrollable Navigation Links -->
            <div class="flex-1 overflow-y-auto">
                <nav class="px-4 py-6 space-y-2">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link flex items-center px-4 py-2 rounded-lg">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" viewBox="0 0 20 20" fill="currentColor"><path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z" /></svg>
                        Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/movies" class="sidebar-link flex items-center px-4 py-2 rounded-lg">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" viewBox="0 0 20 20" fill="currentColor"><path d="M7 3a1 1 0 000 2h6a1 1 0 100-2H7zM4 7a1 1 0 011-1h10a1 1 0 110 2H5a1 1 0 01-1-1zM2 11a1 1 0 011-1h14a1 1 0 110 2H3a1 1 0 01-1-1z" /></svg>
                        Movies
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/showtimes" class="sidebar-link flex items-center px-4 py-2 rounded-lg">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00.293.707l2.828 2.829a1 1 0 101.415-1.415L11 9.586V6z" clip-rule="evenodd" /></svg>
                        Showtimes
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/theaters" class="sidebar-link flex items-center px-4 py-2 rounded-lg">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" /></svg>
                        Theaters
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/bookings" class="sidebar-link flex items-center px-4 py-2 rounded-lg">
                         <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                         </svg>
                        Bookings
                    </a>
                </nav>
            </div>
            
            <!-- Sidebar Footer (Static) -->
            <div class="px-4 py-6 flex-shrink-0">
                <a href="${pageContext.request.contextPath}/admin/logout" class="sidebar-link flex items-center px-4 py-2 rounded-lg mt-2">
                     <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" /></svg>
                    Logout
                </a>
            </div>