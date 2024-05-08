<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, it.unisa.model.ProductBean" %>
<%
    Collection<ProductBean> products = (Collection<ProductBean>) request.getAttribute("catalogo");
    if(products == null) {
        response.sendRedirect("./catalogo");    
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Catalogo</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;1,100;1,200;1,300;1,400;1,500;1,600;1,700&display=swap'); 
        html,body{
            height: 100%;
            width: 100%;
            margin: 0;
            font-family: "IBM plex Sans";
            
        }

        /* Stile generale del catalogo */
        .container {
        	height:100%;
            text-align: center; 
            position: relative;
            /* Aggiunto per posizionare il rettangolo */
        }
        /* Stile del titolo */
        .fashion_taital {
            font-size: 36px;
            margin-bottom: 30px;
        }
        /* Stile dei singoli elementi del catalogo */
        /* Aggiunta dello stile del bordo al box principale */
        .box_main {
            border: 1px solid #333; /* Bordo di 2px di spessore e colore nero */
            position: relative; /* Aggiunto per posizionare le etichette */
            background-color: #fff;
            border-radius: 3px;
            width: auto;
            height: 100%; 
            margin-bottom: 40%;
            display: inline-block; 
            transition: box-shadow 0.3s ease;
        }
		.box_main a{
		text-decoration: none;
		color: #333;
		}

        .box_main:hover{
        border: 1px solid #FFA500;

        }

        /* Stile del rettangolo con le etichette */
        .special_labels {
            position: absolute;
            top: 10px;
            right: 10px;
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            z-index: 1; /* Assicura che il rettangolo sia sovrapposto al contenuto */
        }
        .special_label {
            background-color: #FFA500;
            color: #fff;
            padding: 5px 10px;
            border-radius: 10px;
            margin-bottom: 5px;
            font-size: 15px;
        }
        /* Stile del testo del prodotto */
        .shirt_text {
            font-size: 15px;
            margin-bottom: 15px;
        }
        /* Stile del prezzo */
        .price_text {
            font-size: 18px;
            text-align: center;
            position: absolut;
            bottom: 2em;
        }
        /* Stile dell'immagine del prodotto */
        .catalog_img {
            width: 100%;
            height: auto;
            overflow: hidden; 
            padding-top:10px;
        }

        .catalog_img img {
            width: 70%; 
            height: auto;
            border-radius: 12px; 
        }




        /* Stile dei pulsanti */
        .btn_main {
        position: absolute; /* Imposta la posizione fissa */
        bottom: 40px; /* Posiziona il pulsante a 10px dal basso */
        left: 50%; /* Centra il pulsante orizzontalmente */
        transform: translateX(-50%); /* Muove il pulsante a sinistra del 50% della sua larghezza per centrarlo */
        margin-top: 20px;
    }


        .btn_main a{
        color: #fff;
        text-decoration: none;
        font-size: 18px;
        }

        .buy_bt {
            display: inline-block;
            background-color: #90EE90;
            color: #fff;
            padding: 10px 30px;
            border-radius: 2px;
            margin: 10px 20px;
            transition: background-color 0.1s ease;
        }
        .buy_bt:hover{
            background-color: #FFA500;
              border: 1px solid #333;
        }

         .original_price {
            color: #999; /* Colore grigio per il prezzo originale */
            text-decoration: line-through; /* Sbarrare il prezzo originale */
            float: left;
            margin-left:10px;
            margin-bottom:20px;
            font-size: 16px;
        }

        .discounted_price {
            color: #262626; /* Colore del prezzo scontato */
            font-weight: bold; /* Testo in grassetto per il prezzo scontato */
            margin-right:10px;
            margin-bottom:20px;
            float: right;
        }

    .prodotto_esaurito {
        color: #ff0000; /* Rosso */
        font-size: 16px;
        font-weight: bold;
        text-align: center;
        position: absolute; /* Imposta la posizione fissa */
        bottom: 30px; /* Posiziona il pulsante a 10px dal basso */
        left: 50%; /* Centra il pulsante orizzontalmente */
        transform: translateX(-50%); /* Muove il pulsante a sinistra del 50% della sua larghezza per centrarlo */
        margin-top: 20px;
    }

        .productName{
        font-weight: bold;
        height:30px;
        padding:40px;
        }



        /* Stile per il layout 4x2 */
        .row {
            display: flex;
            flex-wrap: wrap;
            justify-content: center; /* Aggiunto per centrare il contenuto */
        }
        .col-lg-3 {
            flex: 0 0 calc(23% - 20px); /* Calcolato per 5 elementi per riga con spaziatura */
            max-width: calc(23% - 20px);
            margin-right: 10px; /* Ridotto lo

 spazio destro per mantenere il margine tra i box uniforme */
            margin-bottom: 20px;
        }

        @media (max-width: 991.98px) {
            .col-lg-3 {
                flex: 0 0 calc(50% - 20px); /* Calcolato per 2 elementi per riga con spaziatura */
                max-width: calc(50% - 20px);
            }
        }
    </style>
</head>
<body>
    <%@include file="header.jsp" %>
    <div class="fashion_section">
        <div class="container">
            <h1 class="fashion_taital">Catalogo</h1>
            <div class="row">
                <% 
                    for (ProductBean bean : products) {
                        double prezzoOriginale = bean.getPrezzo();
                        double sconto = bean.getSconto();
                        double prezzoScontato = prezzoOriginale * (1 - sconto / 100);
                %>
                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="box_main">
                    <a href="details?id=<%= bean.getId()%>">
                    <%  if (bean.getSconto() >= 5) { %>
                        <div class="special_labels">
                            <div class="special_label">-<%= bean.getSconto() %>%</div>
                        </div>
                        <%} %>
                        <div class="catalog_img">
                            <img src="<%= bean.getImmagine() %>">
                        </div>
                        <div class="productName">
                        <span class="shirt_text"><%= bean.getNome() %></span>
                        </div>
                        <div class="price_text">
                            <% if (sconto >= 5) { %>
                                <div class="price_left">
                                    <span class="original_price">€ <%= String.format("%.2f", prezzoOriginale) %></span>
                                </div>
                                <div class="price_right">
                                    <span class="discounted_price">€ <%= String.format("%.2f", prezzoScontato) %></span>
                                </div>
                            <% } else { %>
                                <div class="price_center">
                                    <span class="discounted_price">€ <%= prezzoOriginale %></span>
                                </div>
                            <% } %>                     
                        </div>

                        <% if (bean.getQuantita() == 0) { %>
                            <p class="prodotto_esaurito">NON DISPONIBILE</p>
                        <% } else { %>
                            <div class="btn_main">
                                <div class="buy_bt"><a href="cart?action=add&id=<%= bean.getId() %>"><span>ACQUISTA</span></a></div>
                            </div>
                        <% } %>
                        </a>
                    </div>
                    
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>
    <footer>
    	<div>
    		<%@include file="footer.jsp" %>
    	</div>
    </footer>
</body>
</html>