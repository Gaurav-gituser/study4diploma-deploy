
<%@page import="Dao.BrancheDao"%>
<%@page import="Model.Branche"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</head>
<body>
<%

/* for (Branches branche : branches)
 {
 	out.println(branches);
 	
 }
*/

BrancheDao dao = new BrancheDao();
ArrayList<Branche> allBranch = dao.getAllbranches();

 %>
 
 
 
 
<form action=BrancheCantroller"./BrancheInsert.jsp" >
<p class="text-end"> <button type="submit" class="p-2 me-3 btn btn-dark"><a href="./BrancheInsert.jsp">Add New Branche</a> </button></button></p>
</form>

<table class="mx-auto mt-3 table  table table-bordered data-table w-50" id="data" >
<thead> <tr> <th scope="col">Branche </th>  <th scope="col">Edit/Delete </th>  </tr> </thead>

<tbody>

<%
if(allBranch != null)
{
	for(Branche branche :allBranch)
	{
	
%>
  
	<tr>
	<form action="../BrancheCantroller" method="post" >
	  
	<td class="w-25"> <input type="text" name="branche" disabled class="w-100" value="<%=branche.getbranche()%>" > </td> 
	
	
		
	
	
	<td class="w-25">
         
                <!-- Hidden input to store the branche_id for each row -->
                <input type="hidden" name="branche_id" value="<%=branche.getbranche_id()%>" >
               
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
              
             
                	
               var SchemeName = $(this).parents('tr').find('input[name="branche"]').val();
          
             
                $(this).parents('tr').find('input[name="branche"]').removeAttr("disabled");
               
             
                  $(this).parents('tr').find('input[name="update"]').removeAttr("hidden"); 
                $(this).parents('tr').find('.btn-update').removeAttr("hidden"); 
          
 $(this).parents("tr").find("td:eq(1)").prepend("<button  class='btn btn-warning btn-xs btn-cancel'> cancel</button> ");
        $(this).hide();
        $('.btn-update').show();
       
        
    })

    $("body").on('click','.btn-cancel',function(){
       
    
    	
        $(this).parents('tr').find('input[name="branche"]').attr("disabled", "true");
            
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
   
