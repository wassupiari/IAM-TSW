<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, it.unisa.model.*" %>
<%

%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>Catalogo</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;1,100;1,200;1,300;1,400;1,500;1,600;1,700&display=swap'); 
        /* Stili generali per il corpo e l'HTML */
        html, body {
            height: 100%;
            width: 100%;
            margin: 0;
            font-family: "IBM Plex Sans", sans-serif;
        }

        /* Contenitore principale del catalogo */
        .catalogo-container {
            width: 100%;
            height: 100%;
            padding: 20px; /* Aggiunto spazio intorno al contenuto */
            box-sizing: border-box; /* Assicura che il padding non aumenti la larghezza */
        }

        /* Intestazione del catalogo */
        h2 {
            font-size: 30px;
            color: #333;
            text-align: left;
            margin-left: 50px;
            margin-bottom: 20px; /* Spazio sotto l'intestazione */
        }

        /* Griglia per il layout dei prodotti */
        .catalogo {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around; /* Centra gli elementi nella riga */
        }

        /* Stile delle card dei prodotti */
        .card {
            flex: 0 0 calc(25% - 20px); /* Calcolato per 4 elementi per riga con margine */
            max-width: calc(25% - 20px);
            background: #fff;
            border: 1px solid #333;
            border-radius: 3px;
            margin: 10px; /* Spazio tra le card */
            text-align: center;
            padding: 20px; /* Spaziatura interna delle card */
            transition: transform 0.2s ease; /* Effetto di transizione */
            position: relative; /* Per rendere relative le special labels */
        }

        .card:hover {
            border: 1px solid #FFA500;
            transform: scale(1.03); /* Effetto di ingrandimento al passaggio del mouse */
        }

        .card img {
            width: 80%; /* Dimensione delle immagini dei prodotti */
            height: auto;
            transition: transform 0.2s; /* Effetto di transizione sull'immagine */
        }

        .card p,
        .card a {
            font-weight: bold;
            font-size: 18px;
            color: #333; /* Colore del testo */
        }

        .card a {
            text-decoration: none;
            color: black;
            display: inline-block;
            margin-top: 10px; /* Spazio sopra il link */
            padding: 5px 10px;
            border: 2px solid #FFA500;
            border-radius: 10px;
            transition: background-color 0.3s, color 0.3s; /* Transizioni animate */
        }

        .card a:hover {
            color: white;
            background-color: #FFA500; /* Colore di sfondo al passaggio del mouse */
        }

        /* Media query per dimensioni dello schermo più piccole */
        @media screen and (max-width: 880px) {
            .card {
                flex: 0 0 calc(40% - 20px); /* Ridimensiona le card per adattarsi a due per riga */
                max-width: calc(40% - 20px);
            }

            .card img {
                width: 80%; /* Ridimensiona le immagini per adattarsi allo spazio disponibile */
            }

            h2 {
                font-size: 20px; /* Riduce la dimensione del titolo */
            }
        }

        @media screen and (max-width: 430px) {
            .card {
                flex: 0 0 calc(90% - 20px); /* Adatta le card a una per riga */
                max-width: calc(90% - 20px);
            }

            .card img {
                width: 100%; /* Ridimensiona le immagini per adattarsi allo spazio disponibile */
            }

            h2 {
                font-size: 15px; /* Riduce ulteriormente la dimensione del titolo */
            }
        }

        .special_labels {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            position: absolute; /* Posizionamento assoluto rispetto alla card */
            top: 10px;
            right: 10px;
        }

        .special_label {
            background-color: #FFA500;
            color: #fff;
            padding: 5px 10px;
            border-radius: 10px;
            margin-bottom: 5px;
            font-size: 15px;
        }

        button {
            padding: 5px 10px;
            margin: 0 5px;
            border: 2px solid #FFA500;
            border-radius: 3px;
            background-color: #fff;
            cursor: pointer;
            text-align: center;
            margin-left: 50px;
            font-size: 18px;
            letter-spacing: 1px;
        }

        button:hover {
            color: white;
            background-color: #FFA500;
        }

        button:active {
            transform: scale(0.9);
        }


    </style>
   
