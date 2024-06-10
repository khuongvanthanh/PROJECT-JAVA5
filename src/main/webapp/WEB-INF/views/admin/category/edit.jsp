<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Edit Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="../app/style.css">
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <%--    <script>--%>
    <%--        function handleUpdate() {--%>
    <%--            swal({--%>
    <%--                title: "Are you sure?",--%>
    <%--                text: "Do you want to update this product?",--%>
    <%--                icon: "warning",--%>
    <%--                buttons: ["Cancel", "OK"],--%>
    <%--                dangerMode: true,--%>
    <%--            }).then((willUpdate) => {--%>
    <%--                if (willUpdate) {--%>
    <%--                    document.getElementById("updateForm").submit();--%>
    <%--                }--%>
    <%--            });--%>
    <%--        }--%>
    <%--    </script>--%>
</head>
<body>


<div class="container mt-5 w-75">
    <h3 class="text-center mt-3" style="margin-right: 300px">Edit Category</h3>
    <div class="row mt-5">
        <div class="col-md-8">
            <form:form id="updateForm" method="post" action="/admin/category/update?id=${category.id}"
                       modelAttribute="category" enctype="multipart/form-data">

                <div class="mb-3 row">
                    <label for="name" class="col-sm-2 col-form-label form-label">Name:</label>
                    <div class="col-sm-10">
                        <form:input path="name" cssClass="form-control" id="name"/>
                        <form:errors path="name" cssStyle="color: red"/>
                    </div>
                </div>
                <div class="row text-center">
                    <div class="col-sm-12">
                            <%--                        onclick="handleUpdate()"--%>
                        <button type="submit" class="btn btn-outline-primary">Save</button>
                        <a href="/admin/category/index" class="btn btn-outline-danger">Cancel</a>
                    </div>
                </div>
            </form:form>
        </div>
    </div>
</div>
</body>
</html>
