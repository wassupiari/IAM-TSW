<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, it.unisa.model.*" %>
<%
	Collection<?> products = (Collection<?>) request.getAttribute("prodotti");
    if(products == null) {
        response.sendRedirect("./home");    
        return;
    }
    
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home page</title>
<style>
 @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;1,100;1,200;1,300;1,400;1,500;1,600;1,700&display=swap'); 
 
         body {
            font-family:"IBM plex Sans";
        }
        .container {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 20px;
        }
        .box, .main-box {
            border: 2px solid #d0e7c2;
            border-radius: 10px;
            padding: 10px;
            margin: 0 10px;
            text-align: center;
            width: 200px;
            height: 150px;
            flex-direction: column;
            justify-content: center;
        }
        .box .star, .main-box .star {
            color: #f9c825;
            font-size: 24px;
        }
        .box .number {
            background-color: #d0e7c2;
            border-radius: 70%;
            display: flex;
            align-items: center;
    		justify-content: center;
            width: 40px;
            height: 40px;
            line-height: 40px;
            font-size: 20px;
            color: #4caf50;
            margin:0 auto 10px auto;
        }
        .box .title, .main-box .title {
            font-weight: bold;
            margin-bottom: 5px;
            font-size: 13px;
        }
        .main-box .description {
        	font-weight: bold;
            text-align: center;
            margin-bottom: 8px;
            margin-top: 50px;
            
        }
        .main-box .description-far {
            text-align: center;
            margin-bottom: 8px;
            font-size: 18px;
        }
    </style>
</head>
<body>
<%@include file="header.jsp" %>
<div class="container">
        <div class="main-box">
            <div class="star">★★★★★</div>
            <div class="description">I 5 motivi per scegliere</div>
            <div class="description-far">FarMaì</div>
        </div>
        <div class="box">
            <div class="star">★</div>
            <div class="number">1</div>
            <div class="title">Tanti prodotti adatti ad ogni tua esigenza</div>
        </div>
        <div class="box">
            <div class="star">★</div>
            <div class="number">2</div>
            <div class="title">Spedizioni veloci</div>
        </div>
        <div class="box">
            <div class="star">★</div>
            <div class="number">3</div>
            <div class="title">Servizio clienti 24/24 h</div>
        </div>
        <div class="box">
            <div class="star">★</div>
            <div class="number">4</div>
            <div class="title">Prodotti di alta qualità per la tua salute</div>
        </div>
        <div class="box">
            <div class="star">★</div>
            <div class="number">5</div>
            <div class="title">Extra sconti applicati a quasi tutti i prodotti</div>
        </div>
    </div>

<%@include file="footer.jsp" %>

</body>
</html>