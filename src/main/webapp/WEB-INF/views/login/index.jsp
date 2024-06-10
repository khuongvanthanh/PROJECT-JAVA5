<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .bg-login {
            background-color: #f8f9fa;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-form {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 350px;
            max-width: 90%;
        }

        .login-form h3 {
            font-weight: 600;
            margin-bottom: 30px;
            text-align: center;
            color: #007bff;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-control {
            border-radius: 5px;
        }

        .btn-primary, .btn-secondary {
            border-radius: 5px;
            padding: 10px 20px;
            width: 100%;
            text-transform: uppercase;
            font-weight: 600;
        }

        .btn-primary {
            background-color: #007bff;
            border: none;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-secondary {
            background-color: #6c757d;
            border: none;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        #error {
            color: red;
            margin-top: 10px;
            text-align: center;
        }

        .text-center {
            text-align: center;
        }

        .mt-4 {
            margin-top: 1.5rem;
        }

        .register-link {
            color: #007bff;
            text-decoration: none;
        }

        .register-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="bg-login">
    <div class="login-form">
        <h3>Đăng nhập</h3>
        <form action="/account" method="POST">
            <div class="form-group">
                <label for="username">Tên tài khoản</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <div id="error">${message}</div>
            <button type="submit" class="btn btn-primary">Đăng nhập</button>
            <a href="client/product/index" class="btn btn-secondary mt-3">Đăng nhập bằng tài khoản khách</a>
        </form>
        <p class="text-center mt-4">Chưa có tài khoản? <a href="#" class="register-link">Đăng ký ngay</a></p>
    </div>
</div>
</body>
</html>
