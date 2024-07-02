<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, java.sql.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<%
	OrderBean order = (OrderBean) request.getAttribute("detailedOrder");
	OrderDAO model = new OrderDAO();
	ProductDAO jewelModel = new ProductDAO();
	
%>

<!-- STAMPA: nome, immagine, personalizzato, quantità, prezzo -->

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="./styles/tableStyle.css">
	<meta content="width=device-width, initial-scale=1" name="viewport" />
	
	<title>Order Details</title>
	
	<style>

/* Global styles */
body {
    font-family: Arial, sans-serif;
    background-color: #f2f2f2;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}

h1 {
    color: #333;
    text-align: center;
}

/* Table styles */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    background-color: #fff;
    border: 1px solid #ddd;
}

table th, table td {
    padding: 10px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

table th {
    background-color: #f2f2f2;
}

table img {
    width: 70px;
    height: 70px;
}

/* Form and button styles */
form {
    margin-top: 20px;
}

input[type="submit"], #goBack {
    background-color: #18020C;
    color: #fff;
    border: none;
    cursor: pointer;
    border-radius: 20px;
    font-size: 14px;
    padding: 10px 20px;
    text-decoration: none;
    display: inline-block;
    text-align: center;
    margin-top: 10px;
}

input[type="submit"]:hover, #goBack:hover {
    background-color: #84A8A1;
}

/* Responsive styles */
@media screen and (max-width: 700px) {
    table, th, td {
        font-size: 12px;
    }

    table img {
        width: 50px;
        height: 50px;
    }

    input[type="submit"], #goBack {
        font-size: 12px;
        padding: 5px 10px;
    }
}


	</style>
	
</head>

<body>
	<%@include file="../header.jsp" %>
	<h1>
		Ordine fatto il: <%=order.getData() %>
	</h1>


	<div>

		<div>
			<p>
				Prezzo Totale: € <%=order.getPrezzo_totale()%>
			</p>

		</div>

		<div >
			<!-- QUA STA LA ROBA DELLA DATA DI CONSEGNA -->

			<div >
				<table>
					<tr>
						<th>Nome</th>
						<th>Immagine</th>
						<th>Quantità</th>
						<th>Prezzo</th>
						
					</tr>
					<%

					for ( OrderProductBean prodotto : order.getProducts() ){
						ProductBean jewel = jewelModel.doRetrieveByKey(prodotto.getId_prodotto());

						%>
						<tr>
							<td><%=jewel.getNome() %></td>
							<td><img src="<%=jewel.getImmagine()%> "alt="<%=jewel.getNome()%>"  width="70"  height="70"></td>
							<td><%=prodotto.getQuantita() %></td>
							<td><%=prodotto.getPrezzo() %></td>

						</tr>

						<%	} %>
					</table>

					<form action="orderdetails?action=viewInvoice" method="post">
						<input type="hidden" name="idOrder" value="<%= order.getId() %>" >
						<input type="submit" value="Vedi Fattura">
					</form>

				</div>
			</div>

		</div>

		<br>
		<a href="clientorders" id="goBack"><i class="fa fa-angle-double-left" aria-hidden="true"></i>Go back</a></p>

		<%@include file="../footer.jsp" %>
	</body>
	</html>