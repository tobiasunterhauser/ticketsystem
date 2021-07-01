<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
</head>
<body>
<%
///Connect db
Class.forName("org.postgresql.Driver");
String url = "jdbc:postgresql://localhost:5432/ticketsystem?user=postgres&password=12345678";

Connection c = DriverManager.getConnection(url);


//get parameter

int customerNumber = Integer.parseInt(request.getParameter("customer"));
	


PreparedStatement pstProduct = c.prepareStatement("Select product.sn as sn, product.gtin as gtin, product.title as ptitle From customer, invoice, product Where customer.number = invoice.customernumber AND (invoice.number = product.invoicenumber AND invoice.year = product.invoiceyear) AND customer.number = " + customerNumber);
ResultSet resultProduct = pstProduct.executeQuery();
	
PreparedStatement pstCategory = c.prepareStatement("Select name, description From category");
ResultSet resultCategory =pstCategory.executeQuery();


	




%>

<form class="text-center" action="createTicket.jsp" method="get">

<div class="container text-center mt-5">

<h3>Product Details</h3>

<input type="hidden" name="cnumber" value="<%=customerNumber %>">

<label for="product">Select Product</label>

<select name="product" >
   <% 
   		while(resultProduct.next()){
	   
	   		String sn = resultProduct.getString("sn");
	   		String gtin = resultProduct.getString("gtin");
	  
	 		
		   	out.println("<option value='" + sn +"," + gtin   + "'>" + 
				   resultProduct.getString("ptitle") + "</option>");
	   }
	
  	  %>
  
</select>

<h3 class="mt-5"> Problem Details</h3>

<label for="category">Select Category</label>

<select name="category" >
   <% 
   		while(resultCategory.next()){
	   
	   		String name = resultCategory.getString("name");
	   		
	  
	 		
		   	out.println("<option value='" + name   + "'>" + name + "</option>");
	   }
	
  	  %>
  
</select>
<br>
<label for="ptitle" >Title</label>
<input name="ptitle" type="text">
<br>
<label for="pdescription">Description</label>
<textarea  name="pdescription" rows="4"></textarea>
<br>
<button type="submit" class="mt-5 btn btn-success">Create Ticket</button>

</div>

</form>

</body>
</html>