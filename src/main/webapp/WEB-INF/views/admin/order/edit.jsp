<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Invoice</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }

        .invoice-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        h1, h2 {
            text-align: center;
            color: #343a40;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #dee2e6;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f8f9fa;
            color: #343a40;
            font-weight: bold;
        }

        .total-row {
            font-weight: bold;
            background-color: #dee2e6;
        }
    </style>
</head>
<body>
<div class="invoice-container">
    <h1>Order Details</h1>
    <div class="mt-5">
        <p><strong>Order ID:</strong> ${order.id}</p>
        <p><strong>Order Date:</strong> ${order.createdate}</p>
        <p><strong>Customer:</strong> ${order.username.username}</p>
    </div>
    <div>
        <h2>Order Items</h2>
        <table>
            <thead>
            <tr>
                <th>Product</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Total</th>
            </tr>
            </thead>
            <tbody>
            <c:set var="totalAmount" value="0"/>
            <c:forEach var="item" items="${orderDetails}">
                <tr>
                    <td><c:out value="${item.productId.name}"/></td>
                    <td><c:out value="${item.quantity}"/></td>
                    <td><c:out value="${item.price}"/></td>
                    <td><c:out value="${item.price * item.quantity}"/></td>
                    <c:set var="totalAmount" value="${totalAmount + (item.price * item.quantity)}"/>
                </tr>
            </c:forEach>
            <tr class="total-row">
                <td colspan="3" style="text-align: right;">Total:</td>
                <td>${totalAmount}</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
<div class="text-center mt-3">
    <a href="/admin/order/index?keyword=&firstDate=&lastDate=" class="btn btn-outline-danger">Cancel</a>
</div>

</body>
</html>
