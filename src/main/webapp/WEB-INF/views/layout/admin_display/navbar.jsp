<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        body {
            display: flex;
        }

        .sidebar {
            width: 250px;
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            background-color: darkgray;
            color: white;
            padding-top: 20px;
        }

        .sidebar a {
            color: white;
            text-decoration: none;
        }

        .sidebar .nav-item {
            padding: 15px;
        }

        .profile {
            display: flex;
            justify-content: center;
            margin-right: 50px;
            margin-bottom: 20px;
        }

        .profile img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
        }

        .logout-icon {
            margin-top: auto;
        }

        /* Thêm code mới */
        .logout-icon .nav-link {
            padding: 10px; /* Tùy chỉnh padding để căn giữa với sidebar */
        }
    </style>
</head>
<body>
<div class="sidebar">
    <div class="profile">
        <img src="<c:url value="/img/charizard.jpg"/>" alt="Profile Image">
    </div>
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link" href="#products" data-bs-toggle="collapse" aria-expanded="false"
               aria-controls="products">
                <i class="fas fa-box"></i> Products
            </a>
            <ul class="collapse list-unstyled" id="products">
                <li class="nav-item"><a class="nav-link" href="/admin/product/index">List Product</a></li>
                <li class="nav-item"><a class="nav-link" href="/admin/product/add">Add Product</a></li>
            </ul>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#categories" data-bs-toggle="collapse" aria-expanded="false"
               aria-controls="categories">
                <i class="fas fa-tags"></i> Category
            </a>
            <ul class="collapse list-unstyled" id="categories">
                <li class="nav-item"><a class="nav-link" href="/admin/category/index">List Category</a></li>
                <li class="nav-item"><a class="nav-link" href="/admin/category/add">Add Category</a></li>
            </ul>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#users" data-bs-toggle="collapse" aria-expanded="false" aria-controls="users">
                <i class="fas fa-users"></i> User
            </a>
            <ul class="collapse list-unstyled" id="users">
                <li class="nav-item"><a class="nav-link" href="/admin/account/index">List User</a></li>
                <li class="nav-item"><a class="nav-link" href="/admin/account/add">Add User</a></li>
            </ul>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#orders" data-bs-toggle="collapse" aria-expanded="false" aria-controls="orders">
                <i class="fas fa-shopping-cart"></i> Order
            </a>
            <ul class="collapse list-unstyled" id="orders">
                <li class="nav-item"><a class="nav-link" href="/admin/order/index?keyword=&firstDate=&lastDate=">Order Detail</a></li>
            </ul>
        </li>
        <li class="nav-item logout-icon "><a class="nav-link" href="/"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </li>
    </ul>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-sVFdMybS9Xv6ydFH99o2e8G6+GVWeXWHe2j2o2Us65VQlQpbnoDraD+f5OoJwNIQ"
        crossorigin="anonymous"></script>
</body>
</html>
