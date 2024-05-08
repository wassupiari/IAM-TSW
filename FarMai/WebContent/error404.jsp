<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Error</title>
    <link rel="stylesheet" type="text/css" href="./styles/errorStyle.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    
    <style>
    
body {
    font-family: "Times New Roman", serif, sans-serif;
    margin: 0;
    padding: 20px;
    background-color: #f9f9f9;
}

        h3 {
    color: #84A8A1 ;
    text-align: center;
    font-size: 36px;
}

        p {
    line-height: 1.5;
    color: #18020C;
    font-size: 16px;
    margin-bottom: 10px;
    text-align: center;
    margin-left:20%;
    margin-right:20%;
}
      a {
    text-decoration:none;
    background-color: #18020C;
    color: #fff;
    border: none;
    padding: 8px 16px;
    margin-top: 5px;
    cursor: pointer;
    border-radius: 20px;
}

 a:hover {
    background-color: #84A8A1;
    color: #fff;
    border: none;
    padding: 8px 16px;
    margin-top: 5px;
    cursor: pointer;
}

.errorImg {
   display: block;
   margin: 0 auto;
   width: 15%;
   height: auto;
}
    
    </style>
</head>
<body>
    <h3> Resource not found!</h3>

    <img src="images//error.png" class="errorImg" alt="Error">
    
    <p> 
        Return to <a href="catalogo">home &nbsp <i class="fa fa-home" aria-hidden="true"></i></a> 
    </p>

</body>
</html>