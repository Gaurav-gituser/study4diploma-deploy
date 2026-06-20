<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Add Category</title>
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
    rel="stylesheet"
  >
</head>
<body>
  <div class="container my-5">
    <div class="card mx-auto" style="max-width: 500px;">
      <div class="card-body">
        <h3 class="card-title text-center mb-4">Insert Category</h3>

          <form action="../CategoryController" method="post">
          
          
          
        
          <div class="form-group">
            <label for="categoryName">Category Name</label>
            <input
              type="text"
              class="form-control"
              id="categoryName"
              name="categoryName"
              placeholder="Enter category name"
              required
            >
            <div class="invalid-feedback">
              Please enter a category name.
            </div>
          </div>

          <div class="form-group">
            <label for="description">Description (optional)</label>
            <textarea
              class="form-control"
              id="description"
              name="description"
              rows="3"
              placeholder="Enter description"
            ></textarea>
          </div>

     <button type="submit" value="insert" name="btn">Submit</button>
    </form>
</body>
</body>
</html>