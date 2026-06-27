<%@page import="Dao.SchemeDao"%>
<%@page import="Model.Scheme"%>
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
SchemeDao dao2 = new SchemeDao();
ArrayList<Scheme>schemes = dao2.getAllScheme();
/* for (Scheme scheme : schemes)
 {
 	out.println(schemes);
 	
 }
*/
 %>
 
 
 
 
<form action=SchemeCantroller"./SchemeInsert.jsp" >
<p class="text-end">
  <a href="./AdminPanel.jsp" class="btn btn-secondary me-2">← Back to Admin Panel</a>
  <a href="./SchemeInsert.jsp" class="btn btn-dark">Add New Scheme</a>
</p></form>

<table class="mx-auto mt-3 table  table table-bordered data-table w-50" id="data" >
<thead> <tr> <th scope="col">Scheme Name </th>  <th scope="col">Edit/Delete </th>  </tr> </thead>

<tbody>

<%
if(schemes != null)
{
	for(Scheme scheme : schemes)
	{
	
%>
  
	<tr>
	<form action="../SchemeController" method="post" >
	  
	<td class="w-25"> <input type="text" name="schemeName" disabled class="w-100" value="<%=scheme.getSchemeName()%>" > </td> 
	
	
		
	
	
	<td class="w-25">
         
                <!-- Hidden input to store the category_id for each row -->
                <input    type="hidden" name="schemeId" value="<%= scheme .getSchemeId()%>" >
               
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
              
             
                	
               var SchemeName = $(this).parents('tr').find('input[name="schemeName"]').val();
          
             
                $(this).parents('tr').find('input[name="schemeName"]').removeAttr("disabled");
               
             
                  $(this).parents('tr').find('input[name="update"]').removeAttr("hidden"); 
                $(this).parents('tr').find('.btn-update').removeAttr("hidden"); 
          
 $(this).parents("tr").find("td:eq(1)").prepend("<button  class='btn btn-warning btn-xs btn-cancel'> cancel</button> ");
        $(this).hide();
        $('.btn-update').show();
       
        
    })

    $("body").on('click','.btn-cancel',function(){
       
    
    	
        $(this).parents('tr').find('input[name="schemeName"]').attr("disabled", "true");
            
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
   
   