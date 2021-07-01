<%@ page language="java" contentType="text/html; charset=UTF-8" %>
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

PreparedStatement pstCMSalary = c.prepareStatement("select ticket.startdate, product.sn, product.gtin, supportagent.category, customer.name, supportagent.firstname From ticket, customer, supportagent, product where ticket.customernumber = customer.number and ticket.supportagentnumber = supportagent.agentnumber and ticket.supportagentcategory = supportagent.category and ticket.productsn = product.sn and ticket.productgtin = product.gtin");
ResultSet rstTicket = pstCMSalary.executeQuery();




%>
</body>
<div class=" container text-center">
        <table class="table">
            <tr>
                
                <th>Startdate</th>
                <th>Product SN</th>
                <th>Product GTIN</th>
                <th>Problem Category</th>
                <th>Customer Name</th>
                <th>Support Agent Name</th>
            </tr>
            <tr>
            	<%
            	while(rstTicket.next()){
            		
            		out.println("<tr>");
            		
            		out.println("<td>" + rstTicket.getString("startdate") + "</td>");
            		out.println("<td>" + rstTicket.getString("sn") + "</td>");
            		out.println("<td>" + rstTicket.getString("gtin") + "</td>");
            		out.println("<td>" + rstTicket.getString("category") + "</td>");
            		out.println("<td>" + rstTicket.getString("name") + "</td>");
            		out.println("<td>" + rstTicket.getString("firstname") + "</td>");
						
            		
            		
            		out.println("</tr>");
 					
 					
            	}
            	
            	%>
            </tr>
        </table>
        
        <div>
        	 <a class="btn btn-success" href="http://localhost:8080/LibraryJSP/start.jsp">Back to Start</a>
        </div>
       

</html>


