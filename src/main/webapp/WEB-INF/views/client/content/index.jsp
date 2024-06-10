<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Navbar Client</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <style>
        .product-card {
            height: 100%;
            transition: transform 0.3s, box-shadow 0.3s;
            border: 1px solid #ddd;
            border-radius: 10px;
            overflow: hidden;
            background: #fff;
        }

        .product-card:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .product-image {
            object-fit: cover;
            height: 300px;
            width: 100%;
            border-bottom: 1px solid #ddd;
        }

        .category-label {
            position: absolute;
            top: 10px;
            left: 10px;
            background-color: rgba(0, 0, 0, 0.7);
            color: white;
            padding: 5px;
            z-index: 10;
            border-radius: 5px;
            font-size: 0.9em;
        }

        .rating {
            color: #ffdd00;
        }

        .rating-fake-note {
            font-size: 0.9em;
            color: #888;
            margin-top: 5px;
        }

        .product-price {
            font-size: 1.4em;
            font-weight: bold;
            color: #007bff;
        }

        .product-description {
            overflow: hidden;
            position: relative;
            line-height: 1.2em;
            max-height: 3.6em; /* (1.2em x 3 lines) */
        }

        .product-description.expanded {
            max-height: none;
        }

        .show-more {
            cursor: pointer;
            color: blue;
            text-align: center;
            display: block;
            margin-top: 5px;
        }

        .btn-primary {
            background: linear-gradient(45deg, #007bff, #0056b3);
            border: none;
            transition: background 0.3s ease-in-out;
        }

        .btn-primary:hover {
            background: linear-gradient(45deg, #0056b3, #003d80);
        }

        .category-label {
            background: linear-gradient(45deg, #6a11cb, #2575fc);
            border: none;
            transition: background 0.3s ease-in-out;
        }

        @media (max-width: 768px) {
            .product-image {
                height: 200px;
            }
        }

        .card-title {
            height: 50px;
        }

        .no-results-message {
            font-size: 1.5em;
            text-align: center;
            margin: 20px 0;
            color: #31708f;
            background-color: #d9edf7;
            border: 1px solid #bce8f1;
            border-radius: 4px;
            padding: 15px;
        }

        .no-results-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
            width: 100%;
        }
    </style>
</head>

<body>

<div class="container-fluid mt-3">

    <div class="row">
        <!-- Filter Section -->
        <div class="col-md-3">
            <div class="p-3 border border-dark rounded filter-section">
                <form class="d-flex mb-3" action="/client/product/index" method="get">
                    <input class="form-control me-2" type="search" name="name" placeholder="Search" aria-label="Search"
                           value="${name}">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </form>

                <h5 class="mb-3">Sort</h5>
                <form action="/client/product/index" method="get">
                    <input type="hidden" name="keyword" value="${keyword}"/>
                    <input type="hidden" name="name" value="${name}"/>
                    <input type="hidden" name="categoryId" value="${categoryId}"/>

                    <select class="form-select mb-3" name="sort" onchange="this.form.submit()">
                        <option value="nameAsc" ${sort == 'nameAsc' ? 'selected' : ''}>Name: A to Z</option>
                        <option value="nameDesc" ${sort == 'nameDesc' ? 'selected' : ''}>Name: Z to A</option>
                        <option value="priceAsc" ${sort == 'priceAsc' ? 'selected' : ''}>Price: Low to High</option>
                        <option value="priceDesc" ${sort == 'priceDesc' ? 'selected' : ''}>Price: High to Low</option>
                    </select>

                    <h5 class="mb-3">Categories</h5>
                    <c:forEach var="cat" items="${category}">
                        <div class="form-check mb-2">
                            <input type="checkbox" name="categories" value="${cat.id}"
                                   class="form-check-input filter-checkbox"
                                   <c:if test="${selectedCategories != null && selectedCategories.contains(cat.id)}">checked</c:if>/>
                            <label class="form-check-label">${cat.name}</label>
                        </div>
                    </c:forEach>

                    <h5 class="mt-4">Price</h5>
                    <div class="mb-3">
                        <label for="min-price" class="form-label">Min</label>
                        <input type="number" class="form-control" id="min-price" name="minPrice" placeholder="Min"
                               value="${minPrice}">
                    </div>
                    <div class="mb-3">
                        <label for="max-price" class="form-label">Max</label>
                        <input type="number" class="form-control" id="max-price" name="maxPrice" placeholder="Max"
                               value="${maxPrice}">
                    </div>
                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary">Apply</button>
                        <button type="button" class="btn btn-secondary" onclick="clearFilters()">Clear</button>
                    </div>
                </form>
            </div>

        </div>

        <!-- Product Section -->
        <div class="col-md-9">
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 row-cols-xl-4 g-4">
                <c:if test="${not empty noResultsMessage}">
                    <div class="no-results-container">
                        <div class="no-results-message">${noResultsMessage}</div>
                    </div>
                </c:if>
                <c:forEach var="p" items="${product.content}">
                    <div class="col-md-4">
                        <div class="card position-relative product-card">
                            <a href="/client/product/edit/${p.id}">
                                <img src="/img/${p.image}" class="card-img-top img-fluid product-image"
                                     alt="Product Image">
                            </a>
                            <div class="category-label">${p.categoryId.name}</div>
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title">${p.name}</h5>
                                <h6 class="card-subtitle mb-2 text-muted product-price mt-1">$${p.price}</h6>
                                <div class="product-description mb-2 mt-1">
                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent et sapien ut eros.
                                </div>
                                <button onclick="addToCart(${p.id})" class="btn btn-primary btn-sm mt-auto">Add to
                                    Cart
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <%--phan trang--%>
            <div class="d-flex justify-content-center align-items-center mt-5">
                <nav aria-label="Page navigation example">
                    <ul class="pagination">
                        <li class="page-item">
                            <a class="page-link"
                               href="/client/product/index?page=0&keyword=${keyword}&name=${name}&sort=${sort}&categoryId=${categoryId}&minPrice=${minPrice}&maxPrice=${maxPrice}">
                                First
                            </a>
                        </li>
                        <c:if test="${product.number > 0}">
                            <li class="page-item">
                                <a class="page-link"
                                   href="/client/product/index?page=${product.number - 1}&keyword=${keyword}&name=${name}&sort=${sort}&categoryId=${categoryId}&minPrice=${minPrice}&maxPrice=${maxPrice}">
                                    Previous
                                </a>
                            </li>
                        </c:if>
                        <li class="page-item"><a class="page-link">${product.number}</a></li>
                        <c:if test="${product.number < product.totalPages - 1}">
                            <li class="page-item">
                                <a class="page-link"
                                   href="/client/product/index?page=${product.number + 1}&keyword=${keyword}&name=${name}&sort=${sort}&categoryId=${categoryId}&minPrice=${minPrice}&maxPrice=${maxPrice}">
                                    Next
                                </a>
                            </li>
                        </c:if>
                        <li class="page-item">
                            <a class="page-link"
                               href="/client/product/index?page=${product.totalPages - 1}&keyword=${keyword}&name=${name}&sort=${sort}&categoryId=${categoryId}&minPrice=${minPrice}&maxPrice=${maxPrice}">
                                Last
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    function encodeCategories() {
        const checkboxes = document.querySelectorAll('.filter-checkbox');
        let categories = [];
        checkboxes.forEach(checkbox => {
            if (checkbox.checked) {
                categories.push(checkbox.value);
            }
        });
        return encodeURIComponent(categories.join(','));
    }

    document.querySelector('form[action="/client/product/index"]').addEventListener('submit', function (event) {
        event.preventDefault();  // Prevent the form from submitting normally
        const categoriesParam = encodeCategories();
        const action = this.getAttribute('action');
        const params = new URLSearchParams(new FormData(this));
        params.set('categories', categoriesParam);  // Properly set the encoded categories
        window.location.href = `${action}?${params.toString()}`;  // Redirect with the properly encoded URL
    });

    function addToCart(productId) {
        fetch('/client/add/cart/' + productId, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            }
        }).then(response => {
            if (response.ok) {
                // Notify user of successful addition to cart
                swal("Success", "Item added to cart successfully!", "success").then(() => {
                    // Optionally redirect after notification
                    window.location.href = '/client/product/index';
                });
            } else {
                // Notify user of error
                swal("Error", "Unable to add item to cart", "error");
            }
        }).catch(error => {
            // Notify user if there's a network or other error
            swal("Error", "An unexpected error occurred", "error");
        });
    }

    function clearFilters() {
        const checkboxes = document.querySelectorAll('.filter-checkbox');
        checkboxes.forEach(checkbox => checkbox.checked = false);
        document.getElementById('min-price').value = '';
        document.getElementById('max-price').value = '';
        document.querySelector('form[action="/client/product/index"]').submit();
    }
</script>
</html>
