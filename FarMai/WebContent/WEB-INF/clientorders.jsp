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
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Orders</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;1,100;1,200;1,300;1,400;1,500;1,600;1,700&display=swap');

    html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        body {
            display: flex;
            flex-direction: column;
            font-family: "IBM Plex Sans";
            min-height: 100vh;
        }
         .content {
            flex: 1;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-top: 20px;
        }

        .client-orders {
            width: 100%;
            margin: 20px auto;
            border-collapse: collapse;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            overflow-x: auto; /* Per consentire lo scroll orizzontale su schermi stretti */
        }

        .client-orders th,
        .client-orders td {
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

        form input[type="text"],
        form input[type="date"],
        .searchbar input[type="text"] {
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

        form input[type="submit"],
        form a#reset {
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
            font-size: 12px;
        }

        form input[type="submit"]:hover {
            background-color: #218838;
        }

        form a#reset:hover {
            background-color: #c82333;
        }

        @media only screen and (max-width: 600px) {
            h1 {
                font-size: 24px;
            }

            .client-orders {
                font-size: 14px;
                width: 100%;
                overflow: auto; /* Abilita lo scroll orizzontale */
            }

            .client-orders th,
            .client-orders td {
                padding: 10px 12px;
            }

            form {
                font-size: 14px;
                padding: 15px;
            }

            form input[type="text"],
            form input[type="date"],
            .searchbar input[type="text"] {
                width: calc(100% - 20px);
                padding: 8px;
            }

            form input[type="submit"],
            form a#reset {
                padding: 8px 16px;
                margin: 15px 5px 0 0;
                font-size: 12px;
            }
        }
    </style>
</head>

<body>
    <%@include file="../header.jsp" %>

    <% if (!client.getEmail().equals("admin@farmai.it")) { %>
    <!-- ------------------------------------------------------ -->
    <h1><%= client.getUsername() %>'s orders</h1>
    <div style="overflow-x: auto;">
        <table class="client-orders">
            <thead>
                <tr>
                    <th>Data ordine</th>
                    <th>Prezzo totale</th>
                    <th>Dettagli</th>
                </tr>
            </thead>
            <tbody>
                <% for (OrderBean order : orders) { %>
                <tr>
                    <td><%= order.getData() %></td>
                    <td><%= order.getPrezzo_totale() %></td>
                    <td>
                        <button onclick="redirectToServlet('<%= order.getId() %>')" class="btn-view-order">
                            <i class="fa fa-eye" aria-hidden="true"></i> Vedi dettagli
                        </button>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

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

        <label for="cliente">Inserisci Cliente</label>
        <div class="searchbar">
            <input name="cliente" type="text" placeholder="user" autocomplete="off">
        </div>
        <label for="Order By Client">Ordina per cliente</label>
        <input name="Order By Client" type="checkbox" value="true">
        <br>

        <label for="data_da">Da (inserisci la data desiderata)</label>
        <input name="data_da" type="date" placeholder="yyyy/mm/dd">
        <label for="data_a">A (inserisci la data desiderata)</label>
        <input name="data_a" type="date" placeholder="yyyy/mm/dd">
        <label for="Order By Date">Ordina per data</label>
        <input name="Order By Date" type="checkbox" value="true">
        <br>

        <% if (dateError != null) { %>
        <span class="errorNoTranslate"><%= dateError %></span>
        <% } %>

        <input type="submit" value="Ordina">
        <a href="admin?action=ordersNoFilter" id="reset">Ripristina</a>
    </form>

    <div style="overflow-x: auto;">
        <table class="client-orders">
            <thead>
                <tr>
                    <th>Ordine data</th>
                    <th>Tracking Number</th>
                    <th>Indirizzo</th>
                    <th>Destinatario</th>
                    <th>Dettagli</th>
                </tr>
            </thead>
            <tbody>
                <% for (OrderBean order : orders) { %>
                <tr>
                    <td><%= order.getData() != null ? order.getData().toString() : "N/A" %></td>
                    <td><%= order.getNumero_di_tracking() != null ? order.getNumero_di_tracking() : "N/A" %></td>
                    <td><%= order.getIndirizzo_di_spedizione() != null ? order.getIndirizzo_di_spedizione() : "N/A" %></td>
                    <td><%= order.getDestinatario() != null ? order.getDestinatario() : "N/A" %></td>
                    <td>
                        <button onclick="redirectToServlet('<%= order.getId() %>')" class="btn-view-order">
                            <i class="fa fa-eye" aria-hidden="true"></i> Vedi dettagli
                        </button>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

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
