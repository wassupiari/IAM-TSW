<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Footer</title>
    <!-- <link rel="stylesheet" type="text/css" href="style/footer.css"> -->
</head>

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
    font-family: "IBM plex Sans";
}

.footer-navigation, .footer-contact, .footer-social {
    margin: 10px;
}

.footer-navigation h3, .footer-contact h3, .footer-social h3 {
    color: #333;
    margin-bottom: 15px;
}

.footer-navigation ul, .footer-social .social-icons {
    list-style: none;
    padding: 0;
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

.footer-art svg {
    max-width: 130px;
    height: auto;
    margin-top: 50px;
}

@media (max-width: 600px) {
    #picassoFooter {
        flex-direction: column;
        align-items: center;
    }

    .footer-art svg {
        max-width: 100%;
    }
}

</style>
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
    <h3>Farmai.it</h3>
	<p>Iscritto all’albo dei farmacisti di Napoli n° iscrizione XXXX<br>
                            Laurea in Farmacia, rilasciata in Italia.</p>
    </div>
    <div class="footer-social">
        <h3>Follow Us</h3>
        <div class="social-icons">
            <a href="https://facebook.com" target="_blank" class="social-icon"><svg weight="15" width="15" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512"><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path fill="#333" d="M80 299.3V512H196V299.3h86.5l18-97.8H196V166.9c0-51.7 20.3-71.5 72.7-71.5c16.3 0 29.4 .4 37 1.2V7.9C291.4 4 256.4 0 236.2 0C129.3 0 80 50.5 80 159.4v42.1H14v97.8H80z"/></svg></a>
            <a href="https://instagram.com" target="_blank" class="social-icon"><svg xmlns="http://www.w3.org/2000/svg" height="20" width="20" viewBox="0 0 448 512"><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path fill="#333" d="M224.1 141c-63.6 0-114.9 51.3-114.9 114.9s51.3 114.9 114.9 114.9S339 319.5 339 255.9 287.7 141 224.1 141zm0 189.6c-41.1 0-74.7-33.5-74.7-74.7s33.5-74.7 74.7-74.7 74.7 33.5 74.7 74.7-33.6 74.7-74.7 74.7zm146.4-194.3c0 14.9-12 26.8-26.8 26.8-14.9 0-26.8-12-26.8-26.8s12-26.8 26.8-26.8 26.8 12 26.8 26.8zm76.1 27.2c-1.7-35.9-9.9-67.7-36.2-93.9-26.2-26.2-58-34.4-93.9-36.2-37-2.1-147.9-2.1-184.9 0-35.8 1.7-67.6 9.9-93.9 36.1s-34.4 58-36.2 93.9c-2.1 37-2.1 147.9 0 184.9 1.7 35.9 9.9 67.7 36.2 93.9s58 34.4 93.9 36.2c37 2.1 147.9 2.1 184.9 0 35.9-1.7 67.7-9.9 93.9-36.2 26.2-26.2 34.4-58 36.2-93.9 2.1-37 2.1-147.8 0-184.8zM398.8 388c-7.8 19.6-22.9 34.7-42.6 42.6-29.5 11.7-99.5 9-132.1 9s-102.7 2.6-132.1-9c-19.6-7.8-34.7-22.9-42.6-42.6-11.7-29.5-9-99.5-9-132.1s-2.6-102.7 9-132.1c7.8-19.6 22.9-34.7 42.6-42.6 29.5-11.7 99.5-9 132.1-9s102.7-2.6 132.1 9c19.6 7.8 34.7 22.9 42.6 42.6 11.7 29.5 9 99.5 9 132.1s2.7 102.7-9 132.1z"/></svg></a>
        </div>
    </div>
    <div class="footer-art">
        <a href="./catalogo">         
					<svg version="1.2" xmlns="http://www.w3.org/2000/svg" viewBox="50 130 500 500" width="200" height="205">
						<title>logo</title>
						
						<style> 
							.s0 { fill: #f5f5f5 } 
						</style>
						<g id="OBJECTS">
							<g id="Layer">
								<g id="Layer">
									<path id="Layer" class="s0" d="m225.8 225v33.1c0 12.3-10.1 22.4-22.4 22.4h-56.6c-5.7 0-10.6-2.7-13.8-6.9-2.1-2.9-3.4-6.4-3.4-10.2 0-9.2 7.2-16.6 16.2-17.1 0.5-9 8-16.2 17.1-16.2 9.5 0 17.1 7.7 17.1 17.1v21h-7.5v-21c0-5.3-4.3-9.5-9.6-9.5-5.2 0-9.5 4.2-9.5 9.5q0 1.2 0.3 2.3c0.3 1.3-0.1 2.7-1 3.6-1 1-2.3 1.3-3.6 1q-1.2-0.3-2.3-0.3c-5.3 0-9.6 4.3-9.6 9.6 0 5.2 4.3 9.5 9.6 9.5h56.6c8.1 0 14.8-6.6 14.8-14.8v-29.3h-41.9c-2.1 0-3.8-1.7-3.8-3.8v-27.1c0-8.2-6.7-14.9-14.9-14.9h-29.3v42c0 2.1-1.7 3.8-3.8 3.8h-27.1c-8.1 0-14.8 6.6-14.8 14.8v29.3h41.9c1.1 0 2 0.4 2.7 1.1 0.7 0.7 1.1 1.6 1.1 2.7v27.1c0 8.2 6.7 14.8 14.8 14.8h29.4v-33.3h7.5v37.1c0 2.1-1.7 3.8-3.7 3.8h-33.2c-12.3 0-22.3-10-22.3-22.4v-23.3h-42c-2.1 0-3.8-1.7-3.8-3.8v-33.1c0-12.4 10.1-22.4 22.4-22.4h23.4v-41.9c0-2.1 1.6-3.8 3.7-3.8h33.1c12.4 0 22.4 10 22.4 22.4v23.3h42c2.1 0 3.8 1.7 3.8 3.8z"/>
								</g>
							</g>
						</g>
						
					</svg></a>        
    </div>
</footer>

    
</body>
</html>
