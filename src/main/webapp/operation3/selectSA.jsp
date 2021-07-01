<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.Random" %>

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


int cNumber = Integer.parseInt(request.getParameter("customer"));


PreparedStatement pstSA = c.prepareStatement("Select supportagent.agentnumber as snumber, supportagent.category as scategory, supportagent.firstname as sfirstname, supportagent.lastname as slastname From ticket INNER JOIN supportagent ON ticket.supportagentnumber = supportagent.agentnumber AND ticket.supportagentcategory = supportagent.category Where ticket.customernumber =?");
pstSA.setInt(1, cNumber);
ResultSet rstSA = pstSA.executeQuery();





LocalDate todaysDate = LocalDate.now();









%>


<form class="text-center" action="createRating.jsp" method="get">

<div class="container text-center mt-5">

<label for="sa">Select Support Agent</label>

<select name="sa" >
   <% 
   		while(rstSA.next()){
	   
	   		int saNumber = Integer.parseInt(rstSA.getString("snumber"));
	   		String saCategory = rstSA.getString("scategory");
	  
		   	out.println("<option value='" + saNumber +"," + rstSA.getString("scategory")   + "'>" + 
				   rstSA.getString("sfirstname")+ " " + rstSA.getString("slastname") +" " + saCategory + " Specialist </option>");
	   }
	
  	  %>
  
</select>
<br>
<br>
<label>How would you rate this support on a scale from 1 (worst) to 10 (best)?</label>
<br>
<%for(int i = 1; i <= 10; i++){
	out.println("<input type=\"radio\" id=\"" + i + "\" name=\"rating\" value=\"" + i + "\">" +
			  "<label for=\"" + i + "\">" + i + "</label><br>");
	
}
	
	%>


<% //we dont save the following information %>

<label>Comment</label>
<textarea></textarea>
<input type="hidden" name="cnumber" value="<%=cNumber%>">

<br>
<button type="submit" class="mt-5 btn btn-success">Continue with rating</button>

</div>

</form>

</body>
</html>