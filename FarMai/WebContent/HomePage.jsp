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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<style>
 @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;1,100;1,200;1,300;1,400;1,500;1,600;1,700&display=swap'); 
 
        html,body{
            height: 100%;
            width: 100%;
              margin: 0;
			  padding: 0;
			  overflow-x: hidden;
font-family: "IBM Plex Sans";

            
        }
.container {
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 40px;
    margin-top: 40px;
    flex-wrap: wrap;
    position: relative; /* Aggiunto per consentire lo spazio per l'ombra */
    z-index: 1; /* Assicura che il contenuto della pagina si sovrapponga correttamente */
}

.container::after {
    content: '';
    position: absolute;
    width: 100%;
    height: 20px; /* Altezza dell'ombra */
    left: 0;
    bottom: -20px; /* Spessore dell'ombra che desideri */
    box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.1); /* Solo ombra verso il basso */
    transition: box-shadow 0.3s ease; /* Transizione fluida per l'ombra */
    z-index: -1; /* Posiziona l'ombra dietro il contenuto */
}
        .box, .main-box {
            border: 3px solid #d0e7c2;
            border-radius: 10px;
            padding: 10px;
            margin: 10px 10px;
            text-align: center;
            width: 200px;
            height: 200px;
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
            width: 60px;
            height: 60px;
            line-height: 40px;
            font-size: 25px;
            font-weight: bold;
            color: #4caf50;
            margin:0 auto 10px auto;
        }
        
        .box .title, .main-box .title  {
            margin-bottom: 5px;
            font-size: 15px;
        }
        
        .main-box .description {
            text-align: center;
            margin-bottom: 8px;
            margin-top: 50px;
            
        }
        
        .box .description-far {
            text-align: center;
            font-weight: bold;
            margin-bottom: 8px;
            font-size: 18px;
            color: #4caf50;
        }
        .main-box .description-far {
            text-align: center;
            font-weight: bold;
            margin-bottom: 8px;
            font-size: 18px;
            color: #4caf50;
        }
        
.text {
    text-align: justify; /* Allineamento del testo giustificato */
    margin: 60px auto; /* Margine superiore e inferiore di 60px, centrato orizzontalmente */
    font-size: 20px;
    line-height: 1.5; /* Interlinea ridotta per un aspetto più pulito */
    padding: 0 100px; /* Spazio ai lati */
    max-width: 800px; /* Larghezza massima del contenuto */
}

.text::before,
.text::after {
    content: ''; /* Aggiunge contenuto pseudo-elemento vuoto per bordi */
    display: block;
    border-top: 4px solid #E6F2E0; /* Bordo sopra */
    border-bottom: 4px solid #E6F2E0; /* Bordo sotto */
    margin: 0 auto; /* Centra i bordi orizzontalmente */
    width: 50%; /* Larghezza del bordo */
    margin-top: 20px; /* Spazio sopra il bordo */
    margin-bottom: 20px; /* Spazio sotto il bordo */
}

        .text div{
        	margin:0;
        	padding:0;
        }
        .bold{
        color:#4caf50;
        	font-weight: bold;
        }
        .fashion_taital {
        	text-align: center;
            font-size: 36px;
            margin-bottom: 30px;
            margin-top:30px;
            font-weight: bold;
        }
        .fashion_section{
            padding-top: 20px; 
                margin-top: 20px; 
        	margin:0;
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
    display: flex;
    justify-content: center;
    align-items: center;
    padding-top: 10px;
    margin: 0 auto; /* Questo aggiunge margini automatici a sinistra e a destra */
}

