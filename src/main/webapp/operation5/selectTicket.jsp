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


String sa = request.getParameter("sa");
String[] parts = sa.split(",");
int saNumber = Integer.parseInt(parts[0]);
String category = parts[1];
	
PreparedStatement pstTicket = c.prepareStatement("select ticket.startdate, ticket.customernumber, ticket.productsn, ticket.productgtin, ticket.supportagentcategory, customer.name, product.title from ticket, product, customer where ticket.productsn = product.sn and ticket.productgtin = product.gtin and customer.number = ticket.customernumber and ticket.supportagentnumber = ? and ticket.supportagentcategory = ?");
pstTicket.setInt(1, saNumber);
pstTicket.setString(2, category);
ResultSet resultTicket = pstTicket.executeQuery();
	



	




%>

<form class="text-center" action="closeTicket.jsp" method="get">

<div class="container text-center mt-5">

<label for="customer">Select Customer</label>

<select name="ticket" >
   <% 
   		while(resultTicket.next()){
	   
	   		String date = resultTicket.getString("startdate");
	   		String sn = resultTicket.getString("productsn");
	   		String gtin = resultTicket.getString("productgtin");
	   		String title = resultTicket.getString("title");
	   		String cNumber = resultTicket.getString("customernumber");
	  
	   		String outPrint = "Ticket about " + title + " and category " + category + " created on " + date + " product sn: " + sn + " product gtin " + gtin + "";
		   	
	   		out.println("<option value='" + date +"," + sn + "," + gtin + "," + cNumber+  "'>" + outPrint + "</option>");
	   }
	
  	  %>
  
</select>

<input type="hidden" name="sanumber" value="<%=saNumber %>">
<input type="hidden" name="category" value="<%=category %>">

<div class="mt-3">
<lable>I want to close the selected ticket</lable>
<input type="checkbox" required>

</div>
<button type="submit" class="mt-5 btn btn-success">Close selected ticket</button>

</div>

</form>

</body>
</html>