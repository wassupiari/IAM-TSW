<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Footer</title>
    <!-- <link rel="stylesheet" type="text/css" href="style/footer.css"> -->
    <style>
        @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;1,100;1,200;1,300;1,400;1,500;1,600;1,700&display=swap'); 

        #footer {
            background-color: #A0C49D;
            color: #333;
            padding: 20px;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            align-items: center;
            font-family: "IBM Plex Sans";
        }

        .footer-navigation, .footer-contact, .footer-social {
            margin: 10px;
            flex: 1 1 200px; /* Flex-grow, flex-shrink, flex-basis */
            text-align: center;
        }

        .footer-navigation h3, .footer-contact h3, .footer-social h3 {
            color: #333;
            margin-bottom: 15px;
        }

        .footer-navigation ul, .footer-social .social-icons {
            list-style: none;
            padding: 0;
        }

        .footer-contact p {
            font-size: 10px;
            text-align: center;
        }

        .footer-navigation ul li, .social-icon {
            margin-bottom: 10px;
            transition: transform 0.2s ease-in-out;
        }

        .footer-navigation ul li a, .social-icon {
            color: #333;
            text-decoration: none;
        }

        .social-icon {
            display: inline-block;
            padding: 8px;
            background-color: #A0C49D;
            margin-right: 5px;
        }

        .social-icon:hover, .footer-navigation ul li a:hover {
            transform: scale(1.1);
        }

        @media (max-width: 600px) {
            #footer {
                flex-direction: column;
                align-items: center;
                text-align: center;
            }
            .footer-navigation, .footer-contact, .footer-social {
                margin: 5px 0;
                flex: 1 1 100%;
            }
            .footer-contact p {
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
<footer id="footer">
    <div class="footer-navigation">
        <h3>Orari di apertura</h3>
        <ul>
            <li><p>Lunedì - Venerdì: 8:00 - 20:00</p></li>
            <li><p>Sabato: 8:00 - 18:00</p></li>
            <li><p>Domenica: Chiuso</p></li>
        </ul>
    </div>
    <div class="footer-contact">
        <p>Copyright ©2024 - farmai.it<br>
        Via Marco Polo 190 - 55049 Fisciano (SA) - P.IVA 11357530630</p>
    </div>
    <div class="footer-social">
        <h3>Follow Us</h3>
        <div class="social-icons">
            <a href="https://facebook.com" target="_blank" class="social-icon">
                <svg width="15" height="15" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512"><path fill="#333" d="M80 299.3V512H196V299.3h86.5l18-97.8H196V166.9c0-51.7 20.3-71.5 72.7-71.5 16.3 0 29.4 .4 37 1.2V7.9C291.4 4 256.4 0 236.2 0 129.3 0 80 50.5 80 159.4v42.1H14v97.8H80z"/></svg>
            </a>
            <a href="https://instagram.com" target="_blank" class="social-icon">
                <svg width="15" height="15" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"><path fill="#333" d="M224.1 141c-63.6 0-114.9 51.3-114.9 114.9s51.3 114.9 114.9 114.9 114.9-51.3 114.9-114.9S287.7 141 224.1 141zm0 189.6c-41.1 0-74.7-33.5-74.7-74.7s33.5-74.7 74.7-74.7 74.7 33.5 74.7 74.7-33.6 74.7-74.7 74.7zm146.4-194.3c0 14.9-12 26.8-26.8 26.8-14.9 0-26.8-12-26.8-26.8s12-26.8 26.8-26.8 26.8 12 26.8 26.8zm76.1 27.2c-1.7-35.9-9.9-67.7-36.2-93.9-26.2-26.2-58-34.4-93.9-36.2-37-2.1-147.9-2.1-184.9 0-35.8 1.7-67.6 9.9-93.9 36.1s-34.4 58-36.2 93.9c-2.1 37-2.1 147.9 0 184.9 1.7 35.9 9.9 67.7 36.2 93.9s58 34.4 93.9 36.2c37 2.1 147.9 2.1 184.9 0 35.9-1.7 67.7-9.9 93.9-36.2 26.2-26.2 34.4-58 36.2-93.9 2.1-37 2.1-147.8 0-184.8zM398.8 388c-7.8 19.6-22.9 34.7-42.6 42.6-29.5 11.7-99.5 9-132.1 9s-102.7 2.6-132.1-9c-19.6-7.8-34.7-22.9-42.6-42.6-11.7-29.5-9-99.5-9-132.1s-2.6-102.7 9-132.1c7.8-19.6 22.9-34.7 42.6-42.6 29.5-11.7 99.5-9 132.1-9s102.7-2.6 132.1 9c19.6 7.8 34.7 22.9 42.6 42.6 11.7 29.5 9 99.5 9 132.1s2.7 102.7-9 132.1z"/></svg>
            </a>
        </div>
    </div>
</footer>
</body>
</html>
