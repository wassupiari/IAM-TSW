<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<% ProductBean j = (ProductBean) request.getAttribute("detailed"); %>

<!DOCTYPE html>
<html lang="en">

<head>
    <title><%= j.getNome() %></title>
    <link rel="stylesheet" href="style/details.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;1,100;1,200;1,300;1,400;1,500;1,600;1,700&display=swap'); 
        html, body {
            height: 100%;
            width: 100%;
            margin: 0;
            font-family: "IBM Plex Sans";
        }
        
        .container {
            max-width: 90%;
            margin: 0 auto;
            margin-bottom: 8%;
            padding: 3%;
            display: flex;
            flex-wrap: wrap;
        }
        
        .left-column {
            width: 50%;
            position: relative;
            display: flex;
            justify-content: center;
            margin-bottom: 1%;
        }
        
        .box_main {
		    border: 1px solid #333;
		    position: relative;
		    background-color: #fff;
		    width: 100%; /* Modifica la larghezza a 100% per adattarsi al contenitore */
		    max-width: 400px; /* Larghezza massima del box principale */
		    height: 400px; /* Altezza del box principale */
		    margin: 8% auto 15%; /* Margine aggiustato per centrare il box */
		    display: flex;
		    justify-content: center; /* Centra orizzontalmente */
		    align-items: center; /* Centra verticalmente */
		}
        
        .special_labels {
            position: absolute;
            top: 10px;
            right: 10px;
            display: flex;
            flex-direction: column;
            align-items: flex-end;
        }
        
        .special_label {
            background-color: #FFA500;
            color: #fff;
            padding: 5px 10px;
            border-radius: 10px;
            margin-bottom: 5px;
            font-size: 15px;
        }
        
        .right-column {
            width: 50%;
            margin-top: 30px;
        }
        
        .left-column img {
		    width: 100%;
		    height: auto;
		    opacity: 1;
		    transition: all 0.3s ease;
		    max-width: 100%; /* Larghezza massima dell'immagine */
		    max-height: 100%; /* Altezza massima dell'immagine */
		    display: block; /* Imposta l'immagine come blocco */
		    margin: 0 auto; /* Centra l'immagine all'interno del box */
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
            font-size: 30px;
            color: #43484D;
            letter-spacing: -2px;
        }
        
        .product-description p {
            font-size: 16px;
            font-weight: 300;
            color: #86939E;
            line-height: 24px;
        }
        
        .product-price {
            display: flex;
            align-items: center;
        }
        
        .cart-btn {
            display: absolute;
            background-color: #FFA500;
            border-radius: 5px;
            font-size: 18px;
            color: #FFFFFF;
            text-decoration: none;
            padding: 6px 15px;
            margin: 0;
        }
        
        .cart-btn:hover {
            background-color: #333333;
        }
        
        .product-quantity {
            margin-bottom: 10px;
        }
        
        .product-quantity span {
            color: #333;
            position: relative;
            margin: 10px 0;
            display: inline-block;
        }
        
        .quantity-choose input[type="number"] {
            padding: 8px 12px;
            font-size: 14px;
            color: #43474D;
            border: 2px solid #E1E8EE;
            border-radius: 5px;
            background-color: #FFFFFF;
            outline: none;
            width: 60px;
        }
        
        .quantity-choose input[type="number"]:hover,
        .quantity-choose input[type="number"]:focus {
            border-color: #86939E;
        }
        
        @media (max-width: 1024px) {
            .left-column, .right-column {
                width: 100%;
                text-align: center;
            }
            
            .left-column {
                order: 1;
            }
            
            .right-column {
                order: 2;
                margin-top: 20px;
            }
            
            .left-column img {
                width: 80%;
                margin: 0 auto;
            }
        }
        
        @media (max-width: 768px) {
            .product-description h1 {
                font-size: 24px;
            }
            
            .product-description p {
                font-size: 14px;
                line-height: 22px;
            }
            
            .product-price span {
                font-size: 20px;
            }
            
            .cart-btn {
                font-size: 16px;
                padding: 8px 20px;
            }
        }
        
        @media (max-width: 480px) {
            .product-description h1 {
                font-size: 20px;
            }
            
            .product-description p {
                font-size: 12px;
                line-height: 20px;
            }
            
            .product-price span {
                font-size: 18px;
            }
            
            .cart-btn {
                font-size: 14px;
                padding: 6px 15px;
            }
        }
    </style>
</head>

<body>

<%@ include file="../header.jsp" %>

<div class="container">

    <!-- Left Column / -->
    <div class="left-column">
        <div class="box_main">
            <% if (j.getSconto() >= 5) { %>
                <div class="special_labels">
                    <div class="special_label">-<%= j.getSconto() %>%</div>
                </div>
            <% } %>
            <div class="catalog_img">
                <img src="<%= j.getImmagine() %>">
            </div>
        </div>
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
        
                <div class="product-quantity">
                    <span>Quantità</span>
                    <div class="quantity-choose">
                        <form action="cart" method="get">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="id" value="<%= j.getId() %>">
                            <input type="number" id="quantita" name="quantita" min="1" value="1">
                            <button type="submit" class="cart-btn">Acquista</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<footer>
    <div>
        <%@ include file="../footer.jsp" %>
    </div>
</footer>

</body>
</html>
