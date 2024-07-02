<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<%



String error = (String) request.getAttribute("error");





%>

<!DOCTYPE html>
<html lang="en">

<head>
        <title> Admin Page </title>
        
        <style>
        
        /* Base styles */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f4f4f4;
    color: #333;
}

/* Grid container */
.grid-container {
    display: flex;
    flex-direction: column;
    flex-grow: 1;
    max-width: 90%;
    margin: 0 auto;
}



/* Screen container */
.screen-container {
    padding: 2em;
    display: flex;
    flex-direction: column;
    align-items: center;
}

/* Card styles */
.transparentCard {
    background-color: rgba(255, 255, 255, 0.9);
    padding: 2em;
    border-radius: 10px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 800px;
    margin-top: 2em;
}

/* Form styles */
.formContainer {
    display: flex;
    flex-direction: column;
    gap: 1em;
    width: 100%;
}

.inputBox {
    position: relative;
}

.inputBox input[type="text"],
.inputBox input[type="number"],
.inputBox input[type="file"],
.inputBox textarea,
.inputBox select {
    width: 100%;
    padding: 0.5em;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 1em;
    transition: border-color 0.3s;
}

.inputBox label {
    position: absolute;
    top: -10px;
    left: 10px;
    background-color: rgba(255, 255, 255, 0.9);
    padding: 0 0.5em;
    font-size: 0.9em;
    color: #4c8577;
}

/* Buttons */
input[type="submit"],
input[type="reset"] {
    height: 2.5em;
    border-radius: 5px;
    border: 2px solid #4c8577;
    cursor: pointer;
    background-color: transparent;
    transition: background-color 0.5s, color 0.5s;
    text-transform: uppercase;
    font-size: 0.9em;
    letter-spacing: 2px;
    margin-bottom: 1em;
    color: #4c8577;
}

input[type="submit"]:hover,
input[type="reset"]:hover {
    background-color: #4c8577;
    color: white;
}

/* Special buttons */
#load, #delete {
    color: #AEA4B4;
    border: 2px solid #AEA4B4;
}

#load:hover, #delete:hover {
    background-color: #AEA4B4;
    color: white;
}

/* Error message */
.errorNoTranslate {
    color: red;
    font-weight: bold;
    margin-bottom: 1em;
}

/* Titles and subtitles */
.title {
    font-size: 2em;
    color: #4c8577;
    margin-bottom: 0.5em;
}

.subtitle {
    font-size: 1.5em;
    color: #4c8577;
    margin-bottom: 1em;
}

/* Fieldset */
fieldset {
    border: 1px solid #ccc;
    padding: 1em;
    border-radius: 5px;
}

legend {
    font-weight: bold;
    color: #4c8577;
}

/* Submit container */
.submitContainer {
    display: flex;
    flex-direction: row;
    gap: 10px;
    justify-content: flex-end;
}

/* Responsive */
@media (max-width: 768px) {
    .transparentCard {
        padding: 1em;
    }

    .title, .subtitle {
        text-align: center;
    }

    .submitContainer {
        justify-content: center;
    }
}
        
        
            .submitContainer{
                display: flex;
                flex-direction: row;
                gap: 10px;
            }
            
          input[type="submit"], input[type="reset"] {
                height:60%;
                border-radius: 5px;
                border: 2px solid #4c8577;
                cursor: pointer;
                background-color: transparent;
                transition: 0.5s;
                text-transform: uppercase;
                font-size: 11px;
                letter-spacing: 2px;
                margin-bottom: 1em;
                color: #4c8577;
            }

      input[type="submit"]:hover, input[type="reset"]:hover {
            background-color: #4c8577;
            color: white;
        }
        
            #load, #delete {
            color: #AEA4B4;
            border: 2px solid #AEA4B4;
            }
            
           #load:hover, #delete:hover {
            background-color: #AEA4B4;
            color: white;
            }
            
            
        </style>
</head>

