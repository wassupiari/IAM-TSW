<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SignUp</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;1,100;1,200;1,300;1,400;1,500;1,600;1,700&display=swap'); 

        html,body {
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
            flex-wrap: wrap;
        }

        .column {
            width: 100%;  
            height: 100%;
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;  
            margin: 1%; 
        }

        h3 {
            font-weight: normal;
        }

        .allinea {
            display: grid;
            grid-template-columns: 10% 90%;
            gap: 10px;
            align-items: left;
        }

        .title {
            position: relative;
            display: inline-block;
            color: #333333;
            font-size: 45px;
        }

        .title::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: -5px;
            width: 30%;
            height: 5px;
            background: linear-gradient(to right, #A0C49D, #E6F2E0);
            border-radius: 2px;
        }

        label {
            font-family: "IBM plex Sans";
            font-size: 20px;
            color: #333333;
        }

        .input
        {
        	margin-bottom:2%;
            width: 100%;
            height: auto;
            font-family: "IBM plex Sans";
            font-size: 20px;
            border: none;
            border-bottom: 2px groove #A0C49D;
            color: #333333;
        }

        .submit {
            margin-top: 2%;
            background-color: #FFA500;
            color: white;
            width: 10%;
            height: auto;
            position:relative;
        	left:62%;
            border: none;
            border-radius: 25px;
            padding: 15px 30px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .checkbox {
        	padding:1%;
        	position:relative;
        	left:61%;
            font-family: "IBM plex Sans";
            font-size: 20px;         
            color: #333333;
        }

        .submit:hover {
            background-color: #333333;
        }
    </style>
</head>
<body>
    <%@include file="../header.jsp" %>
    <div class="container">
        <div class="column">
            <h3>Si prega di effettuare l'accesso qualora si abbia già un account.</h3>
            <h1 class="title">Dettagli Personali</h1>
            <form action="">
            	<div class="allinea">
	                <label for="name">*Nome:</label>
	                <input class="input" id="name" type="text" name="name" placeholder="Nome..." required>
	                <label for="surname">*Cognome:</label>
	                <input class="input" id="surname" type="text" name="surname" placeholder="Cognome..." required>
	                <label for="email">*E-Mail:</label>
	                <input class="input" id="email" type="email" name="email" placeholder="Email..." required>
	                <label for="telefono">*Telefono:</label>
	                <input class="input" id="telefono" type="number" name="telefono" placeholder="Nome..." required size="10">
	                <label for="fax">FAX:</label>
	                <input class="input" id="fax" type="number" name="fax" placeholder="FAX...">
                </div>
                <h1 class="title">I tuoi indirizzi</h1><br>
               	<div class="allinea">
            		<label for="azienda">Azienda:</label>
            		<input class="input" id="azienda" type="text" name="azienda" placeholder="Azienda...">
            		<label for="indirizzo1">*Indirizzo 1:</label>
            		<input class="input" id="indirizzo1" type="text" name="indirizzo1" placeholder="Indirizzo1..." required>
            		<label for="indirizzo2">Indirizzo2:</label>
            		<input class="input" id="indirizzo2" type="text" name="inirizzo2" placeholder="Indirizzo2...">
            		<label for="citta">*Città:</label>
            		<input class="input" id="citta" type="text" name="citta" placeholder="Città..." required>
            		<label for="CAP">*CAP:</label>
            		<input class="input" id="CAP" type="number" name="CAP" placeholder="CAP..." size="5" required>
            		<label for="country">*Paese:</label>
			        <select class="input" id="country" name="country">
			            <option value="">--Seleziona un paese--</option>
			            <option value="italia">Italia</option>
			            <option value="francia">Francia</option>
			            <option value="germania">Germania</option>
			            <option value="spagna">Spagna</option>
			            <option value="regno_unito">Regno Unito</option>
			        </select>
			        <label for="province">*Provincia:</label>
			        <select class="input"  id="province" name="province" required>
			            <option value="">--Seleziona una provincia--</option>
			            <!-- Province italiane -->
			            <optgroup label="Italia">
			                <option value="roma">Roma</option>
			                <option value="milano">Milano</option>
			                <option value="avellino">Avellino</option>
			                <option value="napoli">Napoli</option>
			                <option value="salerno">Salerno</option>
			                <option value="caserta">Caserta</option>
			                <option value="benevento">Benevento</option>
			                <option value="torino">Torino</option>
			                <option value="firenze">Firenze</option>
			            </optgroup>
			            <!-- Province francesi -->
			            <optgroup label="Francia">
			                <option value="parigi">Parigi</option>
			                <option value="marsiglia">Marsiglia</option>
			                <option value="lione">Lione</option>
			                <option value="tolosa">Tolosa</option>
			                <option value="nizza">Nizza</option>
			            </optgroup>
			            <!-- Province tedesche -->
			            <optgroup label="Germania">
			                <option value="berlino">Berlino</option>
			                <option value="amburgo">Amburgo</option>
			                <option value="monaco">Monaco</option>
			                <option value="colonia">Colonia</option>
			                <option value="francoforte">Francoforte</option>
			            </optgroup>
			            <!-- Province spagnole -->
			            <optgroup label="Spagna">
			                <option value="madrid">Madrid</option>
			                <option value="barcellona">Barcellona</option>
			                <option value="valencia">Valencia</option>
			                <option value="sevilla">Siviglia</option>
			                <option value="zaragoza">Saragozza</option>
			            </optgroup>
			            <!-- Province del Regno Unito -->
			            <optgroup label="Regno Unito">
			                <option value="londra">Londra</option>
			                <option value="manchester">Manchester</option>
			                <option value="birmingham">Birmingham</option>
			                <option value="glasgow">Glasgow</option>
			                <option value="liverpool">Liverpool</option>
			            </optgroup>
			        </select>
					<label for="CF">*Codice Fiscale:</label>
            		<input class="input" id="CF" type="text" name="CF" placeholder="Codice Fiscale..." required size="16">
            		<label for="PartitaIVA">Partita IVA:</label>
            		<input class="input" id="PartitaIVA" type="text" name="PartitaIVA" placeholder="Partita IVA...">
           		</div>
            	<h1 class="title">La Tua Password</h1><br>
            	<div class="allinea">
            		<label for="pwd">*Password:</label>
            		<input class="input" id="pwd" type="password" name="pwd" placeholder="Password..." required>
            		<label for="cpwd">*Conferma password:</label>
            		<input class="input" id="cpwd" type="password" name="cpwd" placeholder="Conferma password..." required>
            	</div>
            	<h1 class="title">Newsletter</h1><br>
            		<label>sottoscrivi:</label>
            		<input  type="radio" id="si" name="news" value="si">
  					<label  for="html">si</label>
  					<input  type="radio" id="no" name="news" value="no">
  					<label  for="no">no</label><br>
					<input class="checkbox" type="checkbox" id="privacy" name="privacy">
					<label class="checkbox" for="privacy">Ho letto e accetto <b>Privacy e Cookie</b></label>			
            		<input class="submit" type="submit" value="Registrati">			
            	</form>
    		</div>
    	</div>
    	<%@include file="../footer.jsp" %>
	</body>
</html>