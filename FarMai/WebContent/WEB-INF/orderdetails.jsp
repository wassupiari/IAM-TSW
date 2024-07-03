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

		p {
			text-align: center;
			color: #333;
			font-size: 1.2em;
		}

		table {
			width: 90%;
			margin: 20px auto;
			border-collapse: collapse;
			box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
		}

		table th, table td {
			padding: 12px 15px;
			text-align: left;
			border-bottom: 1px solid #ddd;
		}

		table th {
			background-color: #FFA500;
			color: #fff;
			text-transform: uppercase;
			letter-spacing: 0.1em;
		}

		table tbody tr:nth-child(even) {
			background-color: #f9f9f9;
		}

		table tbody tr:hover {
			background-color: #f1f1f1;
		}

		#goBack {
			display: block;
			width: 90%;
			margin: 20px auto;
			padding: 10px 20px;
			text-align: center;
			background-color: #FFA500;
			color: white;
			text-decoration: none;
			border-radius: 4px;
			transition: background-color 0.3s ease;
		}

		#goBack:hover {
			background-color: #e69500;
		}

		form {
			width: 90%;
			margin: 20px auto;
			text-align: center;
		}

		form input[type="submit"] {
			background-color: #FFA500;
			color: white;
			border: none;
			padding: 10px 20px;
			cursor: pointer;
			border-radius: 4px;
			transition: background-color 0.3s ease;
		}

		form input[type="submit"]:hover {
			background-color: #e69500;
		}

		img {
			border-radius: 4px;
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