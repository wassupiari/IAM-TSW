<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="it">
<head>
    <title>Errore</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        
        .error-container {
            text-align: center;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: 80%;
            max-width: 600px;
        }
        
        .error-img {
            width: 100px; /* Imposta la larghezza dell'immagine */
            height: auto; /* Lascia che l'altezza si adatti proporzionalmente */
            margin-bottom: 20px; /* Aggiunge spazio sotto l'immagine */
        }
        
        p {
            margin-top: 20px; /* Aggiunge spazio sopra i paragrafi */
            line-height: 1.6; /* Imposta l'interlinea */
        }
        
        a {
            text-decoration: none; /* Rimuove il sottolineato dagli elementi di link */
            color: #007bff; /* Imposta il colore del testo del link */
        }
        
        a:hover {
            text-decoration: underline; /* Sottolinea il testo del link al passaggio del mouse */
        }
    </style>
    
</head>
<body>
    <div class="error-container">
        <h3>Ops... Qualcosa è andato storto!</h3>
        <img src="images/error.png" class="error-img" alt="Errore">
        <p>Sei sicuro di essere registrato? Se no, prova a <a href="register">registrarti <i class="fa fa-user-plus" aria-hidden="true"></i></a>.</p>
        <p>Se sei già registrato o hai inserito le credenziali di accesso sbagliate, riprova a <a href="login">effettuare il login <i class="fa fa-sign-in" aria-hidden="true"></i></a>.</p>
    </div>
</body>
</html>