.catalog_img img {
    width: 70%;
    height: auto;
    border-radius: 12px;
    display: block; /* Assicura che l'immagine sia considerata come blocco */
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
        font-weight: bold;
        }

        .buy_bt {
            display: inline-block;
            background-color: #FFA500;
            color: #333;
            padding: 10px 30px;
            border-radius: 5px;
            margin: 10px 20px;
            transition: background-color 0.1s ease;
        }
        .buy_bt:hover{
            background-color: #333;
              
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
            margin-right: 10px; /* Ridotto lo spazio destro per mantenere il margine tra i box uniforme */
            margin-bottom: 40px;
        }

        @media (max-width: 991.98px) {
            .col-lg-3 {
                flex: 0 0 calc(50% - 20px); /* Calcolato per 2 elementi per riga con spaziatura */
                max-width: calc(50% - 20px);
            }
        }
        .section-title {
    		display: flex;
    		align-items: center;
    		justify-content: center;
    		position: relative;
    		margin: 20px 0;
    		
		}


		.section-title h2 {
   			color: #4caf50; /* Colore del testo */
    		font-size: 24px; /* Dimensione del testo */
    		margin: 0; /* Elimina il margine del titolo */
    		padding: 0 10px; /* Spazio ai lati del testo */
    		background-color: #fff; /* Sfondo bianco per coprire la linea */
    		z-index: 1;
		}

		.section-title::before {
    		content: "";
    		position: absolute;
    		left: 0;
    		top: 50%;
    		width: 100%;
    		height: 3px; /* Altezza della linea */
    		background-color: #A0C49D; /* Colore della linea */
    		z-index: 0;
		}
		.categorie-title {
            width: 300px;
            margin: 0 auto;
            border: 5px solid #A0C49D;
            border-radius: 5px;
            overflow: hidden;
            display: inline-block; 
            margin-left:90px;
            margin-bottom:110px;
        }
        .header {
            background-color:#A0C49D;
            color: white;
            padding: 10px;
            text-align: center;
            font-size: 18px;
            font-weight: bold;
        }
        .category {
            padding: 10px 20px;
            border-bottom: 1px solid #ccc;
            cursor: pointer;
            font-size: 16px;
        }
        .category:last-child {
            border-bottom: none;
        }
        .category:hover {
            background-color: #f1f1f1;
        }


.slideshow-container {
  max-width: 100%;
  position: relative;
  margin: auto;
}

.mySlides {
  display: none;
}

.image-container {
  position: relative;
}

.full-width-image {
  width: 100%;
  height: auto;
}

.gradient-overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 20%; /* Adjust the height of the gradient as needed */
  background: linear-gradient(to bottom, rgba(255, 255, 255, 0) 0%, rgba(0, 0, 0, 0.5) 100%);
}

.prev, .next {
  cursor: pointer;
  position: absolute;
  top: 50%;
  width: auto;
  padding: 16px;
  margin-top: -22px;
  color: white;
  font-weight: bold;
  font-size: 18px;
  transition: 0.6s ease;
  border-radius: 0 3px 3px 0;
  user-select: none;
}

.prev {
  left: 0;
  border-radius: 3px 0 0 3px;
}

.next {
  right: 0;
  border-radius: 0 3px 3px 0;
}

.prev:hover, .next:hover {
  background-color: rgba(0,0,0,0.8);
}

/* Optional: Add some animation for the slides */
.fade {
  animation-name: fade;
  animation-duration: 1.5s;
}

@keyframes fade {
  from { opacity: .4; }
  to { opacity: 1; }
}
	    .image-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); /* 4 colonne responsive */
        grid-gap: 1%; /* Spazio tra le immagini */
        justify-items: center; /* Allinea le immagini al centro */
        padding: 20px; /* Padding per il contenitore */
    }

    .image-grid img {
        width: 100%; /* Immagini che riempiono il loro spazio nel grid */
        height: auto;
         max-width: 80%; /* Altezza automatica rispetto alla larghezza */
        border-radius: 8px; /* Bordi arrotondati */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Ombra leggera */
        transition: transform 0.3s ease; /* Transizione per l'effetto di hover */
    }

    .image-grid img:hover {
        transform: scale(1.05); /* Ingrandisce leggermente l'immagine al passaggio del mouse */
    }
	
    </style>
</head>
<body>
<%@include file="header.jsp" %>


