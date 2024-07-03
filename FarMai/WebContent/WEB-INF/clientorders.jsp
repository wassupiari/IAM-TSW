<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<%
    ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
    if(client == null){
        response.sendRedirect("login");    
        return;
    }

    ArrayList<OrderBean> orders = (ArrayList<OrderBean>) request.getAttribute("ordini");
    if(orders == null){
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/clientorders");
        dispatcher.forward(request, response);
        return;
    }

    String dateError = (String)request.getAttribute("dateError");
    String clientError = (String)request.getAttribute("clientError");
%>    

<!DOCTYPE html>
<html lang="en">

<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <title>Orders</title>
    <style>
    
    @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;1,100;1,200;1,300;1,400;1,500;1,600;1,700&display=swap');

body {
  
	font-family: "IBM plex Sans";
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	min-height: 100vh; 
    display: flex;
    flex-direction: column;
}
    h1 {
        text-align: center;
        color: #333;
        margin-top: 20px;
    }
    .client-orders {
        width: 90%;
        margin: 20px auto;
        border-collapse: collapse;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }
    .client-orders th, .client-orders td {
        padding: 12px 15px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }
    .client-orders th {
        background-color: #FFA500;
        color: #fff;
        text-transform: uppercase;
        letter-spacing: 0.1em;
    }
    .client-orders tbody tr:nth-child(even) {
        background-color: #f9f9f9;
    }
    .client-orders tbody tr:hover {
        background-color: #f1f1f1;
    }
    .btn-view-order {
        background-color: #FFA500;
        color: white;
        border: none;
        padding: 8px 12px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .btn-view-order:hover {
        background-color: #0056b3;
    }
    form {
        width: 90%;
        margin: 20px auto;
        background: #fff;
        padding: 20px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
    }
    form label {
        display: block;
        margin: 10px 0 5px;
        color: #333;
    }
    form input[type="text"], form input[type="date"], .searchbar input[type="text"] {
        width: calc(100% - 22px);
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    form input[type="checkbox"] {
        margin-right: 10px;
    }
    form .searchbar {
        position: relative;
        width: 100%;
    }
    form .searchbar input {
        padding-right: 40px;
    }
    form .searchbar .fa-search {
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        color: #888;
    }
    form .errorNoTranslate {
        color: red;
        margin-top: 10px;
        display: block;
    }
    form input[type="submit"], form a#reset {
        display: inline-block;
        padding: 10px 20px;
        margin: 20px 10px 0 0;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        text-decoration: none;
        color: #fff;
    }
    form input[type="submit"] {
        background-color: #28a745;
    }
    form a#reset {
        background-color: #dc3545;
    }
    form input[type="submit"]:hover {
        background-color: #218838;
    }
    form a#reset:hover {
        background-color: #c82333;
    }
   
    </style>
</head>

<body>
    <%@include file="../header.jsp" %>

    <% if(!client.getEmail().equals("admin@farmai.it")) { %>
    <!-- ------------------------------------------------------ -->
    <h1> <%= client.getUsername() %>'s orders</h1>
    <table class="client-orders">
        <thead>
            <tr>
                <th>Order Date</th>
                <th>Total Price</th>
                <th>Details</th>
            </tr>
        </thead>
        <tbody>
            <% for(OrderBean order: orders){ %>
            <tr>
                <td><%= order.getData() %></td>
                <td><%= order.getPrezzo_totale() %></td>
                <td><button onclick="redirectToServlet('<%= order.getId() %>')" class="btn-view-order">
    <i class="fa fa-eye" aria-hidden="true"></i> View Details
</button></td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <% } else { %>
    <!-- ---------------------------------------------------------------- -->
    <form action="admin" method="get">
        <input type="hidden" name="action" value="ordersNoFilter">
        <h1>Ordini utenti</h1>
    </form>

    <form id="adminForm" action="admin?action=orders" method="post">
        <% if (clientError != null) { %>
        <span class="errorNoTranslate"><%= clientError %></span>
        <% } %>

        <label for="cliente">Insert Client</label>
        <div class="searchbar">
            <input name="cliente" type="text" placeholder="user" autocomplete="off">
        </div>
        <label for="Order By Client">Order By Client</label>
        <input name="Order By Client" type="checkbox" value="true">
        <br>

        <label for="data_da">Insert first date</label>
        <input name="data_da" type="date" placeholder="yyyy/mm/dd">
        <label for="data_a">Insert second date</label>
        <input name="data_a" type="date" placeholder="yyyy/mm/dd">
        <label for="Order By Date">Order By Date</label>
        <input name="Order By Date" type="checkbox" value="true">
        <br>

        <% if (dateError != null) { %>
        <span class="errorNoTranslate"><%= dateError %></span>
        <% } %>

        <input type="submit" value="Order">
        <a href="admin?action=ordersNoFilter" id="reset">Reset</a>
    </form>

<table class="client-orders">
    <thead>
        <tr>
            <th>Ordine data</th>
            <th>Prezzo totale</th>
            <th>Tracking Number</th>
            <th>Indirizzo</th>
			<th>Destinatario</th>
            <th>Dettagli</th>
        </tr>
    </thead>
    <tbody>
        <% for(OrderBean order: orders){ %>
        <tr>
            <td><%= order.getData() != null ? order.getData().toString() : "N/A" %></td>
            <td><%= order.getPrezzo_totale() %></td>
            <td><%= order.getNumero_di_tracking() != null ? order.getNumero_di_tracking() : "N/A" %></td>
            <td><%= order.getIndirizzo_di_spedizione() != null ? order.getIndirizzo_di_spedizione() : "N/A" %></td>
            <td><%= order.getDestinatario() != null ? order.getDestinatario() : "N/A" %></td>
            <td>
                <button onclick="redirectToServlet('<%= order.getId() %>')" class="btn-view-order">
                    <i class="fa fa-eye" aria-hidden="true"></i> View Details
                </button>
            </td>
        </tr>
        <% } %>
    </tbody>
</table>




    <% } %>

    <br>
    <%@include file="../footer.jsp" %>

    <script>
    function redirectToServlet(orderId) {
        window.location.href = "/FarMai/orderdetails?ordine=" + orderId;
    }

    </script>

</body>

</html>
