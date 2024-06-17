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
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 20px;
        }
        .box {
            border: 2px solid #d0e7c2;
            border-radius: 10px;
            padding: 10px;
            margin: 0 10px;
            text-align: center;
            width: 200px;
        }
        .box .star {
            color: #f9c825;
            font-size: 24px;
        }
        .box .number {
            background-color: #d0e7c2;
            border-radius: 50%;
            display: inline-block;
            width: 40px;
            height: 40px;
            line-height: 40px;
            font-size: 24px;
            color: #4caf50;
            margin-bottom: 10px;
        }
        .box .title {
            font-weight: bold;
            margin-bottom: 5px;
        }
        .main-box {
            border: 2px solid #d0e7c2;
            border-radius: 10px;
            padding: 20px;
            margin-right: 10px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .main-box .star {
            color: #f9c825;
            font-size: 24px;
            margin-bottom: 10px;
        }
        .main-box .title {
            font-weight: bold;
            margin-bottom: 10px;
            text-align: center;
        }
        .main-box .description {
            text-align: center;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<%@include file="header.jsp" %>
<div class="container">
        <div class="main-box">
            <div class="star">★★★★★</div>
            <div class="title">I 5 motivi per scegliere</div>
            <div class="description">FarMai</div>
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
            <div class="title">.....</div>
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