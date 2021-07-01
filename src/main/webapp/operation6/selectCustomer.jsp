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


	
PreparedStatement pstCustomer = c.prepareStatement("SELECT name, number FROM customer");

ResultSet resultCustomer = pstCustomer.executeQuery();
	



	




%>

<form class="text-center" action="selectTicket.jsp" method="get">

<div class="container text-center mt-5">

<label for="customer">Select Customer</label>

<select name="cnumber" >
   <% 
   		while(resultCustomer.next()){
	   
	   		String number = resultCustomer.getString("number");
	  
		   	out.println("<option value='" + number  + "'>" + 
				   resultCustomer.getString("name") + "</option>");
	   }
	
  	  %>
  
</select>
<br>
<button type="submit" class="mt-5 btn btn-success">Continue with selection of ticket</button>

</div>

</form>

</body>
</html>