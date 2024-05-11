<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	Cart cart = (Cart) request.getAttribute("cart");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart</title>
    <link rel="stylesheet" href="style/header.css">
    <link rel="stylesheet" href="style/footer.css">
    
</head>

<style>
        /* Stile per il contenitore principale */
        body {

            align-items: center;
            height: 100vh;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa; /* colore di sfondo */
        }

        /* Stile per la tabella */
        table {
            width: 80%; /* larghezza della tabella */
            border-collapse: collapse;
            margin-top: 20px; /* spazio superiore */
        }

        /* Stile per le celle della tabella */
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        /* Stile per l'intestazione della tabella */
        th {
            background-color: #f2f2f2;
        }

        /* Stile per le immagini */
        img {
            max-width: 100px;
            max-height: 100px;
        }

        /* Stile per i link */
        a {
            color: #007bff; /* colore dei link */
            text-decoration: none; /* rimuove il sottolineato */
        }

        /* Stile per i link al passaggio del mouse */
        a:hover {
            text-decoration: underline; /* sottolinea il link al passaggio del mouse */
        }
</style>
<body>
<%@include file="../header.jsp" %>
<% if(cart != null) { %>
<table border="1">
    <tr>
        <th>Image</th>
        <th>Name</th>
        <th>Price per unit</th>
        <th>Action</th>
    </tr>

    <% List<ProductBean> prodCart = cart.getProducts(); 	
       for(ProductBean beanCart : prodCart) { %>

    <tr>
        <td> <img src="<%= beanCart.getImmagine() %>" alt="<%= beanCart.getNome() %>" width="100" height="100"> </td>
        <td> <%= beanCart.getNome() %> </td>
        <td> <%= beanCart.getPrezzo() %> </td>
        
		<td><a href=cart?action=delete&id=<%=beanCart.getId()%>>Delete from cart</a></td>
        
    </tr>

    <% } %>

</table>
 <% } %>
<%@include file="../footer.jsp" %>
</body>
</html>