<div class="slideshow-container">

  <div class="mySlides fade">
    <div class="image-container">
      <img src="images/2.jpg" class="full-width-image">
      <div class="gradient-overlay"></div>
    </div>
  </div>
  <div class="mySlides fade">
    <div class="image-container">
      <img src="images/1.jpg" class="full-width-image">
      <div class="gradient-overlay"></div>
    </div>
  </div>
  <div class="mySlides fade">
    <div class="image-container">
      <img src="images/4.jpg" class="full-width-image">
      <div class="gradient-overlay"></div>
    </div>
  </div>
  <div class="mySlides fade">
    <div class="image-container">
      <img src="images/1.jpg" class="full-width-image">
      <div class="gradient-overlay"></div>
    </div>
  </div>
  <div class="mySlides fade">
    <div class="image-container">
      <img src="images/5.jpg" class="full-width-image">
      <div class="gradient-overlay"></div>
    </div>
  </div>
  <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
  <a class="next" onclick="plusSlides(1)">&#10095;</a>
</div>


<div class="container">
        <div class="main-box">
            <div class="star"><i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i></div>
            <div class="description">I 5 motivi per scegliere</div>
             <div class="description-far">FarMai</div>
        </div>
        <div class="box">
            <div class="star"><i class="fas fa-star"></i></div>
            <div class="number">1</div>
            <div class="title">Tanti <div class="description-far">24/24h</div> adatti ad ogni tua esigenza</div>
        </div>
        <div class="box">
            <div class="star"><i class="fas fa-star"></i></div>
            <div class="number">2</div>
            <div class="title">Spedizioni <div class="description-far">veloci</div></div>
        </div>
        <div class="box">
            <div class="star"><i class="fas fa-star"></i></div>
            <div class="number">3</div>
            <div class="title">Servizio clienti  </div><div class="description-far">24/24h</div>
        </div>
        <div class="box">
            <div class="star"><i class="fas fa-star"></i></div>
            <div class="number">4</div>
            <div class="title">Prodotti di alta qualità per la tua</div> <div class="description-far">salute</div>
        </div>
        <div class="box">
            <div class="star"><i class="fas fa-star"></i></div>
            <div class="number">5</div>
            <div class="title">Extra <div class="description-far">sconti</div> applicati a quasi tutti i prodotti</div>
        </div>
    </div>


<div class="fashion_section">
<div class="section-title">
        <h2>LE SUPER OFFERTE</h2>
        <div class="line"></div>
    </div>
<div class="row">
                <% 
                if (products != null && products.size() != 0) {
    				Iterator<?> it = products.iterator();
    				while (it.hasNext()) {		
    					ProductBean bean = (ProductBean) it.next();
    					double prezzoOriginale = bean.getPrezzo();
                        double sconto = bean.getSconto();
                        double prezzoScontato = prezzoOriginale * (1 - sconto / 100);
              
                	if(sconto>5){
                %>
                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="box_main">
                    <a href="details?id=<%=bean.getId()%>">
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
                                <a href="cart?action=add&id=<%= bean.getId()%>&quantita=1">
                                	<div class="buy_bt">
                                		<span><svg xmlns="http://www.w3.org/2000/svg" height="15" width="18.5" viewBox="0 0 576 512"><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path fill="#ffffff" d="M0 24C0 10.7 10.7 0 24 0H69.5c22 0 41.5 12.8 50.6 32h411c26.3 0 45.5 25 38.6 50.4l-41 152.3c-8.5 31.4-37 53.3-69.5 53.3H170.7l5.4 28.5c2.2 11.3 12.1 19.5 23.6 19.5H488c13.3 0 24 10.7 24 24s-10.7 24-24 24H199.7c-34.6 0-64.3-24.6-70.7-58.5L77.4 54.5c-.7-3.8-4-6.5-7.9-6.5H24C10.7 48 0 37.3 0 24zM128 464a48 48 0 1 1 96 0 48 48 0 1 1 -96 0zm336-48a48 48 0 1 1 0 96 48 48 0 1 1 0-96z"/></svg>	                                
										</span>
									</div>
								</a>
                            </div> 
                        <% } %>
                        </a>
                    </div> 
                </div>
                <%
                		}
    				}
                }
                %>
            </div>
           </div>  
	<div>
	
	
	
	<div class="fashion_section">
