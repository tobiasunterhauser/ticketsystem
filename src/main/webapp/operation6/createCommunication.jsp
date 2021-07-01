<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.LocalDateTime" %>
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

LocalDateTime timestamp = LocalDateTime.now();
String content = request.getParameter("communication");
int cNumber = Integer.parseInt(request.getParameter("cnumber"));
String ticket_comp = request.getParameter("ticket");
String[] parts = ticket_comp.split(",");
LocalDate ticketDate = LocalDate.parse(parts[0]);
int sn = Integer.parseInt(parts[1]);
int gtin = Integer.parseInt(parts[2]);


PreparedStatement pstCom = c.prepareStatement("Insert into usercommunication values (?, ?, ?, ?, ?, ?)");
pstCom.setObject(1, timestamp);
pstCom.setObject(2, ticketDate);
pstCom.setInt(3, cNumber);
pstCom.setInt(4, sn);
pstCom.setInt(5, gtin);
pstCom.setString(6, content);
pstCom.execute();







%>



<div class="container text-center mt-5">

<h3>Communication was added successfullly </h3>
<a class="btn btn-success" href="http://localhost:8080/LibraryJSP/start.jsp">Back to Start</a>


</body>
</html>