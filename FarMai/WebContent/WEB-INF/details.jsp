<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<% ProductBean j = (ProductBean) request.getAttribute("detailed"); %>

<!DOCTYPE html>
<html lang ="en">

<head>
    <title><%= j.getNome() %></title>
    <link rel="stylesheet" href="style/details.css">

    <style>
        @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;1,100;1,200;1,300;1,400;1,500;1,600;1,700&display=swap'); 
        html,body{
            height: 100%;
            width: 100%;
            margin: 0;
            font-family: "IBM plex Sans";  
        }
        
        .container {
            max-width: 90%;
            margin: 0 auto;
            margin-bottom: 8%;
            padding: 3%;
            display: flex;
            flex-wrap: wrap; /* Aggiunto per garantire il wrap dei contenuti quando lo spazio non è sufficiente */
        }
		.left-column {
		    width: 50%;
		    position: relative;
		    display: flex;
		    justify-content: center; /* Centra il contenuto orizzontalmente */
		    margin-bottom: 1%;
		}
		
		.box_main {
		    border: 1px solid #333;
		    position: relative;
		    background-color: #fff;
		    width: 400px; /* Larghezza fissa */
		    height: 400px; /* Altezza fissa */
		    margin-top: 8%;
		    margin-bottom: 15%;
		    z-index: -1;
		    margin: auto; /* Centra il box rispetto alla colonna sinistra */
		}
		




        /* Stile del rettangolo con le etichette */
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
    width: 100%; /* Larghezza al 100% */
    height: auto; /* Altezza automatica */
    position: absolute;
    left: 0;
    top: 0;
    opacity: 1;
    transition: all 0.3s ease;
    z-index: -1;
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
        
        .cable-choose {
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
        

        
        .cart-btn {
            display: inline-block;
            background-color:#FFA500 ;
            border-radius: 5px;
            font-size: 18px;
            color: #FFFFFF;
            text-decoration: none;
            padding: 12px 30px;
            transition: all .5s;
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
    padding: 8px 12px; /* Ridotto il padding */
    font-size: 14px; /* Ridotta la dimensione del carattere */
    color: #43474D;
    border: 2px solid #E1E8EE;
    border-radius: 5px;
    background-color: #FFFFFF;
    outline: none;
    width: 60px; /* Larghezza specifica */
}

.quantity-choose input[type="number"]:hover,
.quantity-choose input[type="number"]:focus {
    border-color: #86939E;
}


    </style>
</head>

<body>

<%@include file="../header.jsp" %>

<div class="container">

    <!-- Left Column / -->
    <div class="left-column">
    	<div class="box_main">
    		<%  if (j.getSconto() >= 5) { %>
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
        <div class="product-configuration">
            <div class="cable-config">
                <span>Formati Disponibili</span>

                <div class="cable-choose">
                    <button><%= j.getFormato() %></button>
                </div>
        
				<div class="product-quantity">
				    <span>Quantità</span>
				    <div class="quantity-choose">
				        <input type="number" id="quantity" name="quantity" min="1" value="1">
				    </div>
				
				    <a href="#">Modalità di spedizione</a>
				</div>

            </div>

            <!-- Product Pricing -->
            <div class="product-price">
                <a href="cart?action=add&id=<%= j.getId() %>" class="cart-btn">Acquista</a>
            </div>
        </div>
    </div>
</div>



<footer>
    <div>
        <%@include file="../footer.jsp" %>
    </div>
</footer>

</body>
</html>
                    
