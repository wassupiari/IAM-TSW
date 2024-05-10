<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Error</title>
    <link rel="stylesheet" type="text/css" href="style/errors.css">
    
    

</head>
<body>
<%@include file="../header.jsp" %>
<div class="error">
	    <h3> Quello che cerchi non esiste! </h3>

    <img src="images/404.jpg" class="errorImg" alt="Error">
    
    <p> 
        <a href="catalogo"><i class="fa-solid fa-chevron-left"> back </i></a> 
    </p>
</div>
<footer >
    	<div>
    		<%@include file="../footer.jsp" %>
    	</div>
    </footer>
</body>
</html>