<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>
<%
ArrayList<OrderProductBean> products = (ArrayList<OrderProductBean>)request.getAttribute("orderProducts");
ArrayList<ProductBean> jewels = (ArrayList<ProductBean>)request.getAttribute("jewels");
InvoiceBean invoice = (InvoiceBean) request.getAttribute("invoice");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Invoice</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 20px;
      background-color: #f4f4f4;
    }

    .invoice-container {
      max-width: 800px;
      margin: 0 auto;
      background-color: #fff;
      padding: 20px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .header, .footer {
      text-align: center;
      margin-bottom: 20px;
    }

    .header img {
      max-width: 100px;
    }

    .header h1 {
      margin: 0;
      font-size: 24px;
    }

    .header p {
      margin: 0;
      font-size: 14px;
      color: #555;
    }

    .details {
      display: flex;
      justify-content: space-between;
      margin-bottom: 20px;
    }

    .details div {
      width: 48%;
    }

    .details h3 {
      margin-bottom: 5px;
      font-size: 18px;
      color: #333;
    }

    .details p {
      margin: 0;
      font-size: 14px;
      color: #555;
    }

    .table-container {
      margin: 0 auto;
      width: 100%;
      margin-bottom: 20px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin: 0 auto;
    }

    th, td {
      padding: 12px;
      text-align: left;
      border-bottom: 1px solid #ddd;
    }

    th {
      background-color: #FFA500;
      color: #fff;
      text-transform: uppercase;
      letter-spacing: 0.1em;
    }

    .total-row {
      font-weight: bold;
    }

    .invoice-total {
      font-size: 1.2em;
      text-align: right;
    }

    .invoice-details {
      text-align: right;
    }

    #stampButton {
      background-color: #333;
      color: #fff;
      border: none;
      padding: 10px 20px;
      cursor: pointer;
      border-radius: 5px;
      transition: background-color 0.3s ease;
    }

    #stampButton:hover {
      background-color: #FFA500;
    }

    .footer p {
      font-size: 12px;
      color: #777;
    }
  </style>

  <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.3/jspdf.umd.min.js"></script>
</head>
<body>
  <div class="invoice-container">
    <div class="header">
      <img src="logo.png" alt="Company Logo">
      <h1>Fattura</h1>
      <p>Farmai.it | Via Giovanni Paolo II  | 089 961111 | info@farmai.it</p>
    </div>

    <div class="details">
      <div>
        <h3>Dettagli Fattura:</h3>
        <p><strong>SDI:</strong> <%= invoice.getSdi() %></p>
        <p><strong>Data emmissione:</strong> <%= invoice.getData_emissione() %></p>
        <p><strong>Scadenza:</strong> <%= invoice.getData_scadenza() %></p>
        <p><strong>Stato pagamento:</strong> <%= invoice.getStato_pagamento() %></p>
      </div>
    </div>

    <div class="table-container">
      <table>
        <thead>
          <tr>
            <th class="item-name">Prodotto</th>
            <th class="item-price">Prezzo</th>
            <th class="item-quantity">Quantita</th>
            <th class="item-total">Totale</th>
          </tr>
        </thead>
        <tbody>
          <% for(int i = 0; i < products.size(); i++) { %>
            <tr>
              <td class="item-name"><%= jewels.get(i).getNome() %></td>
              <td class="item-price">€<%= products.get(i).getPrezzo() %></td>
              <td class="item-quantity"><%= products.get(i).getQuantita() %></td>
              <td class="item-total">€<%= products.get(i).getPrezzo() * products.get(i).getQuantita() %></td>
            </tr>
          <% } %>
        </tbody>
        <tfoot>
          <tr class="total-row">
            <td colspan="3">IVA</td>
            <td class="invoice-total">€<%= invoice.getIva() %></td>
          </tr>
          <tr class="total-row">
            <td colspan="3">Total</td>
            <td class="invoice-total">€<%= invoice.getImporto() %></td>
          </tr>
        </tfoot>
      </table>
    </div>

    <button id="stampButton" onclick="eseguiComandoRapido()">Download</button>

    <div class="footer">
      <p>&copy; 2024 FarMai. All rights reserved.</p>
    </div>
  </div>

  <script>
    function handleKeyDown(event) {
      if (event.ctrlKey && event.key === 'p') {
        eseguiComandoRapido();
      }
    }
    function eseguiComandoRapido() {
      let stampButton = document.getElementById('stampButton');
      stampButton.classList.add('hidden');
      document.getElementById("stampButton").style.visibility = "hidden";
      window.print();
      document.getElementById("stampButton").style.visibility = "initial";
    }
  </script>
</body>
</html>
