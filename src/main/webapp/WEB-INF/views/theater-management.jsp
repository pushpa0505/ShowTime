<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Theater Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700&family=Righteous&display=swap" rel="stylesheet">
    <style> 
        body { font-family: 'Figtree', sans-serif; background-color: #f1f5f9; } 
        .logo-font { font-family: 'Righteous', cursive; }
        .sidebar-link {
            transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
        }
        .sidebar-link.active {
            background-color: #ef4444;
            color: white;
        }
        .sidebar-link:not(.active):hover {
            background-color: #f87171;
            color: white;
        }
        #sidebar {
            transition: transform 0.3s ease-in-out;
        }
    </style>
</head>
<body class="text-gray-900">
	<div class="relative h-screen md:flex">
    <!-- Mobile menu button -->
        <div class="md:hidden flex justify-between items-center bg-gray-800 text-white p-4">
           	<a href="#" class="flex items-center space-x-2">
                <span class="text-xl font-bold logo-font">THEATER MANAGEMENT</span>
            </a>
            <button id="mobile-menu-button" class="focus:outline-none">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16m-7 6h7"></path></svg>
            </button>
        </div>

        <!-- Sidebar -->
        <aside id="sidebar" class="w-64 bg-gray-800 text-white flex-col fixed inset-y-0 left-0 transform -translate-x-full md:translate-x-0 z-30 flex">
            <jsp:include page="sidebar.jsp"/>
        </aside>

        <!-- Main content -->
        <div class="flex-1 flex flex-col overflow-hidden md:ml-64">
            <header class="hidden md:flex justify-between items-center p-6 bg-white border-b">
                <h1 class="text-2xl font-bold text-gray-800">Theater Management</h1>
                <div class="flex items-center space-x-4"><span class="text-sm font-semibold">${sessionScope.adminUser.fullName}</span></div>
            </header>

            <!-- Content -->
            <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-100 p-6">
				<%-- Find and replace the existing successMessage block with this one --%>
				<c:if test="${not empty successMessage}">
					<div id="success-alert"
						class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4 transition-all duration-500 ease-in-out"
						role="alert">
						<span class="block sm:inline">${successMessage}</span>
						<button type="button"
							class="absolute top-1/2 right-4 transform -translate-y-1/2 text-green-700 hover:text-green-900"
							onclick="this.parentElement.style.display='none';">
							<svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                				<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            				</svg>
						</button>
					</div>
				</c:if>
				<div class="flex flex-col sm:flex-row justify-between items-center mb-6 gap-4">
                    <div class="flex items-center gap-4 w-full sm:w-auto">
                        <h2 class="text-xl font-semibold text-gray-700 flex-shrink-0">All Theaters</h2>
                        <select class="w-full sm:w-52 px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500">
                            <option>Filter by City</option>
                            <option>Mumbai</option>
                            <option>Delhi</option>
                            <option>Chennai</option>
                            <option>Kolkata</option>
                            <option>Ahmedabad</option>
                        </select>
                    </div>
                    <button id="add-theater-button" class="bg-red-500 hover:bg-red-600 text-white font-bold py-2 px-4 rounded-lg flex items-center w-full sm:w-auto justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z" clip-rule="evenodd" /></svg>
                        Add New Theater
                    </button>
                </div>

                <!-- Theaters Table -->
                <div class="bg-white p-6 rounded-lg shadow-md">
                    <div class="overflow-x-auto">
                        <table class="w-full text-sm text-left text-gray-500">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                                <tr>
                                    <th scope="col" class="px-6 py-3">Theater Name</th>
                                    <th scope="col" class="px-6 py-3">Location</th>
                                    <th scope="col" class="px-6 py-3">City</th>
                                    <th scope="col" class="px-6 py-3 text-right">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach var="th" items="${theaters}">
                                <tr class="theater-row bg-white border-b">
                                    <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">${th.name}</th>
                                    <td class="px-6 py-4">${th.location}</td>
                                    <td class="px-6 py-4">${th.city}</td>
                                    <td class="px-6 py-4 text-right space-x-2">
                                        <a href="${pageContext.request.contextPath}/admin/theaters/edit/${th.id}" class="font-medium text-blue-600 hover:underline">Edit</a>
                                        <form 
                                        	action="${pageContext.request.contextPath}/admin/theaters/delete/${th.id}" 
                                        	method="post"
                                        	class="inline"
                                        	onsubmit="return confirm('Are you sure you want to dlete this theater ?');">
                                        	<button
                                        		type="submit" 
                                        		class="font-medium text-red-600 hover:underline">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            	</c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- START: Add/Edit Theater Modal -->
    <div id="theater-modal" class="fixed inset-0 bg-gray-900 bg-opacity-50 flex items-center justify-center p-4 hidden">
        <div class="bg-white rounded-lg shadow-xl w-full max-w-lg transform transition-all">
            <div class="flex justify-between items-center p-4 border-b">
                <h3 id="modal-title" class="text-xl font-bold">Add New Theater</h3>
                <a href="${pageContext.request.contextPath}/admin/theaters" id="close-modal-button" class="text-gray-400 hover:text-gray-600">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>
                </a>
            </div>
            <c:url var="formAction" value="/admin/theaters/${theater.id == 0 ? 'add' : 'update'}" /> 
            <form:form id="theater-form" modelAttribute="theater" action="${formAction}" method="post" class="p-6 space-y-4">
            <form:hidden path="id"/>  <%-- Hidden field to hold the ID during an update --%>
                <div>
                    <label for="theater-name" class="block text-sm font-medium text-gray-700">Theater Name</label>
                    <form:input path="name" type="text" id="theater-name" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm" />
                    <form:errors path="name" cssClass="text-red-500 text-sm mt-1" />
                </div>
                <div>
                    <label for="theater-city" class="block text-sm font-medium text-gray-700">City</label>
                    <form:select path="city" id="theater-city" class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm rounded-md">
                        <form:option value="">Select a City</form:option>
            			<form:option value="Mumbai">Mumbai</form:option>
            			<form:option value="Delhi">Delhi</form:option>
            			<form:option value="Kolkata">Kolkata</form:option>
            			<form:option value="Ahmedabad">Ahmedabad</form:option>
            			<form:option value="Chennai">Chennai</form:option>
                    </form:select>
                    <form:errors path="city" cssClass="text-red-500 text-sm mt-1" />
                </div>
                <div>
        			<label for="theater-location" class="block text-sm font-medium text-gray-700">Location (Area)</label>
        			<form:input path="location" type="text" id="theater-location" placeholder="e.g., Virar, Andheri" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm"/>
        			<form:errors path="location" cssClass="text-red-500 text-sm mt-1" />
    			</div>
				
			</form:form>
            <div class="px-6 py-4 bg-gray-50 text-right space-x-2">
                <a href="${pageContext.request.contextPath}/admin/theaters" id="cancel-modal-button" type="button" class="inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500">
                    Cancel
                </a>
                <button type="submit" form="theater-form" class="inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-red-600 text-base font-medium text-white hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500">
                    Save Theater
                </button>
            </div>
        </div>
    </div>
    <!-- END: Add/Edit Theater Modal -->

    <script>
    document.addEventListener('DOMContentLoaded', function () {
        // Mobile sidebar toggle (from your original code)
        const mobileMenuButton = document.getElementById('mobile-menu-button');
        const sidebar = document.getElementById('sidebar');
        if(mobileMenuButton) {
            mobileMenuButton.addEventListener('click', () => {
                sidebar.classList.toggle('-translate-x-full');
            });
        }

        // Modal functionality elements
        const addTheaterButton = document.getElementById('add-theater-button');
        const theaterModal = document.getElementById('theater-modal');
        const closeModalButton = document.getElementById('close-modal-button');
        const cancelModalButton = document.getElementById('cancel-modal-button');
        const modalTitle = document.getElementById('modal-title');
        const theaterForm = document.getElementById('theater-form');

        const openModal = () => theaterModal.classList.remove('hidden');
        const closeModal = () => theaterModal.classList.add('hidden');

        // Open modal for ADDING a new theater
        addTheaterButton.addEventListener('click', () => {
            modalTitle.textContent = 'Add New Theater';
            theaterForm.reset();
            // Find the hidden ID field from our Spring Form and clear it for a new entry
            const hiddenIdField = document.querySelector('input[name="id"]');
            if (hiddenIdField) {
                hiddenIdField.value = '0'; 
            }
            openModal();
        });

        // Listeners to close the modal
        closeModalButton.addEventListener('click', closeModal);
        cancelModalButton.addEventListener('click', closeModal);
        theaterModal.addEventListener('click', (e) => {
            if (e.target === theaterModal) {
                closeModal();
            }
        });
        
        // --- NEW LOGIC FOR SERVER-SIDE EDIT AND VALIDATION ---
        
        // This JSTL expression checks if Spring sent back any validation errors.
        const hasErrors = ${not empty requestScope['org.springframework.validation.BindingResult.theater'] != null && requestScope['org.springframework.validation.BindingResult.theater'].hasErrors()};

        // This JSTL expression checks if we are in 'edit mode' (i.e., the 'theater' object has an ID).
        const isEditMode = ${not empty theater.id and theater.id > 0};

        // If we are editing OR if there are validation errors, open the modal.
        if (isEditMode || hasErrors) {
            if (isEditMode) {
                modalTitle.textContent = 'Edit Theater';
            } else {
                modalTitle.textContent = 'Add New Theater'; // Keep title correct on validation error
            }
            openModal();
        }
        
        
        const successAlert = document.getElementById('success-alert');

        // Check if the alert element exists on the page
        if (successAlert) {
            // Set a timeout to run after 3 seconds (3000 milliseconds)
            setTimeout(() => {
                // Add Tailwind classes to fade the alert out and move it up
                successAlert.classList.add('opacity-0', '-translate-y-4');
                
                // After the 500ms animation is complete, hide it completely
                setTimeout(() => {
                    successAlert.style.display = 'none';
                }, 500); // This duration should match the 'duration-500' class
                
            }, 3000);
        }

    });
</script>
</body>
</html>
