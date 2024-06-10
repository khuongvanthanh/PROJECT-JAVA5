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
    <style>
        .form-label {
            font-weight: bold;
        }

        .image-preview {
            max-width: 100%;
            height: 300px;
            margin-top: -20px;
        }
    </style>
    <script>
        function previewImage(event) {
            const reader = new FileReader();
            reader.onload = function () {
                const output = document.getElementById('imagePreview');
                output.src = reader.result;
                output.style.display = 'block';
            };
            reader.readAsDataURL(event.target.files[0]);
        }

        function handleUpdate() {
            swal({
                title: "Are you sure?",
                text: "Do you want to update this product?",
                icon: "warning",
                buttons: ["Cancel", "OK"],
                dangerMode: true,
            }).then((willUpdate) => {
                if (willUpdate) {
                    document.getElementById("updateForm").submit();
                }
            });
        }
    </script>
</head>
<body>
<div class="container mt-5 w-30">
    <h3 class="text-center mt-3" style="margin-right: 300px">Edit Product</h3>
    <div class="row mt-5">
        <div class="col-md-8">
            <form:form id="updateForm" method="post" action="/admin/product/update?id=${product.id}"
                       modelAttribute="product" enctype="multipart/form-data">
                <div class="mb-3 row">
                    <label for="categoryId" class="col-sm-2 col-form-label form-label">Category:</label>
                    <div class="col-sm-10">
                        <form:select path="categoryId" cssClass="form-select">
                            <option value="" selected>Please select a category</option>
                            <form:options items="${category}" itemValue="id" itemLabel="name"/>
                        </form:select>
                        <form:errors path="categoryId" cssClass="text-danger" element="label"/>
                    </div>
                </div>

                <div class="mb-3 row" style="display: none">
                    <label for="name" class="col-sm-2 col-form-label form-label">Create Date:</label>
                    <div class="col-sm-10">
                        <form:input path="createdate" type="date" cssClass="form-control" />
                    </div>
                </div>

                <div class="mb-3 row">
                    <label for="name" class="col-sm-2 col-form-label form-label">Name:</label>
                    <div class="col-sm-10">
                        <form:input path="name" cssClass="form-control" id="name"/>
                        <form:errors path="name" cssStyle="color: red"/>
                    </div>
                </div>

                <div class="mb-3 row">
                    <label for="price" class="col-sm-2 col-form-label form-label">Price:</label>
                    <div class="col-sm-10">
                        <form:input path="price" cssClass="form-control" id="price"/>
                        <form:errors path="price" cssStyle="color: red"/>
                    </div>
                </div>

                <div class="mb-3 row">
                    <label class="col-sm-2 col-form-label form-label">Images:</label>
                    <div class="col-sm-10">
                        <input name="fileImage" type="file" class="mt-2 form-control" onchange="previewImage(event)"/>
                        <form:errors path="image" cssClass="text-danger" element="label"/>
                        <form:hidden path="image" id="currentImage" value="${product.image}"/>
                    </div>
                </div>

                <div class="mb-3 row">
                    <label class="col-sm-2 col-form-label form-label">Available:</label>
                    <div class="col-sm-10">
                        <div class="form-check">
                            <form:checkbox path="available" cssClass="form-check-input mt-2" value="1"/>
                        </div>
                    </div>
                </div>

                <div class="row text-center">
                    <div class="col-sm-12">
                        <button type="button" class="btn btn-outline-primary" onclick="handleUpdate()">Save</button>
                        <a href="/admin/product/index" class="btn btn-outline-danger">Cancel</a>
                    </div>
                </div>
            </form:form>
        </div>
        <div class="col-md-4">
            <img id="imagePreview" class="image-preview" src="/img/${product.image}" alt="Image Preview"/>
        </div>
    </div>
</div>
</body>
</html>
