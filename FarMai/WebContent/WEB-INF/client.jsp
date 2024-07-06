<%@ page language="java" contentType="text/html; charset=UTF-8"
    import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<%ArrayList<AddressBean> addresses = (ArrayList<AddressBean>) request.getAttribute("addresses");
  ArrayList<PaymentBean> payments = (ArrayList<PaymentBean>) request.getAttribute("payments");
  
  
  
  ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
  
  
  ArrayList<ClientBean> clients = (ArrayList<ClientBean>) request.getAttribute("clienti");
  
      if(clients == null && client.getEmail().equals("admin@farmai.it")){
          RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/userdetails");
          dispatcher.forward(request, response);
          return;
      }
  
  String error = (String) request.getAttribute("error");
  String carterror = (String) request.getAttribute("carterror");
  String clientError = (String)request.getAttribute("clientError");
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User page</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;1,100;1,200;1,300;1,400;1,500;1,600;1,700&display=swap');

body {
    font-family: "IBM Plex Sans", sans-serif;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* Stili di base per le tabelle */
table {
    width: 100%;
    border-collapse: collapse;
    margin: 20px 0;
    font-size: 18px;
    text-align: left;
}

table th,
table td {
    padding: 12px;
    border: 1px solid #ddd;
}

table tr:nth-child(even) {
    background-color: #f2f2f2;
}

table tr:hover {
    background-color: #ddd;
}

table th {
    background-color: #FFA500;
    color: white;
}

/* Allinea il testo al centro nella colonna del numero */
table .numberRow {
    text-align: center;
}

/* Layout a griglia per il contenitore principale */
.grid-container {
    display: grid;
    grid-template-columns: 1fr;
    gap: 20px;
    padding: 20px;
}

/* Stili per il form */
form {
    margin-bottom: 20px;
}

.inputBox {
    margin-bottom: 15px;
}

.inputBox label {
    display: block;
    margin-bottom: 5px;
}

.inputBox input,
.inputBox select {
    width: 100%;
    padding: 8px;
    box-sizing: border-box;
}

.inputBox.special {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.inputBox.special label {
    margin-right: 10px;
}

.submitContainer {
    text-align: right;
}

.submitContainer .submit {
    padding: 10px 20px;
    background-color: #4CAF50;
    color: white;
    border: none;
    cursor: pointer;
    transition: background-color 0.3s;
}

.submitContainer .submit:hover {
    background-color: #45a049;
}

.errorNoTranslate {
    color: red;
    margin-bottom: 10px;
}

/* Stili per il contenitore del form */
.formContainer {
    background-color: #fff;
    padding: 20px;
    border: 1px solid #ddd;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
}

.formContainer.delete {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.formContainer.delete button {
    background-color: transparent;
    border: none;
    color: red;
    cursor: pointer;
    font-size: 16px;
}

/* Media query per schermi fino a 768px di larghezza */
@media only screen and (max-width: 768px) {
    .grid-container {
        grid-template-columns: 1fr;
    }

    .inputBox input,
    .inputBox select {
        width: calc(100% - 20px);
    }
}

/* Media query per schermi fino a 600px di larghezza */
@media only screen and (max-width: 600px) {
    .grid-container {
        grid-template-columns: 1fr;
        gap: 10px;
    }

    .inputBox input,
    .inputBox select {
        width: calc(100% - 20px);
    }
}

/* Media query per schermi fino a 480px di larghezza */
@media only screen and (max-width: 480px) {
    table {
        font-size: 16px;
    }

    table th,
    table td {
        padding: 10px;
    }
}

    </style>   
	</head>
	<body>

            <%@include file="../header.jsp" %>
    <div class="grid-container">
        
<!-- -------------------- ADMIN --------------------- -->

    <%
        if(client.getEmail().equalsIgnoreCase("admin@farmai.it")) {   %>
            <link rel="stylesheet" type="text/css" href="./styles/tableStyle.css">
        
          <form action="admin" method="get">
        <input type="hidden" name="action" value="clientsNoFilter">
	<h1> FarMai utenti </h1>
    </form>

    <form action="admin?action=ByClient" method="post">
        <% if (clientError != null){%>
            <span class="errorNoTranslate"><%=clientError%></span>
            <%}%>
    
        <label for= "cliente"> Inserisci l'username dell'utente </label>
    <div class="searchbar">    
	<input name="cliente" type = "text"  placeholder = "utente" >
    </div>
	<input type="submit" value="Ordina">
    <a href="admin?action=clientsNoFilter" id="reset">Ripristina</a>

    </form>

    <table>

        <tr>
	       <th> Nome </th>
	       <th> Cognome </th>
           <th> Username </th>
	       <th class="numberRow"> Numero di telefono</th>
           <th> Email </th>
           <th> Azioni </th>
           
        </tr>


	<% for(ClientBean cliente: clients){ %>

		<tr>
			<td><%=cliente.getNome() %></td>
			<td><%=cliente.getCognome() %></td>
			<td><%=cliente.getUsername() %></td>
            <td class="numberRow"><%=cliente.getTelefono() %></td>
            <td><%=cliente.getEmail() %></td>
		<td></td>
	</tr>
	<% } %>
    </table>

    
        
<!-- -------------------- UTENTE -------------------- -->

<%    }else{  %>
    <link rel="stylesheet" type="text/css" href="./styles/multi-formStyle.css">
    
    <div class="screen-container">

	<span class="title">Profilo utente</span>
    <div class="transparentCard">
    
     <% if (carterror != null){%>
        <div class="errorNoTranslate"><%=carterror%></div>
        <%}%>
    
        <% if (error != null){%>
        <div class="errorNoTranslate"><%=error%></div>
        <%}%>
    <form class="formContainer" action="userdetails?action=modify" method="post" onsubmit="event.preventDefault(); validate(this)">

        <span class="subtitle">Modifica il tuo account</span>    
    
        <div class="inputBox">
        <span id="errorEmail" class="error"></span>
        <input id="email" name="email" type="email" maxlength="30" required value="<%=client.getEmail() %>">
        <label id="emailLabel" for="email">Email:</label>
        </div>
        
        <div class="inputBox">
        <span id="errorNome" class="error"></span>
        <input id="nome" name="nome" type="text" maxlength="30" required value="<%=client.getNome() %>">
        <label id="nomeLabel" for="nome">Nome:</label>
        </div>
        
        <div class="inputBox">
        <span id="errorCognome" class="error"></span>
        <input id="cognome" name="cognome" type="text" maxlength="30" required value="<%=client.getCognome() %>">
        <label id="cognomeLabel" for="cognome">Cognome:</label>
        </div>
        
        <div class="inputBox">
        <span id="errorCf" class="error"></span>
        <input id="cf" name="cf" type="text" maxlength="16" required value="<%=client.getCf() %>">
        <label id="cfLabel" for="cf">CF:</label>
        </div>
        
        <div class="inputBox">
        <span id="errorIndirizzo" class="error"></span>
        <input id="indirizzo" name="indirizzo" type="text" maxlength="50" required value="<%=client.getVia() %>">
        <label id="indirizzoLabel" for="indirizzo">Indirizzo:</label>
        </div>
        
        <div class="inputBox">
        <span id="errorCitta" class="error"></span>
        <input id="citta" name="citta" type="text" maxlength="40" required value="<%=client.getCitta() %>">
        <label id="cittaLabel" for="citta">Città:</label>
        </div>
        
        <div class="inputBox">
        <span id="errorProvincia" class="error"></span>
        <input id="provincia" name="provincia" type="text" maxlength="40" required value="<%=client.getProvincia() %>">
        <label id="provinciaLabel" for="provincia">Provincia:</label>
        </div>
        
        <div class="inputBox">
        <span id="errorCap" class="error"></span>
        <input id="cap" name="cap" type="text" maxlength="5" required value="<%=client.getCap() %>">
        <label id="capLabel" for="cap">CAP:</label>
        </div>
        
        <div class="inputBox">
        <span id="errorTelefono" class="error"></span>
        <input id="telefono" name="telefono" type="text" maxlength="15" required value="<%=client.getTelefono() %>">
        <label id="telefonoLabel" for="telefono">Numero di telefono:</label>
        </div>
        
        <div class="submitContainer">
            <input class="submit" type="submit" value="Invia">
        </div>
    </form> 
    
  
    <% if (payments != null){ %>
  
                       
         <%  for(int i=0; i<payments.size(); i++) { %>
             <span class="subtitle">Elimina la tua carta</span> 
             <form class="formContainer delete" action="userdetails?action=deletePaymentCard" method="post">
         
             <label for="payment" ><%="****" + payments.get(i).getNumero_carta().substring(payments.get(i).getNumero_carta().length()-4) %></label>
				<input type="hidden" name="id_carta" value = "<%= payments.get(i).getId()%>">
                <button value="Delete this card" id = "payment"><i class="fa fa-trash" aria-hidden="true"></i></button>
                
            </form>

        <% } %> 
      
    <% } %>
    
    <form class="formContainer" action="userdetails?action=addPaymentCard" method="post" onsubmit="event.preventDefault(); validate_payment(this)">
    	
        <span class="subtitle">Inserisci la tua carta qui</span>
        
        
        <!-- aggiungi carta alla sessione -->

            <div class="inputBox">
            <span id="errorNumero_carta" class="error"></span>
            <input id="numero_carta" name="numero_carta" type="text" maxlength="50" required placeholder="Inserisci il numero">
            <label id="numero_cartaLabel" for="numero_carta">Numero della carta:</label>
            </div>

            <div class="inputBox">
            <span id="errorCvv" class="error"></span>
            <input id="cvv" name="cvv" type="text" maxlength="50" required placeholder="123">
            <label id="cvvLabel" for="cvv">CVV:</label>
            </div>
            
            <div class="inputBox special">
            <label for="data_scadenza">Data di scadenza:</label>
            <input name="data_scadenza" type="date" maxlength="50" required placeholder="dd/mm/yyyy">
            <span id="errorData_scadenza" class="error"></span>
            </div>
            
            <div class="inputBox special">
            <label for="circuito">Meotodo di pagamento:</label>
            <select name="circuito" id="circuito">
                <option value="PayPal"> Paypal </option>
                <option value="Mastercard">MasterCard </option>
                <option value="VISA">VISA </option>
                <option value="PostePay">Postepay </option>
                <option value="American Express">American Express </option>
                <option value="Bancomat">Bancomat </option>
            </select>
        </div>
        
        <div class="submitContainer">
            <input class="submit" type="submit" value="Aggiungi">
        </div>
    </form>
    
    
    <% if (addresses != null){ %>
            
        
    
         <%  for(int i=0; i<addresses.size(); i++) { %>
                 <span class="subtitle">Elimina il tuo indirizzo</span>
                <form class="formContainer delete" action="userdetails?action=deleteAddress" method="post">
    
                 
                <label for="address"><%=addresses.get(i).getVia() + " " + addresses.get(i).getCitta() %></label>
				<input type="hidden" name="id_indirizzo" value = "<%= addresses.get(i).getId()%>">
                <button value="Delete this address"  id ="address"><i class="fa fa-trash" aria-hidden="true"></i></button>
                
                </form>

        <% } %> 
    
    <% } %>
    
    <form class="formContainer" action="userdetails?action=addAddress" method="post" onsubmit="event.preventDefault(); validate_address(this)">

        <span class="subtitle">Inserisci il tuo indirizzo qui</span>   
            
            <div class="inputBox">
            <span id="errorVia_indirizzo" class="error"></span>
            <input id="via_indirizzo" name="via_indirizzo" type="text" maxlength="50" required placeholder="Inserisci la via">
            <label id="via_indirizzoLabel" for="via_indirizzo">Via:</label>
            </div>
            
            <div class="inputBox">
            <span id="errorCitta_indirizzo" class="error"></span>
            <input id="citta_indirizzo" name="citta_indirizzo" type="text" maxlength="50" required placeholder="Londra">
            <label id="citta_indirizzoLabel" for="citta_indirizzo">Città:</label>
            </div>

            <div class="inputBox">
            <span id="errorCAP_indirizzo" class="error"></span>
            <input id="CAP_indirizzo" name="CAP_indirizzo" type="text" maxlength="50" required placeholder="00000">
            <label id="CAP_indirizzoLabel" for="CAP_indirizzo">CAP:</label>
            </div>
        
            <div class="submitContainer">
                <input class="submit" type="submit" value="Aggiungi">
            </div>
        
    </form>
</div> 
</div>  
    
<% } %>

    
    

</div>

        <%@include file="../footer.jsp" %>

      <script>
          $(document).ready(function () {

              $("#email").on("input", function() {
                  if ($("#email").val().length !== 0)
          $("#emailLabel").addClass("notEmpty");
          else
          $("#emailLabel").removeClass("notEmpty");
              });

              $("#cap").on("input", function() {
                  if ($("#cap").val().length !== 0)
          $("#capLabel").addClass("notEmpty");
          else
          $("#capLabel").removeClass("notEmpty");
              });

              $("#nome").on("input", function() {
                  if ($("#nome").val().length !== 0)
          $("#nomeLabel").addClass("notEmpty");
          else
          $("#nomeLabel").removeClass("notEmpty");
              });

              $("#cognome").on("input", function() {
                  if ($("#cognome").val().length !== 0)
          $("#cognomeLabel").addClass("notEmpty");
          else
          $("#cognomeLabel").removeClass("notEmpty");
              });

              $("#cf").on("input", function() {
                  if ($("#cf").val().length !== 0)
          $("#cfLabel").addClass("notEmpty");
          else
          $("#cfLabel").removeClass("notEmpty");
              });

              $("#indirizzo").on("input", function() {
                  if ($("#indirizzo").val().length !== 0)
          $("#indirizzoLabel").addClass("notEmpty");
          else
          $("#indirizzoLabel").removeClass("notEmpty");
              });

              $("#citta").on("input", function() {
                  if ($("#citta").val().length !== 0)
          $("#cittaLabel").addClass("notEmpty");
          else
          $("#cittaLabel").removeClass("notEmpty");
              });

              $("#provincia").on("input", function() {
                  if ($("#provincia").val().length !== 0)
          $("#provinciaLabel").addClass("notEmpty");
          else
          $("#provinciaLabel").removeClass("notEmpty");
              });

              $("#telefono").on("input", function() {
                  if ($("#telefono").val().length !== 0)
          $("#telefonoLabel").addClass("notEmpty");
          else
          $("#telefonoLabel").removeClass("notEmpty");
              });

              $("#via_indirizzo").on("input", function() {
                  if ($("#via_indirizzo").val().length !== 0)
          $("#via_indirizzoLabel").addClass("notEmpty");
          else
          $("#via_indirizzoLabel").removeClass("notEmpty");
              });
              
              $("#citta_indirizzo").on("input", function() {
                  if ($("#citta_indirizzo").val().length !== 0)
          $("#citta_indirizzoLabel").addClass("notEmpty");
          else
          $("#citta_indirizzoLabel").removeClass("notEmpty");
              });
              
              $("#CAP_indirizzo").on("input", function() {
                  if ($("#CAP_indirizzo").val().length !== 0)
          $("#CAP_indirizzoLabel").addClass("notEmpty");
          else
          $("#CAP_indirizzoLabel").removeClass("notEmpty");
              });
              
              $("#cvv").on("input", function() {
                  if ($("#cvv").val().length !== 0)
          $("#cvvLabel").addClass("notEmpty");
          else
          $("#cvvLabel").removeClass("notEmpty");
              });
              
              $("#numero_carta").on("input", function() {
                  if ($("#numero_carta").val().length !== 0)
          $("#numero_cartaLabel").addClass("notEmpty");
          else
          $("#numero_cartaLabel").removeClass("notEmpty");
              });

          })

      
    function validate(obj) {	
        let valid = true;	

        let email = document.getElementsByName("email")[0];    
        let errorEmail = document.getElementById('errorEmail');
        if(!checkEmail(email)) {
            valid = false;
            errorEmail.textContent = "Error: invalid email address"; 
        } else {
            errorEmail.textContent = ""; 
        }

       let name = document.getElementsByName("nome")[0];
       let errorNome = document.getElementById('errorNome');
        if(!checkLettere(name)) {
            valid = false;
            errorNome.textContent = "Error: name must contain only alphabetic characters"; 
        } else {
            errorNome.textContent = ""; 
        }

        let surname = document.getElementsByName("cognome")[0];
        let errorCognome = document.getElementById('errorCognome');
        if(!checkLettere(surname)) {
            valid = false;
            errorCognome.textContent = "Error: surname must contain only alphabetic characters"; 
        } else {
            errorCognome.textContent = ""; 
        }

        let cf = document.getElementsByName("cf")[0];
        let errorCf = document.getElementById('errorCf');
        if(!checkCf(cf)) {
            valid = false;
            errorCf.textContent = "Error: invalid CF format"; 
        } else {
            errorCf.textContent = ""; 
        }

        let indirizzo = document.getElementsByName("indirizzo")[0];
        let errorIndirizzo = document.getElementById('errorIndirizzo');
        if(!checkIndirizzo(indirizzo)) {
            valid = false;
            errorIndirizzo.textContent = "Error: invalid street format"; 
        } else {
            errorIndirizzo.textContent = ""; 
        }

        let citta = document.getElementsByName("citta")[0];
        let errorCitta = document.getElementById('errorCitta');
        if(!checkLettere(citta)) {
            valid = false;
            errorCitta.textContent = "Error: city must contain only alphabetic characters"; 
        } else {
            errorCitta.textContent = ""; 
        }

        let provincia = document.getElementsByName("provincia")[0];
        let errorProvincia = document.getElementById('errorProvincia');
        if(!checkLettere(provincia)) {
            valid = false;
            errorProvincia.textContent = "Error: province must contain only alphabetic characters"; 
        } else {
            errorProvincia.textContent = ""; 
        }

        let cap = document.getElementsByName("cap")[0];
        let errorCap = document.getElementById('errorCap');
        if(!checkCap(cap)) {
            valid = false;
            errorCap.textContent = "Error: CAP must contain 5 numbers"; 
        } else {
            errorCap.textContent = ""; 
        }

        let telefono = document.getElementsByName("telefono")[0];    
        let errorTelefono = document.getElementById('errorTelefono');
        if(!checkTelefono(telefono)) {
            valid = false;
            errorTelefono.textContent = "Error: invalid cellphone number format"; 
        } else {
            errorTelefono.textContent = ""; 
        }
        
        if(valid) obj.submit();
    }
      
    function validate_payment(obj){
        
        let valid = true;
        
        let numero_carta = document.getElementsByName("numero_carta")[0];    
        let errorNumero_carta = document.getElementById('errorNumero_carta');
        if(!checkNumero_carta(numero_carta)) {
            valid = false;
            errorNumero_carta.textContent = "Error: card number must be between 13 and 19 digits"; 
        } else {
            errorNumero_carta.textContent = ""; 
        }
        
        let cvv = document.getElementsByName("cvv")[0];
        let errorCvv = document.getElementById('errorCvv');
        if(!checkCvv(cvv)) {
            valid = false;
            errorCvv.textContent = "Error: Cvv must contain only three numbers"; 
        } else {
            errorCvv.textContent = ""; 
        }
        
        let data_scadenza = document.getElementsByName("data_scadenza")[0];
        let errorData_scadenza = document.getElementById('errorData_scadenza');
        if(!checkData(data_scadenza)) {
            valid = false;
            errorData_scadenza.textContent = "Error: date formant must be dd/MM/yyyy"; 
        } else {
            errorData_scadenza.textContent = ""; 
        }
        
        if(valid) obj.submit();
    }
      
        function validate_address(obj){

            let valid = true;
            let indirizzo = document.getElementsByName("via_indirizzo")[0];
            let errorVia_indirizzo = document.getElementById('errorVia_indirizzo');
        if(!checkIndirizzo(indirizzo)) {
            valid = false;
            errorVia_indirizzo.textContent = "Error: invalid street format"; 
        } else {
            errorVia_indirizzo.textContent = ""; 
        }

        let citta = document.getElementsByName("citta_indirizzo")[0];
        let errorCitta_indirizzo = document.getElementById('errorCitta_indirizzo');
        if(!checkLettere(citta)) {
            valid = false;
            errorCitta_indirizzo.textContent = "Error: city must contain only alphabetic characters"; 
        } else {
            errorCitta_indirizzo.textContent = ""; 
        }
        let cap = document.getElementsByName("CAP_indirizzo")[0];
        let errorCAP_indirizzo = document.getElementById('errorCAP_indirizzo');
            if(!checkCap(cap)) {
                valid = false;
                errorCAP_indirizzo.textContent = "Error: CAP must contain 5 numbers"; 
            } else {
                errorCAP_indirizzo.textContent = ""; 
            }
            
            if(valid) obj.submit();

        }  

    function checkEmail(inputtxt) {
        let email = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
        if(inputtxt.value.match(email)) 
		    return true;

        return false;	
    }

    function checkPsw(inputtxt) {
        //almeno una lettera, almeno una cifra, da 6 a 20 caratteri
        let psw = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,20}$/;
        if(inputtxt.value.match(psw)) 
		    return true;

        return false;	
    }

    function checkUsername(inputtxt) {
        let username = /^[a-zA-Z0-9_-]{6,20}$/;
        if(inputtxt.value.match(username)) 
		    return true;

        return false;	
    }

    function checkLettere(inputtxt) {
        let name = /^[A-Za-z ]+$/;
        if(inputtxt.value.match(name)) 
		    return true

        return false;	
    }

    function checkCf(inputtxt) {
        let cf = /^[A-Z]{6}[0-9]{2}[A-Z][0-9]{2}[A-Z][0-9]{3}[A-Z]$/;
        if(inputtxt.value.match(cf)) 
		    return true

        return false;	
    }

    function checkIndirizzo(inputtxt) {
        let indirizzo = /^([A-Za-z]+\s)+\d+$/;
        if(inputtxt.value.match(indirizzo)) 
		    return true

        return false;	
    }

    function checkCap(inputtxt) {
        let cap = /^\d{5}$/;
        if(inputtxt.value.match(cap)) 
		    return true

        return false;	
    }

    function checkTelefono(inputtxt) {
        let telefono = /^\d{10}$/;
        if(inputtxt.value.match(telefono)) 
		return true;

        return false;
    }
      
    function checkNumero_carta(inputtxt) {
        let numero_carta = /^\d{13,19}$/;
        if(inputtxt.value.match(numero_carta)) 
		    return true;

        return false;	
    }
      
     function checkCvv(inputtxt) {
         let cvv = /^\d{3}$/;
         if(inputtxt.value.match(cvv)) 
		    return true;

         return false;	
     }
      
     function checkData(inputtxt) {
         let date = /^\d{4}\-\d{2}\-\d{2}$/;
         if(inputtxt.value.match(date)) 
		    return true;

         return false;	
     }

    </script>
    
</body>
</html>