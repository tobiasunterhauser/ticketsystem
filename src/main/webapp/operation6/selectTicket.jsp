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

int cNumber = Integer.parseInt(request.getParameter("cnumber"));
	
PreparedStatement pstTicket = c.prepareStatement("Select ticket.startdate, product.sn, product.gtin, ticket.supportagentcategory as category, product.title, product.description from ticket inner join product on ticket.productsn = product.sn and ticket.productgtin = product.gtin where customernumber = ?");
pstTicket.setInt(1, cNumber);
ResultSet resultTicket = pstTicket.executeQuery();
	



	




%>

<form class="text-center" action="createCommunication.jsp" method="get">

<div class="container text-center mt-5">

<label for="customer">Select Customer</label>

<select name="ticket" >
   <% 
   		while(resultTicket.next()){
	   
	   		String date = resultTicket.getString("startdate");
	   		String sn = resultTicket.getString("sn");
	   		String gtin = resultTicket.getString("gtin");
	   		String category = resultTicket.getString("category");
	   		String title = resultTicket.getString("title");
	  
	   		String outPrint = "Ticket about " + title + " and category " + category + " created on " + date + " product sn: " + sn + " product gtin " + gtin + "";
		   	
	   		out.println("<option value='" + date +"," + sn + "," + gtin + "'>" + outPrint + "</option>");
	   }
	
  	  %>
  
</select>

<input type="hidden" name="cnumber" value="<%=cNumber %>">

<div class="mt-3">
<label for="communication">Enter communication:</label>
<br>
<textarea  name="communication" rows="5"></textarea>
</div>
<button type="submit" class="mt-5 btn btn-success">Add communication</button>

</div>

</form>

</body>
</html>