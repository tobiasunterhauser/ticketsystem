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


PreparedStatement pstSA = c.prepareStatement("Select supportagent.agentnumber, supportagent.category, supportagent.firstname, supportagent.lastname from supportagent inner join ticket  on ticket.supportagentnumber = supportagent.agentnumber and ticket.supportagentcategory = supportagent.category");
ResultSet rstSA = pstSA.executeQuery();




%>


<form class="text-center" action="selectTicket.jsp" method="get">

<div class="container text-center mt-5">

<label for="sa">Select Support Agent which has an ope ticket</label>

<select name="sa" >
   <% 
   		while(rstSA.next()){
	   
	   		int saNumber = Integer.parseInt(rstSA.getString("agentnumber"));
	   		String saCategory = rstSA.getString("category");
	   		String firstname = rstSA.getString("firstname");
	   		String lastname = rstSA.getString("lastname");
	  
		   	out.println("<option value='" + saNumber +"," + saCategory   + "'>" +  firstname + " " + lastname +" " + saCategory + " Specialist </option>");
	   }
	
  	  %>
  
</select>
<br>
<br>

<button type="submit" class="mt-5 btn btn-success">Select Ticket</button>

</div>

</form>

</body>
</html>