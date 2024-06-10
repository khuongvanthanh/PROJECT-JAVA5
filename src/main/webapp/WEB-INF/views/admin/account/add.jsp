<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Edit Account</title>
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
            height: auto;
        }
    </style>
    <script>
        // function handleSave() {
        //     swal({
        //         title: "Are you sure?",
        //         text: "Do you want to save this account?",
        //         icon: "success",
        //         buttons: ["Cancel", "OK"],
        //         dangerMode: true,
        //     }).then((willSave) => {
        //         if (willSave) {
        //             document.getElementById("addAccountForm").submit();
        //         }
        //     });
        // }

        function previewImage(event) {
            const output = document.getElementById('imagePreview');
            output.src = URL.createObjectURL(event.target.files[0]);
            output.style.display = 'block'; // Show the image
        }

        document.addEventListener("DOMContentLoaded", function () {
            const base64Image = '<c:out value="${imagePreview}" />';
            if (base64Image) {
                const output = document.getElementById('imagePreview');
                output.src = 'data:image/jpeg;base64,' + base64Image;
                output.style.display = 'block'; // Show the image
            }
        });
    </script>
</head>
<body>

<div class="container mt-5 w-30">
    <h3 class="text-center mt-3" style="margin-right: 300px">Add Account</h3>
    <div class="row mt-3">
        <div class="col-md-8">
            <form:form id="addAccountForm" method="post" action="/admin/account/store" modelAttribute="account"
                       enctype="multipart/form-data">

                <div class="mb-3 row">
                    <label for="username" class="col-sm-2 col-form-label form-label">Username:</label>
                    <div class="col-sm-10">
                        <form:input path="username" cssClass="form-control" id="username"/>
                        <form:errors path="username" cssStyle="color: red"/>
                    </div>
                </div>

                <div class="mb-3 row">
                    <label for="password" class="col-sm-2 col-form-label form-label">Password:</label>
                    <div class="col-sm-10">
                        <form:input path="password" cssClass="form-control" id="password"/>
                        <form:errors path="password" cssStyle="color: red"/>
                    </div>
                </div>


                <div class="mb-3 row">
                    <label for="fullname" class="col-sm-2 col-form-label form-label">Fullname:</label>
                    <div class="col-sm-10">
                        <form:input path="fullname" cssClass="form-control" id="fullname"/>
                        <form:errors path="fullname" cssStyle="color: red"/>
                    </div>
                </div>

                <div class="mb-3 row">
                    <label for="email" class="col-sm-2 col-form-label form-label">Email:</label>
                    <div class="col-sm-10">
                        <form:input path="email" type="email" cssClass="form-control" id="email"/>
                        <form:errors path="email" cssStyle="color: red"/>
                    </div>
                </div>

                <div class="mb-3 row">
                    <label class="col-sm-2 col-form-label form-label">Images:</label>
                    <div class="col-sm-10">
                        <input name="fileImage" type="file" class="mt-2 form-control" onchange="previewImage(event)"/>
                        <form:errors path="photo" element="label" cssStyle="color: red"/>
                        <form:hidden path="photo" id="currentImage" value="${account.photo}"/>
                    </div>
                </div>

                <div class="mb-3 row">
                    <label class="col-sm-2 col-form-label form-label">Activated:</label>
                    <div class="col-sm-10">
                        <div class="form-check form-check-inline">
                            <form:radiobutton path="activated" cssClass="form-check-input mt-2" value="0"
                                              id="activatedInactive"/>
                            <label class="form-check-label" for="activatedInactive">Inactive</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <form:radiobutton path="activated" cssClass="form-check-input mt-2" value="1"
                                              id="activatedActive"/>
                            <label class="form-check-label" for="activatedActive">Activate</label>
                        </div>
                        <div class="invalid-feedback" style="display: block;">
                            <form:errors path="activated" cssStyle="color: red"/>
                        </div>
                    </div>
                </div>

                <div class="mb-3 row">
                    <label class="col-sm-2 col-form-label form-label">Admin:</label>
                    <div class="col-sm-10">
                        <div class="form-check">
                            <form:checkbox path="admin" cssClass="form-check-input mt-2" value="1"/>
                        </div>
                    </div>
                </div>

                <div class="row text-center">
                    <div class="col-sm-12">
                            <%--                        onclick="handleSave()"--%>
                        <button type="submit" class="btn btn-outline-primary">Save</button>
                        <a href="/admin/account/index" class="btn btn-outline-danger">Cancel</a>
                    </div>
                </div>
            </form:form>
        </div>
        <div class="col-md-4">
            <img id="imagePreview" class="image-preview" src="" alt="Image Preview"/>
        </div>
    </div>
</div>
</body>
</html>