<body>

            <%@include file="../header.jsp" %>
    <div class="grid-container">
        
        <div class="screen-container">    
        <span class="title"> Admin Page </span>
        
        <div class="transparentCard">
        <% if (error != null){%>
                <div class="errorNoTranslate"><%=error%></div>
        <%}%>
        <form class="formContainer" action="admin" method="post" enctype="multipart/form-data">
                <span class="subtitle">Aggiungi Prodotto</span>
                <input type="hidden" name="action" value="insert">

                <div class="inputBox">
                    <input name="name" type="text" maxlength="50" required autocomplete="off" placeholder="enter name">
                <label for="name">Nome:</label>
                </div>
                
				<div class="inputBox special">
				    <label for="category">Categoria:</label>
				    <select name="category" required>
				        <option value="Mamme e bambini">Mamme e bambini</option>
				        <option value="Salute e cura della persona">Salute e cura della persona</option>
				        <option value="Igiene e benessere">Igiene e benessere</option>
				    </select>
				</div>
				<div class="inputBox special">
				    <label for="format">Formato:</label>
				    <select name="format" required>
				        <option value="Pomate">Pomata</option>
				        <option value="Compresse">Compressa</option>
				        <option value="Sciroppi">Sciroppi</option>
				    </select>
				</div>
                
                

                <div class="inputBox special">
                <label for="image">Immagine:</label>
                <input name="image" type="file" required>
                </div>

                <div class="inputBox special">
                <label for="availability">Quantita:</label>
                <input name="availability" type="number" min="1" required>
                </div>

                <div class="inputBox special">
                <label for="IVA">IVA:</label>
                <input name="IVA" type="number" min="1" max="10" value="10" required>
                </div>

                <div class="inputBox special">
                <label for="price">Prezzo:</label>
                <input name="price" type="number" min="1" max='5000' required>
                </div>

                <div class="inputBox special">
                <label for="description">Descrizione:</label>
                <textarea name="description" maxlength="500" rows="3" required placeholder="enter description"></textarea>
                </div>

                <div class="inputBox special">
                <label for="discount">Sconto:</label>
                <input name="discount" type="number" min="0" max="99" value="0">
                </div>
                
                <div class="submitContainer">
                <input class="submit" type="submit" value="Add">
                <input class="submit" type="reset" value="Reset">
                </div>
        </form>
        

 <form class="formContainer" action="admin" method="post">
                <span class="subtitle">Update with new info</span>
                <input type="hidden" name="action" value="load">
                <fieldset>
                        <legend> Write down the jewel's ID you want to modify</legend>
                        <label for="id">Id:</label>
                        <input name="id" type="number" required>
                        <input id="load" type="submit" value="Load">
                </fieldset>
        </form>


<%
    ProductBean j = (ProductBean) request.getAttribute("jewel");
    if (j != null) {
        // Utilizza il prodotto per visualizzare i dettagli nella tua pagina
%>
        	<form class="formContainer" action="admin" method="post">
        		<input type="hidden" name="action" value="modify">
        		<input type="hidden" name="idM" value=<%=j.getId() %>>
                
                <div class="inputBox">
                <input name="nameM" type="text" maxlength="50" required value="<%= j.getNome() %>">
                <label for="name">Nome:</label>
                </div>
                
               <div class="inputBox special">
				    <label for="category">Categoria:</label>
				    <select name="categoryM" required>
				        <option value="Mamme e bambini" <%= j.getCategoria().equals("Mamme e bambini") ? "selected" : "" %>>Mamme e bambini</option>
				        <option value="Salute e cura della persona" <%= j.getCategoria().equals("Salute e cura della persona") ? "selected" : "" %>>Salute e cura della persona</option>
				        <option value="Igiene e benessere" <%= j.getCategoria().equals("Igiene e benessere") ? "selected" : "" %>>Igiene e benessere</option>
				    </select>
				</div>
				
			<div class="inputBox special">
			    <label for="format">Formato:</label>
			    <select name="formatM" required>
			        <option value="Pomate" <%= j.getFormato().equals("Pomate") ? "selected" : "" %>>Pomata</option>
			        <option value="Compresse" <%= j.getFormato().equals("Compresse") ? "selected" : "" %>>Compressa</option>
			        <option value="Sciroppi" <%= j.getFormato().equals("Sciroppi") ? "selected" : "" %>>Sciroppi</option>
			    </select>
			</div>

                
                
                <div class="inputBox special">
                <label for="image">Immagine:</label>
                <input name="imageM" type="text" maxlength="100" required value="<%=j.getImmagine() %>">
                </div>
                
                <div class="inputBox special">
                <label for="availability">Quantita:</label>
                <input name="availabilityM" type="number" min="0" required value="<%=j.getQuantita() %>">
                </div>
                
                <div class="inputBox special">
                <label for="IVA">IVA:</label>
                <input name="IVAM" type="number" min="1" max='10' required value="<%=j.getIVA() %>">               
                </div>
                
                <div class="inputBox special">
                <label for="price">Prezzo:</label>
                <input name="priceM" type="number" min="1" max='5000' required value="<%=j.getPrezzo() %>">
                </div>
                
                <div class="inputBox special">
                <label for="description">Descrizione:</label>
                <textarea name="descriptionM" maxlength="500" rows="3" required><%=j.getDescrizione() %></textarea>
                </div>
                

                <div class="inputBox special">     
                <label for="discount">Sconto:</label>
                <input name="discountM" type="number" min="0" max="99" value="<%=j.getSconto() %>">
                </div>
                
                <div class="submitContainer">
                <input class="submit" type="submit" value="Modify">
                </div>
           </form>

<%
    } else {
        // Gestisci il caso in cui il prodotto non sia stato trovato o non sia stato caricato correttamente
        out.println("Product not found or unable to load.");
    }
%>

        <form class="formContainer" action="admin" method="post">
                <span class="subtitle">Elimina un prodotto</span>
                <input type="hidden" name="action" value="delete">
                <fieldset>
                        <legend> Scrivi l'id del prodotto da cancellare</legend>
                        <label for="id">Id:</label>
                        <input name="id" type="number" required>
                        <input id="delete" type="submit" value="Delete">
                </fieldset>
        </form>
      </div>  
    </div>    
        
        
        
    

</div>
<%@include file="../footer.jsp" %>
</body>
</html>