<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<%--    <script>--%>
<%--        function handleSave() {--%>
<%--            swal({--%>
<%--                title: "Are you sure?",--%>
<%--                text: "Do you want to save this product?",--%>
<%--                icon: "success",--%>
<%--                buttons: ["Cancel", "OK"],--%>
<%--                dangerMode: true,--%>
<%--            }).then((willSave) => {--%>
<%--                if (willSave) {--%>
<%--                    document.getElementById("addCategoryForm").submit();--%>
<%--                }--%>
<%--            });--%>
<%--        }--%>
<%--    </script>--%>
</head>
<body>

<div class="container mt-5 w-75">
    <h3 class="text-center mt-3" style="margin-right: 300px">Add Category</h3>
    <div class="row mt-5">
        <!-- Form Column -->
        <div class="col-md-8">
            <form:form id="addCategoryForm" method="post" action="/admin/category/store" enctype="multipart/form-data"
                       modelAttribute="category">
                <div class="mb-3">
                    <label for="name" class="form-label">Name:</label>
                    <form:input path="name" cssClass="form-control" id="name"/>
                    <form:errors path="name" cssClass="text-danger" element="div"/>
                </div>
                <div class="text-center">
<%--                    onclick="handleSave()"--%>
                    <button type="submit" class="btn btn-outline-primary" >Save</button>
                    <a href="/admin/category/index" class="btn btn-outline-danger">Cancel</a>
                </div>
            </form:form>
        </div>
    </div>
</div>

</body>
</html>
