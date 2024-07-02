package it.unisa.control;

import java.io.IOException; 
import java.sql.SQLException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import it.unisa.model.*;

public class OrderDetailsControl extends HttpServlet{
    
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static OrderDAO orderModel = new OrderDAO();
    static OrderProductDAO orderProdModel = new OrderProductDAO(); 
    static ProductDAO proModel = new ProductDAO();
    static InvoiceDAO invoiceModel = new InvoiceDAO();
    
    
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        
        ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
        if (client == null){
            response.sendRedirect("login");
            return;
        } 
        String action = request.getParameter("action");
        
        //se l'azione è null, viene preso dalla request l'id dell'ordine cercato per vederne i dettagli
        
        System.out.println("Action: " + action); // Debugging statement

        if (action == null) {
            String orderIdParam = request.getParameter("ordine");
            System.out.println("Ordine parameter: " + orderIdParam); // Debugging statement
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

            OrderBean order = new OrderBean();
            
            try {
                order = orderModel.doRetrieveByKey(id);
            } catch (SQLException e) {
            	System.out.println("Error 1:" + e.getMessage());
                response.sendRedirect("generalError.jsp");
                return;
            }
            //se si è loggati oppure si è l'admin, l'ordine viene settato coem attributo nella request
            if(order.getClient().getUsername().equalsIgnoreCase(client.getEmail()) || client.getEmail().equals("admin@farmai.it")){
                request.setAttribute("detailedOrder", order);    
            }else{ //utente non loggato e non admin che tenta di accedere ai dettaglio di un ordine
                response.sendRedirect("home");
            }
        }//azione per mostrare la fattura
        if(action!=null && action.equalsIgnoreCase("viewInvoice")){
            
            int idordine = Integer.parseInt(request.getParameter("idOrder"));
            InvoiceBean invoice = null;
            
            ArrayList<OrderProductBean> products = null; // dati necessari alla creazione della fattura
			try {
				products = orderProdModel.doRetrieveByKey(idordine);
			} catch (SQLException e) {
				System.out.println("Error 1:" + e.getMessage());
                response.sendRedirect("generalError.jsp");
                return;
            }
            
            ArrayList<ProductBean> productis = new ArrayList<ProductBean>(); // dati necessari alla creazione della fattura
            for(OrderProductBean prodotto : products){
                ProductBean pro = null;
				try {
					pro = proModel.doRetrieveByKey(prodotto.getId_prodotto());
				} catch (SQLException e) {
					System.out.println("Error 1:" + e.getMessage());
                    response.sendRedirect("generalError.jsp");
                    return;
	            }
				productis.add(pro);
            }
            
            try {
                invoice = invoiceModel.doRetrieveByOrder(idordine); // dati necessari alla creazione della fattura
            } catch (SQLException e) {
            	System.out.println("Error 1:" + e.getMessage());
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
        return;
        
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        doGet(request, response);
    }
}