<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Scheme Entry Form</title>

    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .form-container {
            max-width: 500px;
            margin: 100px auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .form-label {
            font-weight: 600;
        }

        .btn-submit {
            width: 100%;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="form-container">
        <h3 class="text-center mb-4">Add New Scheme</h3>

        <form action="../SchemeController" method="post">
            <div class="mb-3">
                <label for="schemeName" class="form-label">Enter a Scheme Name</label>
                <input type="text" class="form-control" id="schemeName" name="SchemeName" placeholder="e.g., Health Insurance">
            </div>

            <button type="submit" class="btn btn-primary btn-submit" name="btn" value="insert">Submit</button>
        </form>
    </div>
</div>

<!-- Bootstrap JS CDN (optional, for interactivity) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
