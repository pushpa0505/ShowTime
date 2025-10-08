<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Movie Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700&family=Righteous&display=swap" rel="stylesheet">
    <style> 
        body { font-family: 'Figtree', sans-serif; background-color: #f1f5f9; } 
        .logo-font { font-family: 'Righteous', cursive; }
        .sidebar-link { transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out; }
        .sidebar-link.active { background-color: #ef4444; color: white; }
        .sidebar-link:not(.active):hover { background-color: #f87171; color: white; }
        #sidebar { transition: transform 0.3s ease-in-out; }
        .filter-btn.active { background-color: #ef4444; color: white; }
        .modal-backdrop { transition: opacity 0.3s ease-in-out; }
    </style>
</head>
<body class="text-gray-900">

    <!-- Mobile menu button -->
        <div class="md:hidden flex justify-between items-center bg-gray-800 text-white p-4">
            <a href="#" class="flex items-center space-x-2">
                <span class="text-xl font-bold logo-font">MOVIE MANAGEMENT</span>
            </a>
            <button id="mobile-menu-button" class="focus:outline-none">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16m-7 6h7"></path></svg>
            </button>
        </div>

        <!-- Sidebar -->
        <aside id="sidebar" class="w-64 bg-gray-800 text-white flex-col fixed inset-y-0 left-0 transform -translate-x-full md:translate-x-0 z-30 flex">
            <jsp:include page="sidebar.jsp" />
        </aside>

        <!-- Main content -->
        <div class="flex-1 flex flex-col overflow-hidden md:ml-64">
            <header class="hidden md:flex justify-between items-center p-6 bg-white border-b">
                <h1 class="text-2xl font-bold text-gray-800">Movie Management</h1>
                <div class="flex items-center space-x-4"><span class="text-sm font-semibold">${sessionScope.adminUser.fullName}</span></div>
            </header>

            <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-100 p-6">
                <c:if test="${not empty successMessage}">
                    <div id="success-alert" class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4 transition-all duration-500 ease-in-out" role="alert">
                        <span class="block sm:inline">${successMessage}</span>
                        <button type="button" class="absolute top-1/2 right-4 transform -translate-y-1/2 text-green-700 hover:text-green-900" onclick="this.parentElement.style.display='none';"><svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" /></svg></button>
                    </div>
                </c:if>
                <div class="flex flex-col sm:flex-row justify-between items-center mb-6 gap-4">
    				<form action="${pageContext.request.contextPath}/admin/movies" method="get" class="relative w-full sm:w-96">
        				<input type="text" name="search" value="${currentSearch}" placeholder="Search for movies..." class="bg-white border border-gray-300 rounded-lg py-2 pl-4 pr-10 w-full focus:outline-none focus:ring-2 focus:ring-red-500">
        				<button type="submit" class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400">
            				<svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-5.197-5.197m0 0A7.5 7.5 0 105.196 5.196a7.5 7.5 0 0010.607 10.607z" /></svg>
        				</button>
    				</form>
    				<button id="add-movie-button" type="button" class="bg-red-500 hover:bg-red-600 text-white font-bold py-2 px-4 rounded-lg flex items-center w-full sm:w-auto justify-center flex-shrink-0">
        				Add New Movie
    				</button>
				</div>

                <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-7 gap-4">
                    <c:forEach var="m" items="${movies}">
                        <div class="movie-card bg-white rounded-lg shadow-md overflow-hidden flex flex-col">
                            <img src="${m.posterUrl}" alt="${m.title} Poster" class="w-full h-auto object-cover aspect-[2/3]">
						<div class="p-3 flex flex-col flex-grow">
							<h3 class="text-base font-bold text-gray-800 truncate">${m.title}</h3>
							<c:choose>
								<c:when test="${m.status == 'Now Showing'}">
									<span
										class="bg-green-100 text-green-800 text-xs font-medium my-2 px-2.5 py-0.5 rounded-full self-start">Now
										Showing</span>
								</c:when>
								<c:when test="${m.status == 'Upcoming'}">
									<span
										class="bg-blue-100 text-blue-800 text-xs font-medium my-2 px-2.5 py-0.5 rounded-full self-start">Upcoming</span>
								</c:when>
							</c:choose>
							<div class="text-xs text-gray-600 space-y-1 mt-1">
								<p>${m.certificate}&bull; ${m.genre} &bull; ${m.duration}</p>
								<p>
									<span class="font-semibold">Languages:</span> ${m.languages}
								</p>
								<p>
									<span class="font-semibold">Release:</span>
									<fmt:formatDate value="${m.releaseDate}" pattern="MMM dd, yyyy" />
								</p>
							</div>
							<div class="mt-auto pt-3 flex justify-end space-x-3 items-center">
								<a
									href="${pageContext.request.contextPath}/admin/movies/edit/${m.id}"
									class="font-medium text-blue-600 hover:underline text-sm">Edit</a>
								<form
									action="${pageContext.request.contextPath}/admin/movies/delete/${m.id}"
									method="post" class="inline"
									onsubmit="return confirm('Are you sure you want to delete this movie?');">
									<button type="submit"
										class="font-medium text-red-600 hover:underline text-sm">Delete</button>
								</form>
							</div>
						</div>
					</div>
                    </c:forEach>
                </div>
            </main>
        </div>
    </div>

	<!-- Add movie modal -->
    <div id="movie-modal" class="modal-backdrop fixed inset-0 bg-gray-900 bg-opacity-50 flex items-center justify-center p-4 hidden">
        <div class="bg-white rounded-lg shadow-xl w-full max-w-2xl transform transition-all">
            <div class="flex justify-between items-center p-4 border-b">
                <h3 id="modal-title" class="text-xl font-bold">Add New Movie</h3>
                <a href="${pageContext.request.contextPath}/admin/movies" id="close-modal-button" class="text-gray-400 hover:text-gray-600"><svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg></a>
            </div>
            <c:url var="formAction" value="/admin/movies/${movie.id == 0 ? 'add' : 'update'}" />
            <form:form id="movie-form" modelAttribute="movie" action="${formAction}" method="post" class="p-6 space-y-4 max-h-[70vh] overflow-y-auto">
                <form:hidden path="id"/>
                <div>
                    <label for="movie-title" class="block text-sm font-medium text-gray-700">Movie Title</label>
                    <form:input path="title" type="text" id="movie-title" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm"/>
                    <form:errors path="title" cssClass="text-red-500 text-sm mt-1"/>
                </div>
                <div>
                    <label for="movie-description" class="block text-sm font-medium text-gray-700">Movie Description</label>
                    <form:textarea path="description" rows="3" id="movie-description" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm"/>
                    <form:errors path="description" cssClass="text-red-500 text-sm mt-1"/>
                </div>
                <div>
                    <label for="movie-poster" class="block text-sm font-medium text-gray-700">Poster Image URL</label>
                    <form:input path="posterUrl" type="text" id="movie-poster" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm"/>
                    <form:errors path="posterUrl" cssClass="text-red-500 text-sm mt-1"/>
                </div>
                <div>
                    <label for="movie-trailer" class="block text-sm font-medium text-gray-700">Trailer Link (YouTube URL)</label>
                    <form:input path="trailerUrl" type="url" id="movie-trailer" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm"/>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div>
                        <label for="movie-duration" class="block text-sm font-medium text-gray-700">Duration (e.g., 2h 30m)</label>
                        <form:input path="duration" type="text" id="movie-duration" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm"/>
                        <form:errors path="duration" cssClass="text-red-500 text-sm mt-1"/>
                    </div>
                    <div>
                        <label for="movie-release-date" class="block text-sm font-medium text-gray-700">Release Date</label>
                        <form:input path="releaseDate" type="date" id="movie-release-date" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm"/>
                        <form:errors path="releaseDate" cssClass="text-red-500 text-sm mt-1"/>
                    </div>
                    <div>
                        <label for="movie-certificate" class="block text-sm font-medium text-gray-700">Certificate</label>
                        <form:select path="certificate" id="movie-certificate" class="mt-1 block w-full px-3 py-2 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm">
                            <form:option value="U">U</form:option>
                            <form:option value="U/A">U/A</form:option>
                            <form:option value="A">A</form:option>
                            <form:option value="S">S</form:option>
                        </form:select>
                        <form:errors path="certificate" cssClass="text-red-500 text-sm mt-1"/>
                    </div>
                </div>
                <div>
    				<label for="movie-status" class="block text-sm font-medium text-gray-700">Status</label>
    				<form:select path="status" id="movie-status" class="mt-1 block w-full px-3 py-2 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm">
        				<form:option value="">Select Status</form:option>
        				<form:option value="Now Showing">Now Showing</form:option>
        				<form:option value="Upcoming">Upcoming</form:option>
    				</form:select>
    				<form:errors path="status" cssClass="text-red-500 text-sm mt-1"/>
				</div>
                <div>
                    <label for="movie-languages" class="block text-sm font-medium text-gray-700">Languages (comma-separated)</label>
                    <form:input path="languages" type="text" id="movie-languages" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm"/>
                </div>
                <div>
                    <label for="movie-genre" class="block text-sm font-medium text-gray-700">Genre (comma-separated)</label>
                    <form:input path="genre" type="text" id="movie-genre" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm"/>
                </div>
                <div>
                    <label for="movie-cast" class="block text-sm font-medium text-gray-700">Cast (comma-separated)</label>
                    <form:input path="cast" type="text" id="movie-cast" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm"/>
                </div>
            </form:form>
            <div class="px-6 py-4 bg-gray-50 text-right space-x-2">
                <a href="${pageContext.request.contextPath}/admin/movies" id="cancel-modal-button" type="button" class="inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50">Cancel</a>
                <button type="submit" form="movie-form" class="inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-red-600 text-base font-medium text-white hover:bg-red-700">Save Movie</button>
            </div>
        </div>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Mobile sidebar toggle
            const mobileMenuButton = document.getElementById('mobile-menu-button');
            const sidebar = document.getElementById('sidebar');
            if (mobileMenuButton) {
                mobileMenuButton.addEventListener('click', () => {
                    sidebar.classList.toggle('-translate-x-full');
                });
            }
            // Modal functionality
            const addMovieButton = document.getElementById('add-movie-button');
            const movieModal = document.getElementById('movie-modal');
            const closeModalButton = document.getElementById('close-modal-button');
            const cancelModalButton = document.getElementById('cancel-modal-button');
            const modalTitle = document.getElementById('modal-title');
            const movieForm = document.getElementById('movie-form');
            const openModal = () => movieModal.classList.remove('hidden');
            const closeModal = () => movieModal.classList.add('hidden');
            if (addMovieButton) {
                addMovieButton.addEventListener('click', () => {
                    modalTitle.textContent = 'Add New Movie';
                    movieForm.reset();
                    document.querySelector('input[name="id"]').value = '0';
                    openModal();
                });
            }
            if (closeModalButton) closeModalButton.addEventListener('click', closeModal);
            if (cancelModalButton) cancelModalButton.addEventListener('click', closeModal);
            movieModal.addEventListener('click', function(event) {
                if (event.target === movieModal) closeModal();
            });
            // Auto-open modal for EDIT or VALIDATION ERRORS
            const isEditMode = ${movie.id != null && movie.id > 0};
            const hasErrors = ${requestScope['org.springframework.validation.BindingResult.movie'] != null && requestScope['org.springframework.validation.BindingResult.movie'].hasErrors()};
            if (isEditMode || hasErrors) {
                if (isEditMode) {
                    modalTitle.textContent = 'Edit Movie';
                } else {
                    modalTitle.textContent = 'Add New Movie';
                }
                openModal();
            }
            // Auto-dismiss success alert
            const successAlert = document.getElementById('success-alert');
            if (successAlert) {
                setTimeout(() => {
                    successAlert.classList.add('opacity-0', '-translate-y-4');
                    setTimeout(() => { successAlert.style.display = 'none'; }, 500);
                }, 3000);
            }
        });
    </script>
</body>
</html>