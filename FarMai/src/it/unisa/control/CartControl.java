package it.unisa.control;

import it.unisa.model.*;

import java.io.IOException; 
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.logging.Level;
import java.util.logging.Logger;



public class CartControl extends HttpServlet {
	
	private static final Logger LOGGER = Logger.getLogger( CartControl.class.getName() );
    
    private static ProductDAO model = new ProductDAO();
    

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    	Cart cart = (Cart)request.getSession().getAttribute("cart");
		if(cart == null) {
			cart = new Cart();
			request.getSession().setAttribute("cart", cart);
		}
		
		String action = request.getParameter("action");
		
		try {
			if (action != null) {
				if (action.equalsIgnoreCase("add")) {
					int id = Integer.parseInt(request.getParameter("id"));
					cart.addProduct(model.doRetrieveByKey(id));
				} else if (action.equalsIgnoreCase("delete")) {
					int id = Integer.parseInt(request.getParameter("id"));
					cart.deleteProduct(model.doRetrieveByKey(id));
			        
				}			
		}
			} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}

		request.getSession().setAttribute("cart", cart);
		request.setAttribute("cart", cart);
		
            
//        ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
//        
//        if (client!= null && client.getEmail().equals("admin@farmai.it")) {
//        	
//        	 response.sendRedirect("catalogo");
//             return;
//        	
//        }
//
//        String id = request.getParameter("id");
		

        
//        if(action == null)
//        	action = "seeCart"; 
//
//        ProductBean jewel = new ProductBean();
//        
//		try {
//			jewel = model.doRetrieveByKey(Integer.parseInt(id));
//		} catch (NumberFormatException e) {
//			 LOGGER.log( Level.SEVERE, e.toString(), e );
//             
//		} catch (SQLException e) {
//			LOGGER.log( Level.SEVERE, e.toString(), e );
//            response.sendRedirect("generalError.jsp");
//            return;
//		}
//         
//            
//        if (action.equals("add")){
//            //controllo che ci siano abbastanza prodotti da aggiungere al carrello
//            if(jewel.getQuantita()>0)
//                cart.addProduct(jewel);
//            else {
//            	
//            	request.setAttribute("erroresoldout", "We are sorry but this jewel's sold out");
//            }
//                
//        }
//            
//        if (action.equals("delete"))
//            {
//            cart.removeProduct(jewel);
//            System.out.println("Prodotto rimosso dal carrello!");
//            }
//
//        if (action.equals("modify")){
//                if((jewel.getQuantita() - Integer.parseInt(request.getParameter("quantity"))) >= 0 )
//                        cart.changeQuantity(jewel, Integer.parseInt(request.getParameter("quantity")));
//                else {
//                	
//                	request.setAttribute("erroredisponibilita", "You selected too many of this jewel! Try lowering the quantity.");
//                	
//                }
//                
//                        
//        }
            
//        if (cart != null && cart.getProducts().size() != 0){ // "procedi al pagamento" : se l'utente non è loggato, lo porta alla login.jsp
//            if(action.equalsIgnoreCase("buy")) {
//                // se non  loggato lo portiamo al login
//                if(client == null) {
//                    response.sendRedirect("login");
//                    return;
//                }
//                request.getSession().setAttribute("cart", cart);
//                
//                ArrayList<AddressBean> indirizzi = null;
//				try {
//					indirizzi = addressModel.doRetrieveByClient(client.getUsername());
//				} catch (SQLException e) {
//					LOGGER.log( Level.SEVERE, e.toString(), e );
//                    response.sendRedirect("generalError.jsp");
//                    return;
//				}
//				
//                ArrayList<PaymentMethodBean> carte = null;
//				try {
//                    carte =  paymentModel.doRetrieveByClient(client.getUsername());
//				} catch (SQLException e) {
//					LOGGER.log( Level.SEVERE, e.toString(), e );
//                    response.sendRedirect("generalError.jsp");
//                    return;
//                    
//				}
//				
//                if(!indirizzi.isEmpty() && !carte.isEmpty()){// "procedi al pagamento" : se l'utente è loggato ed ha almeno un metodo di pagamento e un idirizzo può procedere all'acquisto
//                
//                	request.setAttribute("addresses", indirizzi);
//                	request.setAttribute("payments",carte);
//                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/payment");
//                    dispatcher.forward(request, response);       
//                    return;
//                }
//                else{ // altrimenti gli viene chiesto di inserire dei metodi di pagamento nella client.jsp
//                    request.setAttribute("carterror","Please insert at least one card before proceeding with your purchase");
//                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/userdetails");
//                    dispatcher.forward(request, response);
//                    return;
//                }
//
//            }
//        }
        
  
        

        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/CartView.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}