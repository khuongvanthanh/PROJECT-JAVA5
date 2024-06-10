<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <style>
        .form-label {
            font-weight: bold;
        }

        .image-preview {
            max-width: 100%;
            height: auto;
            display: none;
            margin-top: 15px;
        }

        .container {
            max-width: 800px;
            margin-top: 50px;
        }

        .image-upload {
            margin-top: 10px;
        }

        .image-frame {
            padding: 10px;
            border-radius: 5px;
            height: 330px;
            background-size: cover;
            background-position: center;
            margin-top: 30px;
        }
    </style>
    <script>
        function previewImage(event) {
            const reader = new FileReader();
            reader.onload = function () {
                const output = document.getElementById('imagePreview');
                output.src = reader.result;
                output.style.display = 'block'; // Show the image
            };
            reader.readAsDataURL(event.target.files[0]);
        }

        function handleSave() {
            swal({
                title: "Are you sure?",
                text: "Do you want to save this product?",
                icon: "success",
                buttons: ["Cancel", "OK"],
                dangerMode: true,
            }).then((willSave) => {
                if (willSave) {
                    document.getElementById("addProductForm").submit();
                }
            });
        }

        document.addEventListener("DOMContentLoaded", function () {
            const base64Image = '<c:out value="${imagePreview}" />';
            if (base64Image && base64Image.trim() !== '') {
                const output = document.getElementById('imagePreview');
                output.src = 'data:image/jpeg;base64,' + base64Image;
                output.style.display = 'block'; // Show the image
            }
        });
    </script>
</head>
<body>

<div class="container mt-5 w-30">
    <h3 class="text-center mt-3" style="margin-right: 300px">Add Product</h3>

    <div class="row mt-5">
        <!-- Form Column -->
        <div class="col-md-8">
            <form:form id="addProductForm" method="post" action="/admin/product/store" enctype="multipart/form-data"
                       modelAttribute="product">
                <div class="mb-3">
                    <label class="form-label">Category:</label>
                    <form:select path="categoryId" cssClass="form-select">
                        <option value="" selected>Please select a category</option>
                        <form:options items="${category}" itemValue="id" itemLabel="name"/>
                    </form:select>
                    <form:errors path="categoryId" cssClass="text-danger" element="label"/>
                </div>

                <div class="mb-3">
                    <label for="name" class="form-label">Name:</label>
                    <form:input path="name" cssClass="form-control" id="name"/>
                    <form:errors path="name" cssClass="text-danger" element="div"/>
                </div>

                <div class="mb-3">
                    <label for="price" class="form-label">Price:</label>
                    <form:input path="price" cssClass="form-control" id="price"/>
                    <form:errors path="price" cssClass="text-danger" element="div"/>
                </div>

                <div class="mb-3 image-upload">
                    <label class="form-label">Images:</label>
                    <input name="fileImage" type="file" class="form-control" onchange="previewImage(event)"/>
                    <form:errors path="image" cssClass="text-danger" element="div"/>
                </div>

                <div class="mb-3">
                    <div>
                        <label class="form-label me-2">Available:</label>
                        <form:checkbox path="available" cssClass="form-check-input" value="1"/>
                    </div>
                </div>

                <div class="text-center">
                    <button type="button" class="btn btn-outline-primary" onclick="handleSave()">Save</button>
                    <a href="/admin/product/index" class="btn btn-outline-danger">Cancel</a>
                </div>
            </form:form>
        </div>

        <!-- Image Preview Column -->
        <div class="col-md-4">
            <div class="text-center image-frame" id="imageFrame">
                <img id="imagePreview" class="image-preview" alt="Image Preview" src=""/>
            </div>
        </div>
    </div>
</div>

</body>
</html>
