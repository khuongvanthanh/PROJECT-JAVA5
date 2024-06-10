<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center">Cart Details</h2>
    <c:if test="${not empty message}">
        <div class="alert alert-warning" role="alert">
                ${message}
        </div>
    </c:if>
    <table class="table table-striped mt-4">
        <thead class="thead-dark">
        <tr>
            <th scope="col">Product</th>
            <th scope="col">Price</th>
            <th scope="col">Quantity</th>
            <th scope="col">Total</th>
            <th scope="col"></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${cart.items}">
            <form action="/client/update-cart/${item.productId.id}" method="post">
                <input type="hidden" name="id" value="${item.productId.id}">
                <tr>
                    <td>${item.productId.name}</td>
                    <td>$${item.price}</td>
                    <td style="width: 120px;">
                        <input type="number" class="form-control form-control-sm" min="1" name="quantity" value="${item.quantity}" onchange="this.form.submit()">
                    </td>
                    <td>$${item.price * item.quantity}</td>
                    <td>
                        <a class="btn btn-sm btn-danger" href="/client/remove-cart/${item.productId.id}">Remove</a>
                    </td>
                </tr>
            </form>
        </c:forEach>
        </tbody>
    </table>
    <div class="my-3 text-end">
        <h4>Total Amount: <span class="text-success">$${cart.amount}</span></h4>
    </div>
    <div class="d-flex justify-content-between">
        <a class="btn btn-secondary" href="/client/product/index">Continue Shopping</a>
        <c:choose>
            <c:when test="${cart.items != null && !cart.items.isEmpty()}">
                <form id="checkoutForm" action="/client/content/checkout" method="get">
                    <button id="checkoutButton" type="submit" class="btn btn-primary">Checkout</button>
                </form>
            </c:when>
            <c:otherwise>
                <button class="btn btn-primary" disabled>Checkout</button>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>
