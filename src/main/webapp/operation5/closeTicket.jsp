<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.time.LocalDate" %>


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

int saNumber = Integer.parseInt(request.getParameter("sanumber"));
String saCategory = request.getParameter("sacategory");
String parts[] = (request.getParameter("ticket")).split(",");
LocalDate startDate = LocalDate.parse(parts[0]);
int sn = Integer.parseInt(parts[1]);
int gtin = Integer.parseInt(parts[2]);
int cNumber = Integer.parseInt(parts[3]);
LocalDate todaysDate = LocalDate.now();

PreparedStatement pstCloseTicket = c.prepareStatement("Insert into ticketclosed values (?, ?, ?, ?, ?)");
pstCloseTicket.setObject(1, startDate);
pstCloseTicket.setInt(2, cNumber);
pstCloseTicket.setInt(3, sn);
pstCloseTicket.setInt(4, gtin);
pstCloseTicket.setObject(5, todaysDate );
pstCloseTicket.execute();

%>

</body>
<div>
<h1>Ticket closed on the <%=todaysDate %> </h1>

</div>
<div>
	
	<a class="btn btn-success" href="http://localhost:8080/LibraryJSP/start.jsp">Back to Start</a>

</div>
</html>