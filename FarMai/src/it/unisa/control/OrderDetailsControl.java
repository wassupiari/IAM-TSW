package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.model.*;



public class OrderDetailsControl extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static OrderDAO orderModel = new OrderDAO();
    private static OrderProductDAO orderProdModel = new OrderProductDAO();
    private static ProductDAO proModel = new ProductDAO();
    private static InvoiceDAO invoiceModel = new InvoiceDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
        if (client == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");

        if (action == null) {
            String orderIdParam = request.getParameter("ordine");
            if (orderIdParam == null || orderIdParam.isEmpty()) {
                response.sendRedirect("generalError.jsp");
                return;
            }

            int id;
            try {
                id = Integer.parseInt(orderIdParam);
            } catch (NumberFormatException e) {
                System.out.println("Error: Invalid order ID format.");
                response.sendRedirect("generalError.jsp");
                return;
            }

            OrderBean order = null;
            try {
                order = orderModel.doRetrieveByKey(id);
            } catch (SQLException e) {
                System.out.println("Error retrieving order: " + e.getMessage());
                response.sendRedirect("generalError.jsp");
                return;
            }

            if (order == null) {
                System.out.println("Order not found with ID: " + id);
                response.sendRedirect("generalError.jsp");
                return;
            }

            // Check if the logged-in user or admin has access to view order details
            if (client.getEmail().equals("admin@farmai.it") || client.getEmail().equalsIgnoreCase(client.getEmail())) {
                request.setAttribute("detailedOrder", order);
            } else {
                response.sendRedirect("home");
                return;
            }
        } else if (action.equalsIgnoreCase("viewInvoice")) {
            int idordine;
            try {
                idordine = Integer.parseInt(request.getParameter("idOrder"));
            } catch (NumberFormatException e) {
                System.out.println("Error: Invalid order ID format.");
                response.sendRedirect("generalError.jsp");
                return;
            }

            InvoiceBean invoice = null;
            ArrayList<OrderProductBean> products = null;
            ArrayList<ProductBean> productis = new ArrayList<>();

            try {
                products = orderProdModel.doRetrieveByKey(idordine);

                for (OrderProductBean prodotto : products) {
                    ProductBean pro = proModel.doRetrieveByKey(prodotto.getId_prodotto());
                    productis.add(pro);
                }

                invoice = invoiceModel.doRetrieveByOrder(idordine);
            } catch (SQLException e) {
                System.out.println("Error retrieving invoice or products: " + e.getMessage());
                response.sendRedirect("generalError.jsp");
                return;
            }

            request.setAttribute("jewels", productis);
            request.setAttribute("orderProducts", products);
            request.setAttribute("invoice", invoice);

            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/invoice.jsp");
            dispatcher.forward(request, response);
            return;
        }

        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/orderdetails.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
