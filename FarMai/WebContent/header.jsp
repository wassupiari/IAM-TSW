<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<%
	ClientBean clientbean = (ClientBean) request.getSession().getAttribute("utente");

%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Header</title>
		<!-- <link rel="stylesheet" href="style/header.css"> -->
	</head>
	<style>
	@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;1,100;1,200;1,300;1,400;1,500;1,600;1,700&display=swap'); 


header .grid-container > div
{
	height:10%;
	font-family: "IBM plex Sans";
	font-size: 20px;
}

.logo
{
	padding-left:1%;
	float:left;
}

.menu {
    list-style-type: none;
    margin: 5;
    background-color: #E6F2E0;
    overflow: hidden;
    display: flex; /* Aggiunto per utilizzare il flexbox */
    justify-content: center;
    align-items: center; /* Per allineare verticalmente i contenuti */
}

.menu li {
    float: left;
    text-align: center;
}

.menu li a {    
    font-size: 20px;
    color: #333;
    text-align: center;
    padding: 10px 12px;
    text-decoration: none;
}

.menu li a:hover {
    background-color: #E6F2E0;
}

.main-header {
    font-size: 20px;
    justify-content: center;
    align-content: right;
    text-align: center;
    padding: 4%;
    float:right
}

.main-header a:link {
    padding: 2%;
    margin: 1%;
    text-align: center;
    text-decoration: none;
    display: inline-block;
}

header
{
	height:10%;
	overflow:hidden;
	background-color: #A0C49D;
	width:100%;
	z-index:999;
}


@media screen and(max-width:780px)
{
	.main-header
	{
		display:none;
	}
}

header .grid-container
{
	height:70px;
	display:grid;
	grid-template-columns:80% 20% 20% ;
	grid-template-rows:auto;
	gap: 5px;
	background:#A0C49D;
	}
	
.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f9f9f9;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

.dropdown:hover .dropbtn {
  background-color: #A0C49D;
}
.dropdown {
  float: left;
  overflow: hidden;
}

.dropdown .dropbtn {
  font-size: 16px;  
  border: none;
  outline: none;
  color: black;
  padding: 14px 16px;
  background-color: inherit;
  font-family: inherit;
  margin: 0;
}

.dropdown-content a {
  float: none;
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
  text-align: left;
}

.dropdown-content a:hover {
  background-color: #ddd;
}

