<%@ page language="java" contentType="text/html; charset=UTF-8"
import="java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>
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

        .input {
            margin-bottom: 2%;
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
            position: relative;
            left: 62%;
            border: none;
            border-radius: 25px;
            padding: 15px 30px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .checkbox {
            padding: 1%;
            position: relative;
            left: 61%;
            font-family: "IBM plex Sans";
            font-size: 20px;         
            color: #333333;
        }

        .submit:hover {
            background-color: #333333;
        }
        input, textarea 
        {
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            transition: all 0.3s ease;
        }

        input:focus, textarea:focus 
        {
            border-color: #FFA500;
            box-shadow: 0 0 5px rgba(255,165,0, 0.5);
            outline: none;
        }

        .error-message {
            color: red;
            font-size: 16px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <%@include file="../header.jsp" %>
    <div class="container">
        <% String errorMessage = (String) request.getAttribute("errorMessage"); 
           if (errorMessage != null) { %>
            <div class="error-message"><%= errorMessage %></div>
        <% } %>
        <div class="column">
            <h3>Si prega di effettuare l'accesso qualora si abbia già un account.</h3>
            <h1 class="title">Dettagli Personali</h1>
            <form action="register" method="post">
                <div class="allinea">
                    <label for="username">*Username:</label>
                    <input class="input" id="username" type="text" name="username" placeholder="Username.." required>
                    <label for="name">*Nome:</label>
                    <input class="input" id="nome" type="text" name="nome" placeholder="Nome..." required>
                    <label for="surname">*Cognome:</label>
                    <input class="input" id="cognome" type="text" name="cognome" placeholder="Cognome..." required>
                    <label for="cf">*CF:</label>
                    <input class="input" id="cf" type="text" name="cf" placeholder="Codice Fiscale..." required size="16">
                    <label for="email">*E-Mail:</label>
                    <input class="input" id="email" type="email" name="email" placeholder="Email..." required>
                    <label for="telefono">*Telefono:</label>
                    <input class="input" id="telefono" type="number" name="telefono" placeholder="Telefono..." required size="10">
                </div>
                <h1 class="title">I tuoi indirizzi</h1><br>
                <div class="allinea">
                    <label for="indirizzo">*Indirizzo:</label>
                    <input class="input" id="indirizzo" type="text" name="indirizzo" placeholder="Indirizzo..." required>
                    <label for="citta">*Città:</label>
                    <input class="input" id="citta" type="text" name="citta" placeholder="Città..." required>
                    <label for="cap">*CAP:</label>
                    <input class="input" id="cap" type="number" name="cap" placeholder="CAP..." size="5" required>
                    <label for="provincia">*Provincia:</label>
                    <input class="input" id="provincia" type="text" name="provincia" placeholder="Provincia..." size="5" required>
                </div>
                <h1 class="title">La Tua Password</h1><br>
                <div class="allinea">
                    <label for="pwd">*Password:</label>
                    <input class="input" id="password" type="password" name="password" placeholder="Password..." required>
                    <label for="cpwd">*Conferma password:</label>
                    <input class="input" id="password" type="password" name="password" placeholder="Conferma password..." required>
                </div>
                <input class="checkbox" type="checkbox" id="privacy" name="privacy" required>
                <label class="checkbox" for="privacy">Ho letto e accetto <b>Privacy e Cookie</b></label>         
                
                <input type="hidden" name="action" value="register">      
                <input class="submit" type="submit" value="Registrati"> 
            </form>
        </div>
    </div>
    <%@include file="../footer.jsp" %>
</body>
</html>
