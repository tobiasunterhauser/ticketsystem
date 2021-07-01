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


//determine Problem data

String pTitle = request.getParameter("ptitle");
String pDescription = request.getParameter("pdescription");
String pCategory = request.getParameter("category");
String sn_gtin = request.getParameter("product");
String[] parts = sn_gtin.split(",");
int sn = Integer.parseInt(parts[0]);
int gtin = Integer.parseInt(parts[1]);


PreparedStatement pstProblemLength = c.prepareStatement("Select count(*) as rowcount From problem Where productgtin = ? AND productsn = ?");
pstProblemLength.setInt(1, gtin);
pstProblemLength.setInt(2, sn);
ResultSet resultProblemLength = pstProblemLength.executeQuery();




resultProblemLength.next();
int problemNumber = resultProblemLength.getInt("rowcount") ;
resultProblemLength.close() ;
problemNumber++;

PreparedStatement pstProblem = c.prepareStatement("Insert into problem values(?, ?, ?, ?,?,?)");
pstProblem.setInt(1, problemNumber);
pstProblem.setInt(2, sn);
pstProblem.setInt(3, gtin);
pstProblem.setString(4, pDescription);
pstProblem.setString(5, pTitle);
pstProblem.setString(6, pCategory);
pstProblem.execute();

PreparedStatement pstSupportAgent = c.prepareStatement("Select count(*) as rowcount From supportagent Where category = ?");
pstSupportAgent.setString(1, pCategory);
ResultSet resultSAlength = pstSupportAgent.executeQuery();

resultSAlength.next();
int numberOfSA = resultSAlength.getInt("rowcount");
resultSAlength.close();

//select random SA of category
Random rnd = new Random();
int randomSA = rnd.nextInt(numberOfSA) + 1;


//determine ticket data
int cNumber = Integer.parseInt(request.getParameter("cnumber"));
LocalDate todaysDate = LocalDate.now();

//user for exception
//boolean error = false;
//String errorMessage = "";

PreparedStatement pstTicket = c.prepareStatement("Insert into ticket values (?, ?, ?, ?, ?, ?)");
pstTicket.setObject(1, todaysDate);
pstTicket.setInt(2, cNumber);
pstTicket.setInt(3, sn);
pstTicket.setInt(4, gtin);
pstTicket.setInt(5, randomSA);
pstTicket.setString(6, pCategory);
pstTicket.execute();





%>



<div class="container text-center mt-5">

<h3>Ticket was created successfullly </h3>
<a class="btn btn-success" href="http://localhost:8080/LibraryJSP/start.jsp">Back to Start</a>


</body>
</html>