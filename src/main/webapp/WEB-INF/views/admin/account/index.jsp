<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Account Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body class="container mt-5 w-30">
<div class="d-flex justify-content-between align-items-center">
    <h2 class="text-center">Account Manager</h2>
    <a href="/admin/account/add" class="btn btn-outline-success">Create new</a>
</div>
<hr>
<div>
    <form id="searchForm" action="/admin/account/index" class="d-flex justify-content-end mb-5">
        <div class="input-group w-50">
            <input id="searchInput" type="text" class="form-control" name="keyword" placeholder="Search"
                   aria-label="Search"
                   aria-describedby="basic-addon1" value="${keyword}">
            <span class="input-group-text" id="basic-addon1" onclick="search()"><i class="bi bi-search"></i></span>
        </div>
    </form>
</div>

<!-- Thông báo -->
<c:if test="${not empty message}">
    <div id="successAlert" class="alert alert-success alert-dismissible fade show" role="alert">
            ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"
                onclick="closeAlert()"></button>
    </div>
</c:if>

<!-- Bảng thông tin sản phẩm -->
<table class="table mb-3 table-bordered" style="border: black">
    <thead>
    <tr class="text-center">
        <th scope="col">Username</th>
        <th scope="col">Password</th>
        <th scope="col">FullName</th>
        <th scope="col">Email</th>
        <th scope="col">Photo</th>
        <th scope="col">Activated</th>
        <th scope="col">Admin</th>
        <th scope="col">Activity</th>
    </tr>
    </thead>
    <tbody class="text-center">
    <c:forEach items="${accounts.content}" var="a">
        <tr>
            <th scope="row" class="align-middle">${a.username}</th>
            <td class="align-middle">${a.password}</td>
            <td class="align-middle">${a.fullname}</td>
            <td class="align-middle">${a.email}</td>
            <td class="align-middle"><img src="/img/${a.photo}" class="rounded mx-auto d-block image-table-account"
                                          alt="" width="50ax"></td>
            <td class="align-middle">${a.activated == 1? '<i class="bi bi-check2 text-success"></i>' : '<i class="bi bi-x-lg text-danger"></i>'}</td>
            <td class="align-middle">${a.admin == 1? '<i class="bi bi-check2 text-success"></i>' : '<i class="bi bi-x-lg text-danger"></i>'}</td>
            <td class="align-middle">
                <a href="/admin/account/edit/${a.username}" class="btn btn-outline-warning">Edit</a>
                <a onclick="onDelete('${a.username}')" class="btn btn-outline-danger">Delete</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<!-- Phân trang -->
<div class="d-flex justify-content-center align-items-center">
    <nav aria-label="Page navigation example">
        <ul class="pagination">
            <li class="page-item"><a class="page-link" href="/admin/account/index?page=0&keyword=${keyword}">First</a></li>
            <c:if test="${accounts.number > 0}">
                <li class="page-item"><a class="page-link" href="/admin/account/index?page=${accounts.number - 1}&keyword=${keyword}">Previous</a></li>
            </c:if>
            <li class="page-item"><a class="page-link">${accounts.number}</a></li>
            <c:if test="${accounts.number < accounts.totalPages - 1}">
                <li class="page-item"><a class="page-link" href="/admin/account/index?page=${accounts.number + 1}&keyword=${keyword}">Next</a></li>
            </c:if>
            <li class="page-item"><a class="page-link" href="/admin/account/index?page=${accounts.totalPages - 1}&keyword=${keyword}">Last</a></li>
        </ul>
    </nav>
</div>

<script>
    const onDelete = (username) => {
        swal({
            title: "Are you sure?",
            text: "Do you want to delete this account?",
            icon: "error",
            buttons: ["Cancel", "OK"],
            dangerMode: true,
        })
            .then((willDelete) => {
                if (willDelete) {
                    window.location.href = "/admin/account/delete/" + username;
                }
            });
    }

    function search() {
        document.getElementById("searchForm").submit();
    }

    function closeAlert() {
        const alertDiv = document.getElementById("successAlert");
        alertDiv.style.display = "none";
    }
</script>

</body>
</html>