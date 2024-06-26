<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, it.unisa.model.*"%>

<%ArrayList<AddressBean> addresses = (ArrayList<AddressBean>) request.getAttribute("addresses");
 ArrayList<PaymentBean> payments = (ArrayList<PaymentBean>) request.getAttribute("payments");

  String error = (String) request.getAttribute("error");
  %>


  <!DOCTYPE html>
  <html lang="en">
  <head>
   <meta content="width=device-width, initial-scale=1" name="viewport" />
   <meta charset="UTF-8">
   <title>Checkout</title>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   <link rel="stylesheet" href="styles/formStyle.css" type="text/css">

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

.grid-container {
    display: flex;
    flex-direction: column;
    flex-grow: 1;
    max-width: 90%;
    margin: 0 auto;
}



.container {
    flex-grow: 1;
    padding: 20px;
}

.transparentCard {
    background: white;
    border-radius: 8px;
    box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
    padding: 20px;
    margin-top: 20px;
}

.title {
    font-size: 24px;
    font-weight: 500;
    margin-bottom: 40px;
    color: #333;
}

.errorNoTranslate {
    color: red;
    margin-bottom: 15px;
}

.inputBox {
    position: relative;
    margin-bottom: 30px;
}

.inputBox input, .inputBox select, .inputBox textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
    margin-top: 5px;
}

.inputBox label {
    font-size: 14px;
    color: #666;
}

.inputBox.special {
    margin-bottom: 15px;
}

.inputBox.special label {
    margin-right: 10px;
    font-size: 16px;
    color: #333;
}

.submitContainer {
    text-align: center;
}

.submit {
    display: inline-block;
    background-color: #333;
    color: #fff;
    padding: 10px 30px;
    border-radius: 5px;
    transition: background-color 0.3s ease;
    border: none;
    font-size: 16px;
    cursor: pointer;
}

.submit:hover {
    background-color: #FFA500;
    box-shadow: rgba(0, 0, 0, 0.15) 0 3px 9px 0;
    transform: translateY(-2px);
}

.error {
    color: red;
    font-size: 14px;
    margin-top: 5px;
}

input[type="radio"], input[type="checkbox"] {
    margin-right: 10px;
}

#destinatarioLabel.notEmpty {
    font-weight: bold;
}

@media (min-width: 768px) {
    .submit {
        padding: 10px 30px;
    }
}

@media screen and (max-width: 700px) {
    .title {
        font-size: 20px;
    }

    .inputBox label {
        font-size: 12px;
    }
}
    

   </style>

  </head>
  <body>
   <%@include file="/header.jsp" %>
   <div class="grid-container">
   
     

   <form action="payment" method="post" onsubmit="event.preventDefault(); validate(this)">  
    <div class="container">
     <div class="transparentCard">
      <span class="title">Checkout</span> 

      <% if (error != null){%>
       <div class="errorNoTranslate"><%=error%></div>
       <%}%>

       <input type="hidden" name="action" value="confirm_buy">

       <div class="inputBox">
        <span class="error" id="errorDestinatario"></span>
        <label id="destinatarioLabel" for="destinatario">Destinatario:</label>
        <input id="destinatario" name="destinatario" type="text" maxlenght="30" required autocomplete="off" placeholder="destinatario" >
        
       </div>

       <div class="inputBox">
       <label for="note">Nota per l'ordine:</label>
        <input name="note" type="text" maxlenght="100" autocomplete="off" placeholder="Nota..">
        
       </div>

       <div class="inputBox special">
        <label for="spedizione">Shipping:</label>
        <input type="hidden" name="action" value="spedizione">
        <input type="radio" id ="1"  name="spedizione" value="Ritiro in negozio" required>
        <label for="1">Standard Shipping (7 - 10  Business Days)</label>
        <input type="radio" id="2" name="spedizione" value="Spedizione standard"  required>
        <label for="2">Economic Shipping (12 - 15  Business Days) </label>
        <input type="radio" id="3" name="spedizione" value="Spedizione express" required>
        <label for="3">Express Shipping (3 - 5  Business Days) ( <b>€5</b> )</label>    
       </div>


       <div class="inputBox special">
        <label for="regalo">Gift:</label><br>
        <input name="regalo" type="checkbox" value="true">
       </div> 

       <div class="inputBox special">
        <input type="hidden" name="action" value="metodo_di_pagamento">
        <input type="radio" id ="1"  name="metodo_di_pagamento" value="carta_di_credito" required onchange="enableCard()">
        <label for="1">Credit card</label>
        <input type="radio" id="2" name="metodo_di_pagamento" value="carta_di_debito"  required onchange="enableCard()">
        <label for="2">Charge card </label>
        <input type="radio" id="3" name="metodo_di_pagamento" value="Paypal" required onchange="enableCard()">
        <label for="3">Paypal</label>       
       </div>

       <div class="inputBox special">
        <label for="carta">Insert card:</label>
        <select name="carta" id="carta" disabled >

         <% if (payments != null) {
    for(int i=0; i<payments.size(); i++) {
        String lastFourDigits = "";
        if (payments.get(i).getNumero_carta() != null && payments.get(i).getNumero_carta().length() >= 4) {
            lastFourDigits = "****" + payments.get(i).getNumero_carta().substring(payments.get(i).getNumero_carta().length()-4);
        }
%>
        <option value="<%= payments.get(i).getId()%>"><%= lastFourDigits %></option>
<% } } %>


         </select>
        </div>

        <div class="inputBox special">
         <label for="indirizzo">Insert shipping address:</label><br>
	<select name="indirizzo" id="indirizzo">
	    <% if (addresses != null) {
	        for(int i=0; i<addresses.size(); i++) { %>
	            <option value="<%= addresses.get(i).getId() %>"><%= addresses.get(i).getVia() + " " + addresses.get(i).getCitta() %></option>
	    <% } } %>
	</select>

         </div>

         <div class="submitContainer">
          <input class="submit" type="submit" value="Pay">
         </div>
        </div>
       </div>
      </form>

      
       
     

     </div>     
      <%@include file="/footer.jsp" %>
      <script>
       $(document).ready(function () {

        $("#destinatario").on("input", function() {
         if ($("#destinatario").val().length !== 0)
                $("#destinatarioLabel").addClass("notEmpty");
                else
                $("#destinatarioLabel").removeClass("notEmpty");
        });

       })
      
       function validate(obj) {	
        let valid = true;	

        let addressee = document.getElementsByName("destinatario")[0];
        let errorDestinatario = document.getElementById('errorDestinatario');
        if(!checkLettere(addressee)) {
         valid = false;
         errorDestinatario.textContent = "Error: addressee must contain only alphabetic characters"; 
        } else {
         errorDestinatario.textContent = ""; 
        }

        if(valid) obj.submit();
       }


       function checkLettere(inputtxt) {
        let addressee = /^[A-Za-z ]+$/;
        if(inputtxt.value.match(addressee)) 
        return true

        return false;	
       }

       function enableCard() {
        var radio1 = document.getElementById('1'); 
        var radio2 = document.getElementById('2'); 
        var radio3 = document.getElementById('3'); 
        var carta = document.getElementById('carta'); 

        if (radio1.value !== '' || radio2.value !== '' || radio3.value !== '' ) {  
         carta.disabled = false;  
        }
       } 

      </script>
     </body>
     </html>