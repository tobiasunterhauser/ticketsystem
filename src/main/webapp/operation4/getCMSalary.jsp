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

PreparedStatement pstCMSalary = c.prepareStatement("Select supportagent.firstname, supportagent.lastname, supportagent.category, supportagent.salary, categorymanager.bonus, (categorymanager.bonus + supportagent.salary) as totalsalary from categorymanager inner join supportagent on categorymanager.agentnumber = supportagent.agentnumber and categorymanager.category = supportagent.category");
ResultSet rstCMSalary = pstCMSalary.executeQuery();
	




%>
</body>
<div class=" container text-center">
        <table class="table">
            <tr>
                
                <th>Firstname</th>
                <th>Lastname</th>
                <th>Category</th>
                <th>Base Salary</th>
                <th>Bonus</th>
                <th>Total Salary</th>
            </tr>
            <tr>
            	<%
            	while(rstCMSalary.next()){
            		
            		out.println("<tr>");
            		
            		out.println("<td>" + rstCMSalary.getString("firstname") + "</td>");
            		out.println("<td>" + rstCMSalary.getString("lastname") + "</td>");
            		out.println("<td>" + rstCMSalary.getString("category") + "</td>");
            		out.println("<td>" + rstCMSalary.getString("salary") + "</td>");
            		out.println("<td>" + rstCMSalary.getString("bonus") + "</td>");
            		out.println("<td>" + rstCMSalary.getString("totalsalary") + "</td>");
						
            		
            		
            		out.println("</tr>");
 					
 					
            	}
            	
            	%>
            </tr>
        </table>
        
        <div>
        	 <a class="btn btn-success" href="http://localhost:8080/LibraryJSP/start.jsp">Back to Start</a>
        </div>
       

</html>


