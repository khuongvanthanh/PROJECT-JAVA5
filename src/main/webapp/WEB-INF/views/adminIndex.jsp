<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh; /* Đảm bảo video container căn giữa theo chiều dọc */
        }
        .main-content {
            margin-left: 250px;
            padding: 20px;
            width: 100%;
        }
        .video-container {
            display: none;
            text-align: center;
        }
        .video-frame {
            width: 1000px; /* Độ rộng mong muốn của video */
            height: 550px; /* Độ cao mong muốn của video */
        }
    </style>
</head>
<body>
<div class="main-content">
    <jsp:include page="layout/admin_display/navbar.jsp"/>
    <jsp:include page="admin/index.jsp"/>
</div>
<div class="video-container" id="videoContainer">
    <iframe style="margin-left: -1400px" class="video-frame" src="https://www.youtube.com/embed/FKMOEha8Lzo?si=cPX4P3YfqKOdppbg" allowfullscreen></iframe>
</div>

<script>
    var currentURL = window.location.href;

    // Kiểm tra nếu đường dẫn chính xác là 'http://localhost:8080/admin'
    if (currentURL === "http://localhost:8080/admin") {
        // Hiển thị video container
        document.getElementById("videoContainer").style.display = "block";
    } else {
        // Nếu không chứa đường dẫn chính xác này, ẩn video container
        document.getElementById("videoContainer").style.display = "none";
    }
</script>

</body>
</html>
