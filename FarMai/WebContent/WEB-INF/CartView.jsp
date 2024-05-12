<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	Cart cart = (Cart) request.getSession().getAttribute("cart");
	if (cart == null) {
	    cart = new Cart();
	    request.getSession().setAttribute("cart", cart);
	   
	}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart</title>
    <link rel="stylesheet" href="style/header.css">
    <link rel="stylesheet" href="style/footer.css">
    
    <style>
        @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;1,100;1,200;1,300;1,400;1,500;1,600;1,700&display=swap'); 
        html,body{
            height: 100%;
            width: auto;
            margin: 0;
            font-family: "IBM plex Sans";            
        }
		.title {
		  text-align: center; 
		  margin-bottom: 20px; 
		}
		
		.title h2 {
		  font-size: 24px; 
		  color: #333; 
		  font-weight: bold; 
		  padding-left: 30px; 
            padding-right: 30px; 
		}
        

        .container {
            max-width: 1200px; 
            margin: 0 auto; 
            padding-left: 30px; 
            padding-right: 30px; 
        }

       table {
           width: 100%;
           height: auto;
           border-collapse: collapse;
           margin-top: 20px;
        
        }

        table, th, td {
            border: none;
            
        }
        
        table th:first-child{
          border-radius:5px 0 0 5px;
        }
        
        table th:last-child{
          border-radius:0 5px 5px 0;
        }
        
        th, td {
            padding: 10px;
            text-align: center;
        }
        
        .error {
            background-color: #E6F2E0; 
            border: 1px solid #A0C49D; 
            color: #333; 
            padding: 10px;
            margin: 20px; 
            border-radius: 5px; 
            text-align: center; 
        }
    </style>
</head>
<body>
<%@include file="../header.jsp" %>

<div class="title">
<h2>Carrello</h2>
</div>

<div class="container">
    <%
        List<ProductBean> j = cart.getProducts();     
    %>

    <% if (j.isEmpty()) { %>
    <div class="error">
        <p>Non ci sono prodotti al momento</p>
        </div>
    <% } else { %>


    <table border="1">
        <tr>
            <th></th>
            <th>Nome Prodotto</th>
            <th>Prezzo per unità</th>
            
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
</div>

<%@include file="../footer.jsp" %>
</body>
</html>
