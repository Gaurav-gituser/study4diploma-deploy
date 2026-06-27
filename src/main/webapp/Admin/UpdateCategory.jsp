<%@page import="Dao.CategoryDao"%>
<%@page import="Model.Category"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    Model.User sessionUser = (Model.User) session.getAttribute("user");
    if (sessionUser == null || sessionUser.getRoleId().equalsIgnoreCase("rid_102")) {
        response.sendRedirect("../User/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="preconnect" href="https://cdn.jsdelivr.net">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</head>
<body>
<%
HttpSession session1=request.getSession();
CategoryDao dao2 = new CategoryDao();
ArrayList<Category> categorys = dao2.getAllCategorys();
/* for (Category category : categorys)
 {
 	out.println(category);
 	
 }
*/
 %>
 
 
 
 
<form action="./categoryInsert.jsp" >
<p class="text-end">
  <a href="./AdminPanel.jsp" class="btn btn-secondary me-2">← Back to Admin Panel</a>
  <a href="./categoryInsert.jsp" class="btn btn-dark">Add New Category</a>
</p></form>

<table class="mx-auto mt-3 table  table table-bordered data-table" id="data" >
<thead> <tr> <th scope="col">Category Name </th>  <th scope="col">Description </th>    <th scope="col">Edit/Delete </th>  </tr> </thead>

<tbody>

<%
if(categorys != null)
{
	for(Category category : categorys)
	{
	
%>
  
	<tr>
	<form action="../CategoryController" method="post" >
	  <td><input type="text" name="categoryName" disabled   class="w-100"  value="<%=category.getCategoryName()%>" > </td> 
	<td> <input type="text" name="description" disabled class="w-100" value="<%=category.getDescription()%>" >  </td> 
	
	
	
	<td>
         
                <!-- Hidden input to store the category_id for each row -->
                <input    type="hidden" name="categoryId" value="<%=category.getCategoryId()%>" >
               
                <!-- Update button with onclick event -->
                <input class="btn btn-info btn-update" hidden type="submit" value="update"  name="btn"  > 
               <button type="button"  name="edit" class=" btn btn-edit btn-success">Edit</button>
                
                <!-- Delete button -->
                <input class="btn btn-danger" type="submit" value="Delete" name="btn">
          
        </td>
        </form>
	</tr>
  
<% 		
	}
	
}
else
{
	out.print("table data not found");
}

%>



</tbody>
</table>
 




  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js">  </script>

 <script type="text/javascript">
	
	
    $("body").on("click",".btn-delete",function(){
        $(this).parents("tr").remove();
    })

    $("body").on("click",".btn-edit",function(){
        
        
        console.log($(this).parents('tr'));
              
             
                	
               var categoryName = $(this).parents('tr').find('input[name="categoryName"]').val();
               var description =   $(this).parents('tr').find('input[name="description"]').val();
            /*    var service_initial_price = $(this).parents('tr').find('input[name="initial_price"]').val();
               var service_image =  $(this).parents('tr').find('input[name="image"]').val(); */
               
                 console.log(categoryName);
                console.log(description);
              /*   console.log( service_initial_price );
                console.log(service_image ); */
                $(this).parents('tr').find('input[name="categoryName"]').removeAttr("disabled");
                 $(this).parents('tr').find('input[name="description"]').removeAttr("disabled");
                /* $(this).parents('tr').find('input[name="initial_price"]').removeAttr("disabled");
                 $(this).parents('tr').find('input[name="image"]').removeAttr("disabled");
                 $(this).parents('tr').find('input[name="image"]').attr("type","file");
                 //$(this).parents('tr').find('input[name="image"]').addAttr("type=file");
                /*  $(this).parents('tr').find('input[name="update"]').removeAttr("hidden"); */
                $(this).parents('tr').find('.btn-update').removeAttr("hidden"); 
             /*     sessionStorage.setItem("image",service_image); */
                 
                 //$(this).parents('tr').find('input[name="image"]').replaceWith(<input type="file" name="image" >)
               
       /*  $(this).parents("tr").find("td:eq(4)").prepend("<button class='btn btn-info btn-xs btn-update ' onclick='' >update </button> <button  class='btn btn-warning btn-xs btn-cancel'> cancel</button> "); */
 $(this).parents("tr").find("td:eq(2)").prepend("<button  class='btn btn-warning btn-xs btn-cancel'> cancel</button> ");
        $(this).hide();
        $('.btn-update').show();
       
        
    })

    $("body").on('click','.btn-cancel',function(){
       
    	/*  var service_image =  $(this).parents('tr').find('input[name="image"]').val(); */
    	
        $(this).parents('tr').find('input[name="categoryName"]').attr("disabled", "true");
                 $(this).parents('tr').find('input[name="description"]').attr("disabled", "true");
               /*   $(this).parents('tr').find('input[name="initial_price"]').attr("disabled", "true");
                 $(this).parents('tr').find('input[name="image"]').attr("disabled", "true"); */

                 /* var imageName= sessionStorage.getItem("image");
                 console.log( imageName+"hii"); */
              
      /*   $(this).parents('tr').find('input[name="image"]').replaceWith(<input type="text" required disabled value=${imageName} name="image">) */
       $(this).remove();
       $('.btn-update').hide();
       $('.btn-edit').show();

    })

    $("body").on('click','.btn-update',function(){
        
      
         $(this).hide(); 
        $('.btn-cancel').remove();
        $('.btn-edit').show();
    })
    
    </script>
    
    </body>
    </html>
   
   