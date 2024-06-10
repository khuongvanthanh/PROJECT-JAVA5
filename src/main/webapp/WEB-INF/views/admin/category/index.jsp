<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Category Manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body class="container mt-5 w-30">
<div class="d-flex justify-content-between align-items-center">
    <h3 class="text-center">Category Manager</h3>
    <a href="/admin/category/add" class="btn btn-outline-success">Create new</a>
</div>
<hr>
<div>
    <form id="searchForm" action="/admin/category/index" class="d-flex justify-content-end mb-5">
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
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" onclick="closeAlert()"></button>
    </div>
</c:if>
<c:if test="${not empty errorMessage}">
    <div id="errorAlert" class="alert alert-danger alert-dismissible fade show" role="alert">
            ${errorMessage}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" onclick="closeAlert('errorAlert')"></button>
    </div>
</c:if>

<!-- Bảng thông tin sản phẩm -->
<table class="table mb-3 table-bordered" style="border: black">
    <thead>
    <tr class="text-center">
        <th scope="col">ID</th>
        <th scope="col">Name</th>
        <th scope="col">Activity</th>
    </tr>
    </thead>
    <tbody class="text-center">
    <c:forEach items="${category.content}" var="c">
        <tr>
            <th scope="row" class="align-middle">${c.id}</th>
            <th scope="row" class="align-middle">${c.name}</th>
            <td class="align-middle">
                <a href="/admin/category/edit/${c.id}" class="btn btn-outline-warning">Edit</a>
                <a onclick="handleDelete(${c.id})" class="btn btn-outline-danger">Delete</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<!-- Phân trang -->
<div class="d-flex justify-content-center align-items-center">
    <nav aria-label="Page navigation example">
        <ul class="pagination">
            <li class="page-item"><a class="page-link" href="/admin/category/index?page=0&keyword=${keyword}">First</a>
            </li>
            <c:if test="${category.number > 0}">
                <li class="page-item"><a class="page-link"
                                         href="/admin/category/index?page=${category.number - 1}&keyword=${keyword}">Previous</a>
                </li>
            </c:if>
            <li class="page-item"><a class="page-link">${category.number}</a></li>
            <c:if test="${category.number < category.totalPages - 1}">
                <li class="page-item"><a class="page-link"
                                         href="/admin/category/index?page=${category.number + 1}&keyword=${keyword}">Next</a>
                </li>
            </c:if>
            <li class="page-item"><a class="page-link"
                                     href="/admin/category/index?page=${category.totalPages - 1}&keyword=${keyword}">Last</a>
            </li>
        </ul>
    </nav>
</div>

<script>
    const handleDelete = (id) => {
        swal({
            title: "Are you sure?",
            text: "Do you want to delete this category?",
            icon: "error",
            buttons: ["Cancel", "OK"],
            dangerMode: true,
        })
            .then((willDelete) => {
                if (willDelete) {
                    window.location.href = "/admin/category/delete/" + id;
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
    function closeAlert(alertId) {
        const alertElement = document.getElementById(alertId);
        if (alertElement) {
            alertElement.style.display = "none";
        }
    }
</script>

</body>
</html>
