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
        html, body {
            height: 100%;
            width: 100%;
            margin: 0;
            font-family: "IBM Plex Sans";
        }
        /* Stili per la tabella degli ordini dei clienti */
        table.client-orders {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table.client-orders th {
            background-color: #4c8577;
            color: white;
            padding: 10px;
            text-align: center;
            font-size: 14px;
        }

        table.client-orders td {
            text-align: center;
            font-size: 12px;
            padding: 8px;
        }

        table.client-orders button {
            padding: 5px 10px;
            background-color: #84a8a1;
            border: none;
            color: white;
            cursor: pointer;
            font-size: 12px;
            border-radius: 5px;
        }

        table.client-orders button:hover {
            background-color: #6c988f;
        }

        /* Stili per le form e i controlli di input */
        form#adminForm {
            margin-top: 20px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f2f2f2;
        }

        form#adminForm label {
            font-size: 14px;
            margin-right: 10px;
        }

        form#adminForm input[type="text"],
        form#adminForm input[type="date"] {
            width: 150px;
            padding: 5px;
            margin-right: 10px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        form#adminForm input[type="checkbox"] {
            margin-right: 5px;
        }

        form#adminForm input[type="submit"],
        form#adminForm a#reset {
            padding: 5px 10px;
            background-color: #18020c;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 12px;
            border-radius: 5px;
            text-decoration: none;
        }

        form#adminForm input[type="submit"]:hover,
        form#adminForm a#reset:hover {
            background-color: #4c8577;
        }

        /* Media query per dispositivi di dimensioni ridotte */
        @media screen and (max-width: 700px) {
            table.client-orders {
                font-size: 10px;
            }

            table.client-orders th,
            table.client-orders td {
                padding: 5px;
            }

            form#adminForm {
                padding: 10px;
            }

            form#adminForm input[type="text"],
            form#adminForm input[type="date"] {
                width: 100px;
                font-size: 10px;
                padding: 3px;
            }

            form#adminForm input[type="submit"],
            form#adminForm a#reset {
                font-size: 10px;
                padding: 3px 6px;
            }
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
			<th>Destinatario</th>
			<th>Indirizzo</th>
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
