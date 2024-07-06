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
    max-width: 1200px; /* Limita la larghezza per migliorare la leggibilità */
    margin: 0 auto; /* Centra il contenuto */
    padding: 20px;
    box-sizing: border-box;
}

/* Intestazione del catalogo */
h2 {
    font-size: 30px;
    color: #333;
    text-align: center; /* Centra l'intestazione */
    margin-bottom: 20px;
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
    margin: 10px;
    text-align: center;
    padding: 20px;
    transition: transform 0.2s ease;
    position: relative;
}

.card:hover {
    border-color: #FFA500; /* Cambia il colore del bordo al passaggio del mouse */
    transform: scale(1.03);
}

.card img {
    width: 80%;
    height: auto;
    transition: transform 0.2s;
}

.card p,
.card a {
    font-weight: bold;
    font-size: 18px;
    color: #333;
}

.card a {
    display: inline-block;
    margin-top: 10px;
    padding: 5px 10px;
    border: 2px solid #FFA500;
    border-radius: 10px;
    transition: background-color 0.3s, color 0.3s;
    text-decoration: none;
    color: black;
}

.card a:hover {
    color: white;
    background-color: #FFA500;
}

/* Media query per dimensioni dello schermo più piccole */
@media screen and (max-width: 1200px) {
    .card {
        flex: 0 0 calc(33.33% - 20px); /* Ridimensiona le card per adattarsi a tre per riga */
        max-width: calc(33.33% - 20px);
    }
}

@media screen and (max-width: 880px) {
    .card {
        flex: 0 0 calc(50% - 20px); /* Ridimensiona le card per adattarsi a due per riga */
        max-width: calc(50% - 20px);
    }
}

@media screen and (max-width: 600px) {
    .card {
        flex: 0 0 calc(100% - 20px); /* Adatta le card a una per riga */
        max-width: calc(100% - 20px);
    }

    h2 {
        font-size: 24px; /* Riduci la dimensione del titolo su schermi più piccoli */
        margin-left: 0; /* Resetta il margine a sinistra */
    }

    .catalogo {
        justify-content: center; /* Centra le card su schermi più piccoli */
    }
}

/* Stili aggiuntivi per le etichette speciali */
.special_labels {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    position: absolute;
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

/* Stili per i pulsanti di categoria */
button {
    padding: 10px 20px;
    margin: 10px;
    border: 2px solid #FFA500;
    border-radius: 3px;
    background-color: #fff;
    cursor: pointer;
    text-align: center;
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
    <div class="catalogo-container">
        <h2>Il nostro Catalogo</h2>
        <div>
            <button class="categoria" value="Mamme e bambini"><b>Mamme e bambini</b></button>
            <button class="categoria" value="Salute e cura della persona"><b>Salute e cura della persona</b></button>
            <button class="categoria" value="Igiene e benessere"><b>Igiene e benessere</b></button>
        </div>
        <div class="catalogo" id="catalogTable">
        
        </div>
    </div>
    <%@include file="../footer.jsp" %>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
