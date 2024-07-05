package it.unisa.control;

import java.io.IOException;
import java.security.SecureRandom;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import it.unisa.model.*;




public class CheckoutControl extends HttpServlet {
	
    private static final long serialVersionUID = 1L;

    static OrderDAO orderModel = new OrderDAO();
    static ProductDAO jewelModel = new ProductDAO();
    static AddressDAO addressmodel = new AddressDAO();
    static PaymentDAO paymentmodel = new PaymentDAO();
    static InvoiceDAO invoicemodel = new InvoiceDAO();

    public CheckoutControl() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
        boolean check = true;
        AddressBean bean =  null;
        InvoiceBean invoice = new InvoiceBean();
        
        if( action == null || action.equals("buy") || action.equals("")){
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/checkout.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        int idcarta;
        int idindirizzo;
        
        if(request.getParameter("carta").equals(""))  // controllo del form server side 
            idcarta = 0;
        else
            idcarta = Integer.parseInt(request.getParameter("carta"));

        if(request.getParameter("indirizzo").equals(""))
            idindirizzo = 0;
        else
            idindirizzo = Integer.parseInt(request.getParameter("indirizzo"));
        
        
        String destinatario = request.getParameter("destinatario");
        String note = request.getParameter("note");
        String spedizione= request.getParameter("spedizione");
        String metpag = request.getParameter("metodo_di_pagamento");
        
        if(destinatario.equals("") || destinatario== null || !destinatario.matches("^[A-Za-z ]+$")){
            sendError(request, response);
            return;
        }
        if(spedizione.equals("") || spedizione== null || (!spedizione.equals("Ritiro in negozio") && !spedizione.equals("Spedizione standard") && !spedizione.equals("Spedizione express") )){
            sendError(request, response);
            return;
        }
        if(note.equals("") || note== null || !note.matches("^[A-Za-z ]+$")){
            sendError(request, response);
            return;
        }
        if(metpag.equals("") || metpag== null || (!metpag.equals("carta_di_credito") && !metpag.equals("carta_di_debito") && !metpag.equals("Paypal"))){
            sendError(request, response);
            return;
        }
        
        int id_ordine;
        
        OrderBean lastorder = new OrderBean(); //necessario per settare l'id dell'ordine che si sta effettuando (bisogna fare anche le insert in composizione)
		try {
			lastorder = orderModel.lastOrder();
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
            response.sendRedirect("generalError.jsp");
            return;
		}
        
        if (lastorder== null){
            id_ordine = 0;
        }
        else{
            id_ordine = lastorder.getId();
        }
        

            if (cart != null && cart.getProducts().size() != 0){ // se il carrello non è vuoto, si prendono i prodotti e si salvano in composizione con chiave esterna sull'id dell'ordine 
                
			     if(action != null && action.equalsIgnoreCase("confirm_buy")) {

                    //INIZIALIZZA L'ID, COSI DA POTER POPOLARE L'ARRAY
                    id_ordine++;
                    OrderBean order = new OrderBean();
                    float totale = 0;
                    float prezzo = 0;

                    //CICLO PER POPOLARE ARRAYLIST DEGLI ORDERPRODUCT
                    ArrayList<OrderProductBean> products = new ArrayList<>(); 
                    for (ProductBean product : cart.getProducts()) {
                        OrderProductBean prodotto = new OrderProductBean();
                        prodotto.setId_ordine(id_ordine); 
                        prodotto.setId_prodotto(product.getId());
                        prodotto.setPrezzo(product.getPrezzo());
                        prodotto.setIVA(product.getIVA());
                        prodotto.setQuantita(product.getQuantita());
                        products.add(prodotto);

                        if (product.getSconto() != 0) {
                            prezzo = (product.getPrezzo() * (100 - product.getSconto())) / 100; // Calcolo del prezzo scontato
                        } else {
                            prezzo = product.getPrezzo();
                        }
                        totale = totale + (prezzo * product.getQuantita());
                    }


                    order.setProducts(products);
                    
                    order.setId(id_ordine);
                    order.setClient(client);
                    if (spedizione.equalsIgnoreCase("Spedizione express")){
                        
                        totale = totale + 5;
                    }
                    
                    order.setPrezzo_totale(totale);
                    order.setDestinatario(destinatario);
                    order.setMetodo_di_pagamento(metpag);
                     
                    try {
						order.setCircuito(paymentmodel.doRetrieveByKey(idcarta).getCircuito());//prende il numero carta e il circuito dal paymentmethodbean usato per pagare l'ordine
					} catch (SQLException e) {                                                 //e lo inserisce nell'ordine (mantiene la storia degli ordini nel database)
						System.out.println("Error:" + e.getMessage());
                        response.sendRedirect("generalError.jsp");
                        return;
					}
                    
                    try {
						order.setNumero_carta(paymentmodel.doRetrieveByKey(idcarta).getNumero_carta());
					} catch (SQLException e) {
						System.out.println("Error:" + e.getMessage());
                        response.sendRedirect("generalError.jsp");
                        return;
					}
                    
                    try {
						bean = addressmodel.doRetrieveByKey(idindirizzo);// prende l'indirizzo dall' addressbean scelto per effettuare l'ordine e lo inserisce in ordine sottoforma di stringa formattata
					} catch (SQLException e) {                         // (mantiene la storia degli ordini)
						System.out.println("Error:" + e.getMessage());
                        response.sendRedirect("generalError.jsp");
                        return;
					}
                    
                    String indirizzospedizione = bean.getVia() + "," + bean.getCitta();
                    order.setIndirizzo_di_spedizione(indirizzospedizione);

                    SecureRandom r = new SecureRandom(); // uso di un Secure Random per generare il numero di tracking
                    int low = 100000;
                    int high = 10000000;
                    String result = Integer.toString(r.nextInt(high-low) + low);
                    order.setNumero_di_tracking(result);
                    
                    order.setNote(note);
                    order.setData(new java.sql.Date(Calendar.getInstance().getTime().getTime()));
                    order.setMetodo_di_spedizione(spedizione);
                    

                    try {
                        // Controllo che la quantità di prodotti inserita nel carrello sia ancora disponibile
                        for (ProductBean product : cart.getProducts()) {
                            if (product.getQuantitaS() > product.getQuantita()) {
                                check = false;
                            }
                        }
                        
                        if (check != false) {    
                            // (il salvataggio degli orderproductbean viene effettuato dalla doSave dell'orderDAO)
                            orderModel.doSave(order);
                            
                        } else {
                            response.sendRedirect("generalError.jsp");
                            System.out.println("sono qui");
                            return;
                        }
                    } catch (SQLException e) {
                        System.out.println("Error:" + e.getMessage());
                        response.sendRedirect("generalError.jsp");
                        return;
                    }

                    
                  //GENERAZIONE DELLA FATTURA
                    SecureRandom n = new SecureRandom();
                    int low1 = 1000000;
                    int high2 = 9999999;
                    String sdi = Integer.toString(n.nextInt(high2-low1) + low1);

                    Date date = Calendar.getInstance().getTime();  
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
                    String data_emissione = dateFormat.format(date);

                    // Calcolo della data di scadenza (4 giorni dopo la data di emissione)
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(date);
                    cal.add(Calendar.DATE, 4); // Aggiungi 4 giorni
                    String data_scadenza = dateFormat.format(cal.getTime());

                    invoice.setSdi(sdi);
                    invoice.setImporto(totale);
                    invoice.setData_emissione(data_emissione);
                    invoice.setData_scadenza(data_scadenza);
                    invoice.setStato_pagamento("PAGATA");
                    invoice.setIva(10);
                    invoice.setId(id_ordine);

                    try {
                        invoicemodel.doSave(invoice);
                    } catch (SQLException e) {
                        System.out.println("Error:" + e.getMessage());
                        response.sendRedirect("generalError.jsp");
                        return;
                    }

                    
                    //IL CARRELLO ADESSO E' VUOTO
                    request.getSession().removeAttribute("cart");
                    request.getSession().setAttribute("cart", null);
                    
                    response.sendRedirect("catalogo");
                    return;
                }

            }else {
                response.sendRedirect("cartError.jsp");
                return;
            }
        
    }    

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        doGet(request, response);
    }
    
    public void sendError(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
        request.setAttribute("error", "JadeTear encountered a problem during the payment. Please, try to fill up the form correctly and check your data before submitting.");
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/checkout.jsp");
        dispatcher.forward(request, response);
    }
}