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

int cNumber = Integer.parseInt(request.getParameter("cnumber"));
String sa = request.getParameter("sa");
String[] parts = sa.split(",");
int saNumber = Integer.parseInt(parts[0]);
String saCategory = parts[1];
int rating = Integer.parseInt(request.getParameter("rating"));



PreparedStatement pstCM = c.prepareStatement("Select agentnumber from categorymanager where category = ?");
pstCM.setString(1, saCategory);
ResultSet rstCM = pstCM.executeQuery();
rstCM.next();
int cmNumber = rstCM.getInt("agentnumber");
rstCM.close();

LocalDate todaysDate = LocalDate.now();


PreparedStatement pstRating = c.prepareStatement("Insert into rating values(?, ?, ?, ?, ?, ?, ?)");
pstRating.setObject(1, todaysDate);
pstRating.setInt(2, cNumber );
pstRating.setInt(3, saNumber);
pstRating.setString(4, saCategory);
pstRating.setInt(5, rating);
pstRating.setInt(6, cmNumber);
pstRating.setString(7, saCategory);
pstRating.execute();




%>


<form class="text-center" action="createRating.jsp" method="get">

<div class="container text-center mt-5">

<h1>Rating was saved succesfully</h1>

<a class="btn btn-success" href="http://localhost:8080/LibraryJSP/start.jsp">Back to Start</a>
</form>

</body>
</html>