<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<% Cart cart = (Cart) request.getSession().getAttribute("cart");
if (cart == null) {
    cart = new Cart();
    request.getSession().setAttribute("cart", cart);
   
}


%>

<!DOCTYPE html>
<html lang="en">

<head>
	<link rel="stylesheet" type="text/css" href="./styles/tableStyle.css">
    <title> Cart </title>
    <style>

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    
}

table, th, td {
    border: none;
    
}

table th:first-child{
  border-radius:20px 0 0 20px;
}

table th:last-child{
  border-radius:0 20px 20px 0;
}

th, td {
    padding: 10px;
    text-align: center;
}

th {
    background-color: #84A8A1;
}

form {
    margin-top: 20px;
}

input[type="submit"] {
    background-color: #18020C;
    color: #fff;
    border: none;
    padding: 8px 16px;
    margin-top: 5px;
    cursor: pointer;
    border-radius: 20px;
}

input[type="submit"]:hover {
    background-color: #84A8A1;
    color: #fff;
    border: none;
    padding: 8px 16px;
    margin-top: 5px;
    cursor: pointer;  
}


input[type="number"] {
    width: 60px;
}

body {
    font-family: "Times New Roman", serif, sans-serif;
}

h1 {
    text-align: center;
    margin-bottom: 20px;
    color: #4C8577;
}

form[action="cart"] {
    text-align: center;
    margin-top: 20px;
}

button {
  padding: 5px 10px;
  margin: 0 5px;
  border: 2px solid #4C8577;
  border-radius: 20px;
  background-color: #fff;
  cursor: pointer;
  text-align: center;
  font-size: 18px;
  letter-spacing: 1px;
}

button:hover {
  color: white;
  background-color: #4c8577;
}

button:active {
  transform: scale(0.9);
}


#goBack, #reset {
    background-color: #18020C;
    color: #fff;
    border: none;
    padding: 8px 16px;
    margin-top: 5px;
    cursor: pointer;
    border-radius: 20px;
    text-decoration: none;
}

#goBack:hover, #reset:hover {
    background-color: #84A8A1;
    color: #fff;
    border: none;
    padding: 8px 16px;
    margin-top: 5px;
    cursor: pointer;  
}

.errorNoTranslate{
    color: #634B66;
}

    </style>
</head>

<body>
    <%@include file="../header.jsp" %>
    <h1> Cart Details </h1>


    <table border = "1">
        <tr>
            <th> Image </th>
            <th> Name </th>
            <th> Price per unit </th>
            <th> Amount </th>
            <th> Operations </th>
        </tr>

        <% ArrayList<CartProduct> cartProd = cart.getProducts();
            for (CartProduct j : cartProd) { %>

            <form method = "post" action ="cart">
                <tr>
                    <td> <img src="<%= j.getProduct().getImmagine() %>" alt="<%=j.getProduct().getNome()%>"  width="100"  height="100"> </td>
                    <td> <%=j.getProduct().getNome()%> </td>
                    <td> <%=j.getProduct().getPrezzo()%> <input type="hidden" name="id" value = "<%= j.getProduct().getId() %>"> </td>
                    <td> <input type="number" name="quantita" value= "<%= j.getQuantity() %>"> </td>
                    <td> <input type="submit" name="action" value="Modify Amount"> <br> <input type="submit" name="action" value="Delete from Cart"> <br> </td>
                </tr>

            </form>

            <% } %>
    </table>
    <!-- FORM CON ACTION BUY-->
    <form action="cart" method="post">
        <input type="hidden" name="action" value="buy">
        <input type ="submit" id="checkout-btn" value="Proceed to checkout">
    </form>



</body>
</html>