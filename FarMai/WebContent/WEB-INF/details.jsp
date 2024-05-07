<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<% ProductBean j = (ProductBean) request.getAttribute("detailed");

%>

<!DOCTYPE html>
<html lang ="en">

<head>
    <title><%= j.getNome() %></title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


    <style>

html, body {
  height: 100%;
  width: 100%;
  margin: 0;
  font-family: 'Roboto', sans-serif;
}
 
.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 15px;
  display: flex;
}

.left-column {
  width: 65%;
  position: relative;
}
 
.right-column {
  width: 35%;
  margin-top: 60px;
}

.left-column img {
  width: 80%;
  position: absolute;
  left: 0;
  top: 0;
  opacity: 1;
  transition: all 0.3s ease;
}
 
.left-column img.active {
  opacity: 1;
}

.product-description {
  border-bottom: 1px solid #E1E8EE;
  margin-bottom: 20px;
}
.product-description span {
  font-size: 12px;
  color: #358ED7;
  letter-spacing: 1px;
  text-transform: uppercase;
  text-decoration: none;
}
.product-description h1 {
  font-weight: 300;
  font-size: 52px;
  color: #43484D;
  letter-spacing: -2px;
}
.product-description p {
  font-size: 16px;
  font-weight: 300;
  color: #86939E;
  line-height: 24px;
}

.product-color {
  margin-bottom: 30px;
}
 

.cable-choose {
  margin: auto;
  margin-bottom: 20px;
}
 
.cable-choose button {
  border: 2px solid #E1E8EE;
  border-radius: 6px;
  padding: 13px 20px;
  font-size: 14px;
  color: #5E6977;
  background-color: #fff;
  cursor: pointer;
  transition: all .5s;
}
 
.cable-choose button:hover,
.cable-choose button:active,
.cable-choose button:focus {
  border: 2px solid #86939E;
  outline: none;
}
 
.cable-config {
  border-bottom: 1px solid #E1E8EE;
  margin-bottom: 20px;
}
 
.cable-config a {
  color: #358ED7;
  text-decoration: none;
  font-size: 12px;
  position: relative;
  margin: 10px 0;
  display: inline-block;
}
 
.cable-config a:before {
  content: "?";
  height: 15px;
  width: 15px;
  border-radius: 50%;
  border: 2px solid rgba(53, 142, 215, 0.5);
  display: inline-block;
  text-align: center;
  line-height: 16px;
  opacity: 0.5;
  margin-right: 5px;
}

.product-price {
  display: flex;
  align-items: center;
}
 
.product-price span {
  font-size: 26px;
  font-weight: 300;
  color: #43474D;
  margin-right: 20px;
}
 
.cart-btn {
  display: inline-block;
  background-color: #7DC855;
  border-radius: 6px;
  font-size: 16px;
  color: #FFFFFF;
  text-decoration: none;
  padding: 12px 30px;
  transition: all .5s;
}
.cart-btn:hover {
  background-color: #64af3d;
}


/* .product-box {
    border: 1px solid #ddd; /* Bordo sottile */
    border-radius: 5px; /* Bordi arrotondati */
    padding: 15px; /* Spazio interno */
    margin-bottom: 20px; /* Margine inferiore */
    transition: all 0.3s ease; /* Effetto di transizione */
}



.product-image img {
    width: 50%; /* Immagine al 100% della larghezza del box */
    border-radius: 5px; /* Bordi arrotondati */
    margin-bottom: 10px; /* Margine inferiore */
}

.product-box h2 {
    font-size: 18px; /* Dimensione del titolo */
    margin-bottom: 5px; /* Margine inferiore */
}

.product-box span {
    font-size: 16px; /* Dimensione del prezzo */
    font-weight: bold; /* Testo in grassetto */
    color: #333; /* Colore del testo */
    margin-bottom: 10px; /* Margine inferiore */
}

.product-box .btn {
    display: inline-block; /* Mostra il pulsante come blocco inline */
    background-color: #007bff; /* Colore di sfondo del pulsante */
    color: #fff; /* Colore del testo del pulsante */
    padding: 8px 16px; /* Spaziatura interna del pulsante */
    border: none; /* Nessun bordo */
    border-radius: 5px; /* Bordi arrotondati */
    text-decoration: none; /* Nessuna decorazione del testo */
    transition: background-color 0.3s ease; /* Effetto di transizione */
}

.product-box .btn:hover {
    background-color: #0056b3; /* Cambia il colore di sfondo al passaggio del mouse */
} */




    </style>

</head>

<body>


			<%@include file="../header.jsp" %>


   <div class="container">
 
  <!-- Left Column / Headphones Image -->
  <div class="left-column">
  	<p> </p>
    <img src="<%= j.getImmagine() %>" alt="<%= j.getNome() %>">
  </div>
 
 
  <!-- Right Column -->
  <div class="right-column">
 
    <!-- Product Description -->
    <div class="product-description">
      <span><%= j.getCategoria() %></span>
      <h1><%= j.getNome() %></h1>
      <p><%= j.getDescrizione() %></p>
    </div>
 
    <!-- Product Configuration -->
    <div class="product-configuration">
      <div class="cable-config">
        <span>Formati Disponibili</span>
 
        <div class="cable-choose">
          <button><%= j.getFormato() %></button>

        </div>
 
        <a href="#">How to configurate your headphones</a>
      </div>
    </div>
 
    <!-- Product Pricing -->
    <div class="product-price">
      <span><%= j.getPrezzo() %> €</span>
      <a href="#" class="cart-btn">Acquista</a>
    </div>
  </div>
</div>


<%-- <div class="container">
    <% List<ProductBean> similarProducts = (List<ProductBean>) request.getAttribute("similarProducts"); %>
    <div class="row">
        <% for (ProductBean product : similarProducts) { %>
            <div class="col-lg-4 col-md-4 col-sm-4">
                <div class="product-box">
                    <!-- Immagine del prodotto -->
                    <div class="product-image">
                        <img src="<%= product.getImmagine() %>" alt="<%= product.getNome() %>">
                    </div>
                    <!-- Nome del prodotto -->
                    <h2><%= product.getNome() %></h2>
                    <!-- Prezzo del prodotto -->
                    <span><%= product.getPrezzo() %></span>
                    <!-- Link per visualizzare i dettagli del prodotto -->
                    <a href="details?id=<%= product.getId() %>" class="btn">Details</a>
                </div>
            </div>
        <% } %>
    </div>
</div> --%>


</body>
</html>