<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Product Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <style>
        .product-image {
            max-height: 400px;
            object-fit: cover;
            border: 5px solid #e4eadb;
            border-radius: 10px;
            padding: 10px;
            background-color: #fff;
        }
        .product-details {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
        }
        .product-details h3 {
            color: #007bff;
        }
        .product-price {
            color: #28a745;
            font-size: 1.5rem;
        }
        .product-category {
            font-size: 1.2rem;
            color: #6db6f8;
        }
        .description-expand {
            max-height: 150px;
            overflow: hidden;
            position: relative;
        }
        .description-expand.expanded {
            max-height: none;
        }
        .show-more {
            cursor: pointer;
            color: blue;
        }
        .icon {
            font-size: 1.2rem;
            margin-right: 5px;
        }
        .rating {
            color: #ffc107;
        }
        .color-picker {
            margin-top: 10px;
        }
        .color-option {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            margin-right: 5px;
            cursor: pointer;
            border: 2px solid #ddd; /* Border around color options */
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5 d-flex justify-content-center">
            <img src="/img/${product.image}" class="img-fluid product-image" alt="Product Image">
        </div>
        <div class="col-md-5 product-details">
            <h3>${product.name}</h3>
            <p class="product-price"><strong>Price:</strong> $${product.price}</p>
            <p class="product-category"><strong>Category:</strong> ${product.categoryId.name}</p>
            <p><strong>Description:</strong></p>
            <%--            <div class="description-expand">--%>
            <%--                ${product.description}--%>
            <%--                <button class="show-more">Show more</button>--%>
            <%--            </div>--%>
            <div class="d-flex gap-2 align-items-center color-picker">
                <span class="icon">Color:</span>
                <div class="color-option" style="background-color: #000;"></div>
                <div class="color-option" style="background-color: #fff;"></div>
                <div class="color-option" style="background-color: #ff0000;"></div>
                <div class="color-option" style="background-color: #00ff00;"></div>
                <div class="color-option" style="background-color: #0000ff;"></div>
            </div>
            <div class="d-flex align-items-center mt-3">
                <span class="icon rating">★</span>
                <span>4.5 (200 reviews)</span>
            </div>
            <div class="d-flex gap-2 mt-3">
                <button onclick="addToCart(${product.id})" class="btn btn-primary btn-add-to-cart">Add to cart</button>
                <button onclick="buyNow(${product.id})" class="btn btn-warning">Buy Now</button>
                <a class="btn btn-outline-danger" href="/client/product/index">Cancel</a>
            </div>
        </div>
    </div>
</div>
<script>
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
                    window.location.href = '/client/product/edit/'+ ${product.id};
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
</script>
</body>
</html>
