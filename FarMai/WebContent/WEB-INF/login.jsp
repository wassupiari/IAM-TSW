<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>login</title>
	</head>
	<style>
		@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;1,100;1,200;1,300;1,400;1,500;1,600;1,700&display=swap'); 
		html,body
		{
			height: 100%;
			width: 100%;
			margin: 0;
			font-family: "IBM plex Sans";  
		}

		.container 
		{
			max-width: 90%;
			margin: 0 auto;
			margin-bottom: 8%;
			padding: 3%;
			display: flex;
			flex-wrap: wrap; /* Aggiunto per garantire il wrap dei contenuti quando lo spazio non è sufficiente */
		}
		.left-column ,.right-column
		{
			width: 46%;	
			height:100%;
			position:relative;
			display: flex;
            flex-direction: column;
            justify-content: flex;  
			margin: 1%;
			
		}
		h3
		{
			font-weight:normal;
		}
		.login
		{
		    position: relative;
		    display: inline-block;
		    color: #333333;
		    font-size: 45px;
		}

		.login::after 
		{
		    position: absolute;
		    left: 0;
		    bottom: -5px;
		    width: 30%;
		    height: 5px;
		    background: linear-gradient(to right, #A0C49D, #E6F2E0);
		    border-radius: 2px;
		}
		.email, .password
		{
			width: 100%;
			height: 30px;
			margin-top:1%;
			margin-bottom:3%;
			border:none;
			border-bottom:2px groove #A0C49D;;
			color:#333333;
			font-family: "IBM plex Sans";
			font-size:20px;
			
		}
		
		button , .submit
		{
			margin-top:2%;
		    background-color: #FFA500;
		    color: white;
		    width:20%;
		    height:auto;
		    justify-content:center;
		    border: none;
		    border-radius: 25px; /* Arrotondamento dei bordi */
		    padding: 15px 30px; /* Spaziatura interna */
		    font-size: 16px;
		    font-weight: bold;
		    cursor: pointer;
		    transition: background-color 0.3s ease;
		}
		
		button:hover 
		{
		    background-color: #333333; /* Colore leggermente più scuro per l'effetto hover */
		}
	</style>
	<body>
	<%@include file="../header.jsp" %>
		<div class="container">
    		<div class="left-column">
    			<h1 class="login">NUOVO CLIENTE</h1>
    			<h3>Registrazione Account</h3>
    				Creando un account potrai effettuare gli acquisti più velocemente, controllare lo stato dei tuoi ordini e avere a disposizione lo storico delle attività.<br>
    				<button>Registrati</button>
    		</div>
    		<div class="right-column">
    			<h1 class="login">GIÀ CLIENTE</h1>
    			<h3>sono già un cliente</h3>
    			<form action="">
    				<label>Indirizzo Email:</label>
            		<input class="email" type="email" name="Email" placeholder="Email..."><br>
            		<label>Password:</label>
            		<input class="password" type="password" name="pwd" placeholder="Password..."><br>
            		<input class="submit" type="submit" value="Accedi">
            	</form>
    		</div>
    	</div>
    	<%@include file="../footer.jsp" %>
	</body>
</html>