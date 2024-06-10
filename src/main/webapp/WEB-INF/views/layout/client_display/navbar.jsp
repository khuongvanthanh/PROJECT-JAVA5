<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Navbar Client</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <style>
        .navbar-nav .nav-link {
            margin-right: 20px;
            font-size: 18px;
        }
        .navbar-brand img {
            width: 50px;
        }
        .rounded-circle {
            width: 40px;
            height: 40px;
        }
        .d-flex.align-items-center span {
            margin-left: 10px;
            font-size: 16px;
            font-weight: 500;
        }
        .navbar {
            background-color: #f8f9fa;
            padding: 10px 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .dropdown-menu {
            min-width: 100px;
            text-align: center;
        }
        .dropdown-toggle::after {
            display: none;
        }
        .position-relative .badge {
            position: absolute;
            top: -8px;
            right: -10px;
            background-color: red;
            color: white;
            border-radius: 50%;
            padding: 3px 7px;
            font-size: 12px;
        }
        .position-relative {
            display: flex;
            align-items: center;
        }
        .position-relative i {
            font-size: 24px;
            color: #0a7de6;
        }
        .position-relative span {
            position: absolute;
            top: -11px;
            right: -10px;
            background-color: red;
            color: white;
            border-radius: 80%;
            padding: 1px 8px;
            font-size: 12px;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="#"><img src="${pageContext.request.contextPath}/img/charizard.jpg" alt="Brand Logo"></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath}/client/product/index">Home</a>
                </li>
            </ul>
            <div class="d-flex align-items-center">
                <a href="${pageContext.request.contextPath}/client/product/cart" class="btn btn-outline-primary position-relative">
                    <i class="bi bi-cart4"></i>
                    <span>${cart.total}</span>
                </a>
                <c:if test="${not empty loggedInUser}">
                    <div class="dropdown ms-3">
                        <button class="btn btn-outline-primary dropdown-toggle d-flex align-items-center" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="${pageContext.request.contextPath}/img/${loggedInUser.photo}" alt="Profile Picture" class="rounded-circle">
                            <span>${loggedInUser.fullname}</span>
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/">Log out</a></li>
                        </ul>
                    </div>
                </c:if>
                <c:if test="${empty loggedInUser}">
                    <a href="${pageContext.request.contextPath}/" class="btn btn-outline-primary ms-3" type="button">Sign in</a>
                </c:if>
            </div>
        </div>
    </div>
</nav>

</body>
</html>
