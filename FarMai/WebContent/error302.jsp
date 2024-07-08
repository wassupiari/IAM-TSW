<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Error</title>
    <link rel="stylesheet" type="text/css" href="style/errors.css">
    
    

</head>
<body>
<%@include file="header.jsp" %>
<div class="error">
	    <h3> Siamo spiacenti..la pagina non funziona </h3>

    <img src="images/error302.jpg" class="errorImg" alt="Error">
    <h5> Clicca il pulsante in basso per tornare alla home<br></h5>
    <p> 
        <a href="home"><i class="fa-solid fa-chevron-left"> back </i></a> 
    </p>
</div>
<footer >
    	<div>
    		<%@include file="footer.jsp" %>
    	</div>
    </footer>
</body>
</html>