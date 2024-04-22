<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, it.unisa.model.ProductBean" %>
<%
	Collection<ProductBean> products = (Collection<ProductBean>) request.getAttribute("prodotto");
	if(products == null) {
		response.sendRedirect("./prodotto");	
		return;
	}
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<title>Storage DS/BF</title>
</head>
<body>
	<%@include file="header.jsp" %>

	
	<h2>Products</h2>
	<a href="products">List</a>
	<table border="1">
		<tr>
			<th>Code</th>
			<th>Name</th>
			<th>Description</th>
			<th>Action</th>
		</tr>
		<%
			for (ProductBean bean : products) {
		%>
		<tr>
			<td><%= bean.getId() %></td>
			<td><%= bean.getNome() %></td>
			<td><%= bean.getDescrizione() %></td>
			<td>
				<a href="details?id=<%= bean.getId() %>">Details</a><br>
			</td>
		</tr>
		<%
			}
		%>
	</table>

	<%@ include file="footer.jsp" %>
	
</body>
</html>
