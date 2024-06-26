<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, it.unisa.model.*" %>

<%
		Cart cart = (Cart) request.getSession().getAttribute("cart");
		request.getSession().setAttribute("cart", cart);

%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    

    
    <style>
        @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;1,100;1,200;1,300;1,400;1,500;1,600;1,700&display=swap'); 


	
body {
	font-family: "IBM plex Sans";
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	min-height: 100vh; 
    display: flex;
    flex-direction: column;
}

.wrapper {
	flex-grow: 1;
	margin-right: 10%;
	max-width: 90%;
	margin-left: 10%;
}
.wrapper h1 {
	padding : 1%;
	text-align: left;
	
}
.project {
	display: flex;
}
.shop {
	flex: 100%;
}
.box {
	display: flex;
	width: 100%;
	overflow: hidden;
	margin-bottom: 50px;

}

.box img {
	max-width: 15%;
	object-fit: contain;
}
.content {
	padding: 3%;
	width: 100%;
	position: relative;
}
.content h3 {
	margin-bottom: 2%;
}
.content h4 {
	margin-bottom: 8%;
}
.btn-area {
	position: absolute;
	bottom: 5%;
	right: 3%;
	padding: 1% 2%;
	background-color: #333;
	color: white;
	cursor: pointer;
	border-radius: 5px;

}

.btn-area a {
	text-decoration: none;
}

.btn-area span, i {
	color: white;
}

.btn-area:hover{
	background-color: #FFA500;
	  box-shadow: rgba(0, 0, 0, .15) 0 3px 9px 0;
  transform: translateY(-2px);
}




.right-bar {
	flex: 25%;
	margin-left: 2%;
	padding: 2%;
	height: 1%;
	border-radius: 3%;
	transition: all .6s ease;
	background: #fff;
	
}

.right-bar hr {
	margin-bottom: 7%;
}
.right-bar p {
	display: flex;
	justify-content: space-between;
	margin-bottom: 10%;
	font-size: 20px;
}

.right-bar button {
 			display: inline-block;
            background-color: #333;
            color: #fff;
            padding: 10px 30px;
            border-radius: 5px;
            margin: 10px 20px;
            transition: background-color 0.1s ease;
}

.right-bar button:hover {
	background-color: #FFA500;
	  box-shadow: rgba(0, 0, 0, .15) 0 3px 9px 0;
  transform: translateY(-2px);
}

.right-bar form {
	display: flex;
	justify-content: center;
}

.right-bar i {
	margin-right: 3%;
}

input[type="number"] {
    width: 8%;
    padding: 1.5%;
    height: 3%;
    
}

.btn {
 			display: inline-block;
            background-color: #333;
            color: #fff;
            padding: 1.5% 4.5%;
            border-radius: 5px;
            margin: 1.5% 3%;
            transition: background-color 0.1s ease;
}

.btn:hover {
	background-color: #FFA500;
	  box-shadow: rgba(0, 0, 0, .15) 0 3px 9px 0;
  transform: translateY(-2px);
  
}

@media (min-width: 768px) {
  .btn {
    padding: 1.5% 4.5%;
  }
} 

@media screen and (max-width: 700px) {
	.content h3 {
		margin-bottom: 2.25%;
	}
	.content h4 {
		margin-bottom: 3%;
	}
	.btn2 {
		display: none;
	}
	.box {
		height: 22.5%;
	}
	.box img {
		height: 22.5%;
		width: 30%;
	}
}
@media screen and (max-width: 900px) {
	.project {
		flex-direction: column;
	}
	.right-bar {
		margin-left: 0;
		margin-bottom: 3%;
	}
}
@media screen and (max-width: 1250px) {
	.wrapper {
		max-width: 95%;
	}
}

			
        
    </style>
</head>
<body>
<%@include file="../header.jsp" %>

  <div class="wrapper">
		<h1>Carrello</h1>
		<div class="project">
			<div class="shop">
			    <%
			        List<ProductBean> j = cart.getProducts();     
			    %>
			
			    <% if (j.isEmpty()) { %>
			    <div class="error">
			        <p>Non ci sono prodotti nel carrello</p>
			        </div>
			    <% } else { %>
			      <% List<ProductBean> prodCart = cart.getProducts();     
           				for(ProductBean beanCart : prodCart) { %>

				<div class="box">
					<img src="<%=beanCart.getImmagine()%>" alt = "?">
					<div class="content">
						<h3><%= beanCart.getNome() %></h3>
						<h4>Prezzo: <%= beanCart.getPrezzoScontato() %> €</h4>
						<form action="cart?action=aggiorna&id=<%= beanCart.getId() %>" method="POST" >
							Quantità: <input type="number" name="quantita" value="<%= beanCart.getQuantita() %>" required min="1" max="<%= beanCart.getQuantitaS() %>">
							<button type = "submit" class = "btn">Aggiorna</button>
						</form>
						<p class="btn-area">
						<a href = "cart?action=deleteC&id=<%=beanCart.getId()%>">
						<i aria-hidden="true" class="fa fa-trash"></i> <span class="btn2"></span>
						</a>		
						</p>
					</div>
				</div>
					<% }
           				}%>
				</div>
				<div class = "right-bar">
				<p><span>Spedizione</span> <span>Gratuita</span></p>
				<hr>
				<p><span>Totale</span>
				<% if(cart != null){ %>
				<span><%=cart.getPrezzoTotale()%> €</span>
				<% } else {%>  <span>0.00 €</span> <%} 
				if(cart != null) {%>
<form action="cart" method="POST">
    <input type="hidden" name="action" value="buy">
    <button type="submit"><i class="fa fa-shopping-cart"></i><span>Paga</span></button>
</form>


  				<% } %>
  				</div>
			</div>
		</div>


<%@include file="../footer.jsp" %>
</body>
</html>
