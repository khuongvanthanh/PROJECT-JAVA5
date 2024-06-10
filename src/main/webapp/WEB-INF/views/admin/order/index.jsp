<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script> <!-- Include SweetAlert library -->
</head>
<body>
<div class="container">
    <h2 class="my-4 text-center">Order List</h2>

    <form method="get" action="/admin/order/index" class="mb-4">
        <div class="row">
            <div class="col-md-3">
                <input type="text" name="keyword" class="form-control" placeholder="Search by keyword" value="${keyword}">
            </div>
            <div class="col-md-3">
                <input type="date" name="firstDate" class="form-control" placeholder="Start Date" value="${firstDate}">
            </div>
            <div class="col-md-3">
                <input type="date" name="lastDate" class="form-control" placeholder="End Date" value="${lastDate}">
            </div>
            <div class="col-md-3">
                <button type="submit" class="btn btn-primary">Search</button>
            </div>
        </div>
    </form>

    <table class="table table-striped text-center">
        <thead>
        <tr>
            <th>ID</th>
            <th>Address</th>
            <th>Create Date</th>
            <th>Username</th>
            <th>Activity</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${order.content}" var="o">
            <tr>
                <td>${o.id}</td>
                <td>${o.address}</td>
                <td>${o.createdate}</td>
                <td>${o.username.username}</td>
                <td>
                    <a href="/admin/order/edit/${o.id}" class="btn btn-outline-primary">View</a>
                    <!-- Use SweetAlert for confirmation -->
<%--                    <a href="#" class="btn btn-outline-danger" onclick="confirmDelete(${o.id})">Delete</a>--%>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="d-flex justify-content-center align-items-center">
        <nav aria-label="Page navigation example">
            <ul class="pagination">
                <li class="page-item"><a class="page-link" href="/admin/order/index?page=0&keyword=${keyword}&firstDate=${firstDate}&lastDate=${lastDate}">First</a></li>
                <c:if test="${order.number > 0}">
                    <li class="page-item"><a class="page-link" href="/admin/order/index?page=${order.number - 1}&keyword=${keyword}&firstDate=${firstDate}&lastDate=${lastDate}">Previous</a></li>
                </c:if>
                <li class="page-item"><a class="page-link">${order.number + 1}</a></li>
                <c:if test="${order.number < order.totalPages - 1}">
                    <li class="page-item"><a class="page-link" href="/admin/order/index?page=${order.number + 1}&keyword=${keyword}&firstDate=${firstDate}&lastDate=${lastDate}">Next</a></li>
                </c:if>
                <li class="page-item"><a class="page-link" href="/admin/order/index?page=${order.totalPages - 1}&keyword=${keyword}&firstDate=${firstDate}&lastDate=${lastDate}">Last</a></li>
            </ul>
        </nav>
    </div>
</div>

<script>
    function confirmDelete(orderId) {
        Swal.fire({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.isConfirmed) {
                // If confirmed, redirect to the delete URL
                window.location.href = '/admin/order/delete/' + orderId;
            }
        });
    }
</script>
</body>
</html>
