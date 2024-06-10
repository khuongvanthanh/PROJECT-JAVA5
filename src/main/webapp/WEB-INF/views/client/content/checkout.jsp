<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center">Checkout</h2>
    <div class="table-responsive mt-4">
        <table class="table table-striped">
            <thead class="thead-dark">
            <tr>
                <th scope="col">Product</th>
                <th scope="col">Unit Price</th>
                <th scope="col">Quantity</th>
                <th scope="col">Total Price</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${cart.items}">
                <tr>
                    <td>${item.productId.name}</td>
                    <td>$${item.price}</td>
                    <td>${item.quantity}</td>
                    <td>$${item.price * item.quantity}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="my-3 text-end">
        <h4>Total Amount: <span class="text-success">$${cart.amount}</span></h4>
    </div>
    <div class="card mt-4">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">Order Information</h5>
        </div>
        <div class="card-body">
            <form method="POST" action="/client/checkout">
                <input type="hidden" name="username" value="${loggedInUser.username}">
                <div class="mb-3">
                    <label for="address" class="form-label">Delivery Address:</label>
                    <textarea class="form-control" id="address" name="address" rows="3" placeholder="Enter your delivery address" required></textarea>
                </div>
                <div class="d-flex justify-content-between">
                    <a href="/client/product/cart" class="btn btn-danger btn-lg">Cancel</a>
                    <button type="submit" class="btn btn-success btn-lg">Order</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.querySelector('form').addEventListener('submit', function (e) {
        e.preventDefault();
        swal({
            title: "Confirm Order",
            text: "Are you sure you want to place this order?",
            icon: "warning",
            buttons: true,
            dangerMode: true,
        }).then((willOrder) => {
            if (willOrder) {
                this.submit();
            }
        });
    });
</script>
</body>
</html>