.dropdown:hover .dropdown-content {
  display: block;
}
}
	</style>
	
	<body>
	  	<header>
		    <div class="grid-container">  
		        <div class="logo">
		        <a href="catalogo">         
					<svg version="1.2" xmlns="http://www.w3.org/2000/svg" viewBox="50 130 500 500" width="155" height="150">
						<title>logo</title>
						
						<style> 
							.s0 { fill: #f5f5f5 } 
							.t1 { font-size: 100px;fill: #f5f5f5;font-weight:500;font-family: "IBM plex Sans" } 
							.t2 { font-size: 92px;fill: #f5f5f5;font-weight: 500;font-family: "IBM plex Sans" } 
						</style>
						<g id="OBJECTS">
							<g id="Layer">
								<g id="Layer">
									<path id="Layer" class="s0" d="m225.8 225v33.1c0 12.3-10.1 22.4-22.4 22.4h-56.6c-5.7 0-10.6-2.7-13.8-6.9-2.1-2.9-3.4-6.4-3.4-10.2 0-9.2 7.2-16.6 16.2-17.1 0.5-9 8-16.2 17.1-16.2 9.5 0 17.1 7.7 17.1 17.1v21h-7.5v-21c0-5.3-4.3-9.5-9.6-9.5-5.2 0-9.5 4.2-9.5 9.5q0 1.2 0.3 2.3c0.3 1.3-0.1 2.7-1 3.6-1 1-2.3 1.3-3.6 1q-1.2-0.3-2.3-0.3c-5.3 0-9.6 4.3-9.6 9.6 0 5.2 4.3 9.5 9.6 9.5h56.6c8.1 0 14.8-6.6 14.8-14.8v-29.3h-41.9c-2.1 0-3.8-1.7-3.8-3.8v-27.1c0-8.2-6.7-14.9-14.9-14.9h-29.3v42c0 2.1-1.7 3.8-3.8 3.8h-27.1c-8.1 0-14.8 6.6-14.8 14.8v29.3h41.9c1.1 0 2 0.4 2.7 1.1 0.7 0.7 1.1 1.6 1.1 2.7v27.1c0 8.2 6.7 14.8 14.8 14.8h29.4v-33.3h7.5v37.1c0 2.1-1.7 3.8-3.7 3.8h-33.2c-12.3 0-22.3-10-22.3-22.4v-23.3h-42c-2.1 0-3.8-1.7-3.8-3.8v-33.1c0-12.4 10.1-22.4 22.4-22.4h23.4v-41.9c0-2.1 1.6-3.8 3.7-3.8h33.1c12.4 0 22.4 10 22.4 22.4v23.3h42c2.1 0 3.8 1.7 3.8 3.8z"/>
								</g>
							</g>
						</g>
						<g id="TEXTS">
							<g id="Layer">
								<text id="FarMaì" style="transform: matrix(1,0,0,1,244.62,279.077)" >
									<tspan x="0" y="0" class="t1">F</tspan><tspan  y="0" class="t2">a</tspan><tspan  y="0" class="t2">r</tspan><tspan  y="0" class="t2">M</tspan><tspan  y="0" class="t2">A</tspan><tspan  y="0" class="t2">Ì</tspan><tspan  y="0" class="t2">
									</tspan>
								</text>
							</g>
						</g>
					</svg></a>        
	        	</div>

				<div id="main" class="main-header">
				
				<% if (clientbean == null) { %>
				      
					<a href="login">
					<svg   width="25px" height="25px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path fill="#ffffff" d="M352 96l64 0c17.7 0 32 14.3 32 32l0 256c0 17.7-14.3 32-32 32l-64 0c-17.7 0-32 14.3-32 32s14.3 32 32 32l64 0c53 0 96-43 96-96l0-256c0-53-43-96-96-96l-64 0c-17.7 0-32 14.3-32 32s14.3 32 32 32zm-9.4 182.6c12.5-12.5 12.5-32.8 0-45.3l-128-128c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L242.7 224 32 224c-17.7 0-32 14.3-32 32s14.3 32 32 32l210.7 0-73.4 73.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0l128-128z"/></svg>
					</a>
					
					
					<% }else{ %>
		            <a href="cart">
			<svg  width="30px" height="30px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path fill="#ffffff" d="M0 24C0 10.7 10.7 0 24 0H69.5c22 0 41.5 12.8 50.6 32h411c26.3 0 45.5 25 38.6 50.4l-41 152.3c-8.5 31.4-37 53.3-69.5 53.3H170.7l5.4 28.5c2.2 11.3 12.1 19.5 23.6 19.5H488c13.3 0 24 10.7 24 24s-10.7 24-24 24H199.7c-34.6 0-64.3-24.6-70.7-58.5L77.4 54.5c-.7-3.8-4-6.5-7.9-6.5H24C10.7 48 0 37.3 0 24zM128 464a48 48 0 1 1 96 0 48 48 0 1 1 -96 0zm336-48a48 48 0 1 1 0 96 48 48 0 1 1 0-96z"/></svg>
					</a>
					<a href="login?action=logout">
								<svg width="30px" height="30px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path fill="#ffffff" d="M502.6 278.6c12.5-12.5 12.5-32.8 0-45.3l-128-128c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L402.7 224 192 224c-17.7 0-32 14.3-32 32s14.3 32 32 32l210.7 0-73.4 73.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0l128-128zM160 96c17.7 0 32-14.3 32-32s-14.3-32-32-32L96 32C43 32 0 75 0 128L0 384c0 53 43 96 96 96l64 0c17.7 0 32-14.3 32-32s-14.3-32-32-32l-64 0c-17.7 0-32-14.3-32-32l0-256c0-17.7 14.3-32 32-32l64 0z"/></svg>
					</a>    
					<% }%>            
		        </div>
		        <div class="carrello">
				</div>
			</div>
		</header>
		<div class= "menu">            
      		<ul class="menu">
      			<div class="dropdown">
    				<button class="dropbtn">Mamme e bambini
      					<i class="fa fa-caret-down"></i>
    				</button>
   					 	<div class="dropdown-content">
     						 <a href="#">Pannolini</a>
   				</div>
   				</div>
			   		<div class="dropdown">
    				<button class="dropbtn">Alimentazione e integratori
      					<i class="fa fa-caret-down"></i>
    				</button>
   					 	<div class="dropdown-content">
     						 <a href="#">Integratori</a>
     						 <a href="#">Tisane</a>
   				</div>
   				</div>
   				
   				 <div class="dropdown">
    				<button class="dropbtn">Bellezza e cosmetica
      					<i class="fa fa-caret-down"></i>
    				</button>
   					 	<div class="dropdown-content">
     						 <a href="#">Creme solari</a>
     					</div>
   				</div>
   				
   				<div class="dropdown">
    				<button class="dropbtn">Farmaci da banco
      					<i class="fa fa-caret-down"></i>
    				</button>
   					 	<div class="dropdown-content">
     						 <a href="#">Analgesici</a>
   						</div>
			   </div>
			   
			   <div class="dropdown">
    				<button class="dropbtn">Igiene e benessere
      					<i class="fa fa-caret-down"></i>
    				</button>
   					 	<div class="dropdown-content">
     						 <a href="#">Dentifrici</a>
     						 <a href="#">Balsami</a>
     						 <a href="#">Shampoo</a>
     						 <a href="#">Lozioni</a>
   				</div>
   				</div>
   				</div>
			</ul>
        </div>
	</body>
</html> 
        