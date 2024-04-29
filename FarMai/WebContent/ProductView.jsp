<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, it.unisa.model.ProductBean" %>
<%
    Collection<ProductBean> products = (Collection<ProductBean>) request.getAttribute("prodotto");
    if(products == null) {
        response.sendRedirect("./prodotto");    
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Storage DS/BF</title>
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
        	margin-left: 30px ;
            padding: 60px 0;
            text-align: center; 
            position: relative; /* Aggiunto per posizionare il rettangolo */
        }
        /* Stile del titolo */
        .fashion_taital {
            font-size: 36px;
            margin-bottom: 30px;
        }
        /* Stile dei singoli elementi del catalogo */
        .box_main {
            position: relative; /* Aggiunto per posizionare le etichette */
            background-color: #fff;
            
            border-radius: 12px;
            border-color: #333;
            padding: 15px;
            margin-bottom: 30px;
            text-align: center;
            display: inline-block; 
            transition: box-shadow 0.3s ease;
        }
        
        .box_main:hover{
        box-shadow: 0 0 10px #FFA500;
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
            font-size: 24px;
            margin-bottom: 15px;
        }
        /* Stile del prezzo */
        .price_text {
            font-size: 18px;
            text-align: right;
        }
        /* Stile dell'immagine del prodotto */
        .catalog_img {
		    width: 100%;
		   	height: 200px;
		    overflow: hidden; /* Nasconde eventuali parti dell'immagine che eccedono l'altezza specificata */
		}
		
		.catalog_img img {
		    width: 50%; /* Assicura che l'immagine riempia completamente il contenitore */
		    height: auto; /* Consente all'immagine di adattarsi proporzionalmente alla larghezza specificata */
		    border-radius: 12px; /* Applica il bordo arrotondato */
		}
        
        
        
        /* Stile dei pulsanti */
        .btn_main {
        
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
            padding: 10px 20px;
            border-radius: 5px;
            margin-right: 10px;
            transition: background-color 0.3s ease;
        }
        .buy_bt:hover{
            background-color: #E6F2E0;
        }
        
        
        
        
        /* Stile per il layout 4x2 */
        .row {
            display: flex;
            flex-wrap: wrap;
            justify-content: center; /* Aggiunto per centrare il contenuto */
        }
        .col-lg-3 {
            flex: 0 0 calc(25% - 30px); /* Calcolato per 4 elementi per riga con spaziatura */
            max-width: calc(25% - 30px);
            margin-right: 30px;
            margin-bottom: 30px;
        }
        @media (max-width: 991.98px) {
            .col-lg-3 {
                flex: 0 0 calc(50% - 30px); /* Calcolato per 2 elementi per riga con spaziatura */
                max-width: calc(50% - 30px);
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
                %>
<div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="box_main">
                    <%  if (bean.getSconto() >= 5) { %>
                        <div class="special_labels">
                            <div class="special_label">-<%= bean.getSconto() %>%</div>
                        </div>
                        <%} %>
                        <div class="catalog_img">
                            <a href="details?id=<%= bean.getId()%>"><img src="<%= bean.getImmagine() %>"></a>
                        </div>
                        <h4 class="shirt_text"><%= bean.getNome() %></h4>
                        <p class="price_text"><span style="color: #333333;"><%= bean.getPrezzo() %>€</span></p>
                        <div class="btn_main">
                            <div class="buy_bt"><a href="details"><span>ACQUISTA</span></a></div>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</body>
</html>