</head>
<body>
            
    <%@include file="../header.jsp" %>
   <div class="grid-container">
   
        
    <h2>Il nostro Catalogo</h2>
    
    
    <div class="wow">
    
        
     
        &nbsp;&nbsp;
        <button class="categoria" value="Mamme e bambini"><b>Mamme e bambini</b></button>
        <button class="categoria" value="Salute e cura della persona"><b>Salute e cura della persona</b></button>
        <button class="categoria" value="Igiene e benessere"> <b>Igiene e benessere</b></button>
        
        
    </div>
    
  
    
    <div class="catalogo-container" >
   		 <div class="catalogo" id = "catalogTable">
    
    
    			</div>

			</div>
    
    
    
</div>

        <%@include file="../footer.jsp" %>
    
     <script>
     $(document).ready(function(){
     	
    	 
         
         $.ajax({
             url: 'catalogo',
             type: 'GET',
             success: function(resp) {
                 $("#catalogTable").empty();
                 for (let item of resp) {
                     let prezzoVisualizzato = calculateDiscountedPrice(item);

                     let specialLabel = "";
                     if (item.sconto > 0) { // Mostra l'etichetta solo se lo sconto è maggiore di zero
                         specialLabel = "<div class='special_labels'><div class='special_label'>" + item.sconto + " %</div></div>";
                     }

                     let cardHTML = "<div class='card'>";
                     cardHTML += "<img src='" + item.immagine + "' alt='" + item.nome + "'>";
                     cardHTML += specialLabel; // Aggiungi l'etichetta solo se lo sconto è maggiore di zero
                     cardHTML += "<p>" + item.nome + "</p>";
                     cardHTML += "<p>" + prezzoVisualizzato + "€</p>";
                     cardHTML += "<a href='details?id=" + item.id + "'><i class='fa fa-eye' aria-hidden='true'></i></a><br>";
                     cardHTML += "<a href='cart?action=add&id=" + item.id + "'><i class='fa fa-cart-plus' aria-hidden='true'></i></a>";
                     cardHTML += "</div>";

                     $("#catalogTable").append(cardHTML);
                 }
             }
         });
         
       
         
     });
     function calculateDiscountedPrice(item) {
    	    let prezzoVisualizzato = item.prezzo; // Prezzo di default da visualizzare

    	    if (item.sconto > 0) {
    	        let prezzoScontato = item.prezzo * (1 - item.sconto / 100);
    	        prezzoVisualizzato = prezzoScontato.toFixed(2); // Formatta il prezzo a due decimali
    	    }

    	    return prezzoVisualizzato;
    	}
        
      
    
    
         
     $("button.categoria").click(function() {
         var fired_button = $(this).val();
         
         $.ajax({
             url: 'catalogo?action=searchByCategory',
             type: 'GET',
             data : {category : fired_button},
             success: function(resp) {
                 $("#catalogTable").empty();
                 for (let item of resp) {
                     let prezzoVisualizzato = calculateDiscountedPrice(item);

                     let specialLabel = "";
                     if (item.sconto > 0) { // Mostra l'etichetta solo se lo sconto è maggiore di zero
                         specialLabel = "<div class='special_labels'><div class='special_label'>" + item.sconto + " %</div></div>";
                     }

                     let cardHTML = "<div class='card'>";
                     cardHTML += "<img src='" + item.immagine + "' alt='" + item.nome + "'>";
                     cardHTML += specialLabel; // Aggiungi l'etichetta solo se lo sconto è maggiore di zero
                     cardHTML += "<p>" + item.nome + "</p>";
                     cardHTML += "<p>" + prezzoVisualizzato + "€</p>";
                     cardHTML += "<a href='details?id=" + item.id + "'><i class='fa fa-eye' aria-hidden='true'></i></a> <br>";
                     cardHTML += "<a href='cart?action=add&id=" + item.id + "'><i class='fa fa-cart-plus' aria-hidden='true'></i></a>";
                     cardHTML += "</div>";

                     $("#catalogTable").append(cardHTML);
                 }
             }
         });
         
     });

         
         

     
    
        
        
       
    
    </script>
</body>
</html>
