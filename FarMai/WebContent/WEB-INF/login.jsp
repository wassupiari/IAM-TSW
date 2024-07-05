<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;1,100;1,200;1,300;1,400;1,500;1,600;1,700&display=swap');

html, body {
    height: 100%;
    width: 100%;
    margin: 0;
    font-family: "IBM Plex Sans", sans-serif;
}

.container {
    max-width: 90%;
    margin: 0 auto;
    padding: 3%;
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
}

.left-column, .right-column {
    width: 100%;
    height: auto;
    position: relative;
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    margin-bottom: 20px; /* Spacing between columns */
}

.title {
    color: #333333;
    font-size: 36px;
    margin-bottom: 10px;
    position: relative;
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

.btn, .submit {
    background-color: #FFA500;
    color: white;
    width: auto; /* Width adjusted to fit content */
    height: auto;
    border: none;
    border-radius: 25px;
    padding: 15px 30px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.btn:hover, .submit:hover {
    background-color: #333333;
}

.error-message {
    color: #dc3545;
    font-size: 14px;
    margin-top: 5px;
    font-weight: bold;
}

input, textarea {
    padding: 10px;
    margin: 5px 0;
    border: 1px solid #ccc;
    transition: all 0.3s ease;
    width: 100%;
    box-sizing: border-box;
}

input:focus, textarea:focus {
    border-color: #FFA500;
    box-shadow: 0 0 5px rgba(255, 165, 0, 0.5);
    outline: none;
}

@media screen and (min-width: 768px) {
    .container {
        flex-wrap: nowrap;
    }

    .left-column, .right-column {
        width: 45%;
    }
}

    </style>
</head>
<body>
    <%@include file="../header.jsp" %>
    <div class="container">
        <div class="left-column">
            <h1 class="title">NUOVO CLIENTE</h1>
            <h3>Registrazione Account</h3>
            Creando un account potrai effettuare gli acquisti più velocemente, controllare lo stato dei tuoi ordini e avere a disposizione lo storico delle attività.<br>
            <a href="register"><button class="btn">Registrati</button></a>
        </div>
        <div class="right-column">
            <h1 class="title">GIÀ CLIENTE</h1>
            <h3>Sono già un cliente</h3>
            <form id="loginForm" action="login" method="post" onsubmit="return validateForm()">
                <label for="email">Indirizzo Email:</label>
                <input id="email" type="email" name="email" placeholder="Email...">
                <div id="emailError" class="error-message"></div>

                <label for="password">Password:</label>
                <input id="password" type="password" name="password" placeholder="Password...">
                <div id="passwordError" class="error-message"></div>

                <input type="hidden" name="action" value="login">
                <input class="submit" type="submit" value="Submit">
            </form>
        </div>
    </div>
    <%@include file="../footer.jsp" %>

    <script>
        function validateForm() {
            var email = document.getElementById('email').value.trim();
            var password = document.getElementById('password').value.trim();
            var valid = true;

            // Reset error messages
            document.getElementById('emailError').textContent = '';
            document.getElementById('passwordError').textContent = '';

            // Validate email
            if (email === '') {
                document.getElementById('emailError').textContent = 'Inserisci un indirizzo email.';
                valid = false;
            } else {
                // Simple email validation using regex
                var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    document.getElementById('emailError').textContent = 'Inserisci un indirizzo email valido.';
                    valid = false;
                }
            }

            // Validate password
            if (password === '') {
                document.getElementById('passwordError').textContent = 'Inserisci la password.';
                valid = false;
            }

            return valid;
        }
    </script>

</body>
</html>