<div class="section-title">
        <h2>PRODOTTI NUOVI</h2>
        <div class="line"></div>
    </div>
<div class="row">
                <% 
                if (products != null && products.size() != 0) {
    				Iterator<?> it = products.iterator();
    				while (it.hasNext()) {		
    					ProductBean bean = (ProductBean) it.next();
    					double prezzoOriginale = bean.getPrezzo();
                        double sconto = bean.getSconto();
                        double prezzoScontato = prezzoOriginale * (1 - sconto / 100);
              
                	if(sconto<5){
                %>
                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="box_main">
                    <a href="details?id=<%=bean.getId()%>">
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
                                <a href="cart?action=add&id=<%= bean.getId()%>&quantita=1">
                                	<div class="buy_bt">
                                		<span><svg xmlns="http://www.w3.org/2000/svg" height="15" width="18.5" viewBox="0 0 576 512"><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path fill="#ffffff" d="M0 24C0 10.7 10.7 0 24 0H69.5c22 0 41.5 12.8 50.6 32h411c26.3 0 45.5 25 38.6 50.4l-41 152.3c-8.5 31.4-37 53.3-69.5 53.3H170.7l5.4 28.5c2.2 11.3 12.1 19.5 23.6 19.5H488c13.3 0 24 10.7 24 24s-10.7 24-24 24H199.7c-34.6 0-64.3-24.6-70.7-58.5L77.4 54.5c-.7-3.8-4-6.5-7.9-6.5H24C10.7 48 0 37.3 0 24zM128 464a48 48 0 1 1 96 0 48 48 0 1 1 -96 0zm336-48a48 48 0 1 1 0 96 48 48 0 1 1 0-96z"/></svg>	                                
										</span>
									</div>
								</a>
                            </div> 
                        <% } %>
                        </a>
                    </div> 
                </div>
                <%
                		}
    				}
                }
                %>
            </div>
           </div>  
	<div>

    
    <div class="text"> 
    	<div> FarMai è la tua farmacia online di <span class="bold">fiducia</span>, una realtà che associa la tradizionale figura del farmacista al dinamico mondo dell'e-commerce.<br>
		Mettiamo al centro dell'attenzione le persone e le loro <span class="bold">esigenze</span> ed è per questo che oltre ad essere una farmacia fisica,<br> abbiamo deciso di creare un vero e proprio e-commerce farmaceutico, un canale vendita online di farmaci senza prescrizione e parafarmaci che possa soddisfare qualunque tipo di richiesta.
		Tutti i prodotti vendibili online sono immediatamente <span class="bold">disponibili</span> e per questo vantiamo spedizioni rapide e <span class="bold">sicure</span> che ti permetteranno di ordinare e ricevere i prodotti comodamente a casa tua in minor tempo possibile.<br>
		Su FarMai troverai un'ampia varietà di farmaci in offerta a prezzo sempre scontato e super <span class="bold">conveniente.</span> <br>
		Collaboriamo con i migliori brand per avere sempre la <span class="bold">qualità</span> dei prodotti al primo posto. </div>
    </div>
	</div>
	
	
	<div class="image-grid">
    <img src="images/prom1.jpg" alt="Immagine 1">
    <img src="images/prom2.jpg" alt="Immagine 2">
    <img src="images/prom3.jpg" alt="Immagine 3">
    <img src="images/prom4.jpg" alt="Immagine 4">
	</div>
	
	
<%@include file="footer.jsp" %>



<script>
let slideIndex = 1;
showSlides(slideIndex);

function plusSlides(n) {
  showSlides(slideIndex += n);
}

function showSlides(n) {
  let i;
  let slides = document.getElementsByClassName("mySlides");
  if (n > slides.length) {slideIndex = 1}    
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";  
  }
  slides[slideIndex-1].style.display = "block";  
}
</script>



</body>
</html>