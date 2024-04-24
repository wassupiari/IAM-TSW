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
    
    <style >
    @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;1,100;1,200;1,300;1,400;1,500;1,600;1,700&display=swap'); 
    html, body {
  height: 100%;
  width: 100%;
  margin: 0;
  font-family: "IBM plex Sans";
}
 
    /* Stile generale del catalogo */
    .fashion_section {
        padding: 50px 0;
        text-align: center; 
    }

    /* Stile del titolo */
    .fashion_taital {
        font-size: 36px;
        margin-bottom: 30px;
    }

    /* Stile dei singoli elementi del catalogo */
    .box_main {
        background-color: #f5f5f5;
        border-radius: 12px;
        padding: 20px;
        margin-bottom: 30px;
        text-align: center;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        display: inline-block; 
    }

    /* Stile del testo del prodotto */
    .shirt_text {
        font-size: 24px;
        margin-bottom: 15px;
    }

    /* Stile del prezzo */
    .price_text {
        font-size: 18px;
        text-align: right;
    }

    /* Stile dell'immagine del prodotto */
    .electronic_img img {
        width: 80%;
        border-radius: 12px;
    }

    /* Stile dei pulsanti */
    .btn_main {
        margin-top: 20px;
    }

    .buy_bt,
    .seemore_bt {
        display: inline-block;
        background-color: #007bff;
        color: #fff;
        padding: 10px 20px;
        border-radius: 5px;
        margin-right: 10px;
        text-decoration: none;
        transition: background-color 0.3s ease;
    }

    .buy_bt:hover,
    .seemore_bt:hover {
        background-color: #0056b3;
    }

    /* Stile per il layout 4x2 */
    .row {
        display: flex;
        flex-wrap: wrap;
        justify-content: center; /* Aggiunto per centrare il contenuto */
    }

    .col-lg-3 {
        flex: 0 0 calc(25% - 30px); /* Calcolato per 4 elementi per riga con spaziatura */
        max-width: calc(25% - 30px);
        margin-right: 30px;
        margin-bottom: 30px;
    }

    @media (max-width: 991.98px) {
        .col-lg-3 {
            flex: 0 0 calc(50% - 30px); /* Calcolato per 2 elementi per riga con spaziatura */
            max-width: calc(50% - 30px);
        }
    }
    
    </style>
</head>
<body>
    <%@include file="header.jsp" %>
    
<div class="fashion_section">
    <div class="container">
        <h1 class="fashion_taital">Electronic</h1>
        <div class="row">
            <% 
                for (ProductBean bean : products) {
            %>
            <div class="col-lg-3 col-md-6 col-sm-6">
                <div class="box_main">
                   
                   
                    <div class="electronic_img"><img src="<%= bean.getImmagine() %>"></div>
                     <h4 class="shirt_text"><%= bean.getNome() %></h4>
                     <p class="price_text"><span style="color: #262626;"><%= bean.getPrezzo() %></span></p>
                    <div class="btn_main">
                        <div class="buy_bt"><a href="#">Buy Now</a></div>
                        <div class="seemore_bt"><a href="details?id=<%= bean.getId()%>">See More</a></div>
                    </div>
                    
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>
</div>

</body>
</html>
