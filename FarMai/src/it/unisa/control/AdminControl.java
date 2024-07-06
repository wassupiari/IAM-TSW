package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import it.unisa.model.*; 

@MultipartConfig
public class AdminControl extends HttpServlet { 
	  private static final long serialVersionUID = 1L;
	  
	  private static final String UPLOAD_DIRECTORY = "C:/Users/capua/Desktop/IAM-TSW/FarMai/WebContent/images/";

      OrderDAO orderModel = new OrderDAO();
      ProductDAO model = new ProductDAO();
      ClientDAO clientModel = new ClientDAO();
      
      
      protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    	  ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
          if(client==null || !client.getEmail().equals("admin@farmai.it") ){
                response.sendRedirect("home");	
                return;
          }
          
          String action = request.getParameter("action");
          ArrayList<OrderBean> orders = new ArrayList<OrderBean>();
          ArrayList<ClientBean> clients = new ArrayList<ClientBean>();

          if(action == null || action.equals("")){
              RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/admin.jsp");
              dispatcher.forward(request, response);
              return;
        }
          
          System.out.println("Action: " + action); // Debug
          
          if (action.equals("insert")) {

        	  Part filePart = request.getPart("image");
        	  if (filePart == null || filePart.getSize() == 0) {
        		  sendError(request, response,"err"); // Invia errore se il Part dell'immagine � mancante o vuoto
        		    return;
        		}

        	// Ottenere il nome del file dal campo del form
        	String nome = request.getParameter("name");
        	String sanitizedFileName = nome.replaceAll("\\s+", "_");
        	String estensione = "jpg";
        	String fileName = sanitizedFileName + "." + estensione;
        	String prefixedFileName = "images/" + fileName;

        	// Costruire il percorso completo per la destinazione del file sul server locale
        	String destinazioneLocale = UPLOAD_DIRECTORY + fileName;
        	Path pathDestinazioneLocale = Paths.get(destinazioneLocale);

        	// Se esiste gi� un file con lo stesso nome, rinominalo
        	for (int i = 2; Files.exists(pathDestinazioneLocale); i++) {
        	    String newFileName = i + "_" + nome + "." + estensione;
        	    destinazioneLocale = UPLOAD_DIRECTORY + newFileName;
        	    pathDestinazioneLocale = Paths.get(destinazioneLocale);
        	}

        	// Scrivere il file nella cartella locale di destinazione
        	try (InputStream fileInputStream = filePart.getInputStream()) {
        	    Files.createDirectories(pathDestinazioneLocale.getParent());
        	    Files.copy(fileInputStream, pathDestinazioneLocale);
        	} catch (IOException e) {
        	    e.printStackTrace();
        	    sendError(request, response,"immagine error");
        	    return;
        	}

        	String tomcatBase = System.getProperty("catalina.base");  
			String targetPath = tomcatBase + "//webapps//FarMai//images//" + fileName;
			InputStream fileInputStream2 = filePart.getInputStream();
			
			Path targetImagePath = Path.of(targetPath);
			Files.copy(fileInputStream2, targetImagePath);


              //controllo e set di tutti i parametri destinati al ProductBean prima di essere salvato nel database
              int availability;
              float IVA;
              float price;
              int discount;

              if(request.getParameter("availability").equals(""))
                    availability = 0;
              else
            	  availability = Integer.parseInt(request.getParameter("availability"));
              
              System.out.println("Availability param: " + availability);


              if(request.getParameter("IVA").equals(""))
                    IVA = 0;
              else
                    IVA = Float.parseFloat(request.getParameter("IVA"));

              if(request.getParameter("price").equals(""))
                    price = 0;
              else
                    price = Float.parseFloat(request.getParameter("price"));

              if(request.getParameter("discount").equals(""))
                    discount = 0;
              else
                    discount = Integer.parseInt(request.getParameter("discount"));

            
              String description = request.getParameter("description");
              String category = request.getParameter("category");
              String format = request.getParameter("format");
              	
              if (nome == null || !nome.matches("^[a-zA-Z0-9\\s\\p{P}]{1,500}$")) {
            	    sendError(request, response, "nome error");
            	    return;
            	}
              if(category==null || category.equals("") || (!category.equals("Mamme e bambini") && !category.equals("Salute e cura della persona") && !category.equals("Igiene e benessere"))){
            	  System.out.println("Name 7: " + nome);
            	  sendError(request, response,"categoria error");
                  
                  return;
                  
                  
            }
              if(format==null || format.equals("") || (!format.equals("Pomate") && !format.equals("Compresse") && !format.equals("Sciroppi"))){
            	  System.out.println("Name 1: " + nome);
            	  sendError(request, response,"formato error");
                  

                  return;
            }
              if(availability==0 || !(availability > 0 && availability < 400)){
            	  System.out.println("Name 2: " + nome);
            	  sendError(request, response,"quantita error");
                    return;
              }
              if(IVA==0 || !(IVA > 0 && IVA < 100)){
            	  System.out.println("Name 3: " + nome);
            	  sendError(request, response,"iva error");
                    return;
              }
              if(price==0 || !(price > 0 && price <= 5000)){
            	  System.out.println("Name 4: " + nome);
            	  sendError(request, response,"prezzo error");
                    return;
              }
              if(description==null || !description.matches("^[a-zA-Z0-9\\s\\p{P}]{1,500}$")){
            	  System.out.println("Name 5: " + nome);
            	  sendError(request, response,"descrizione error");
                    return;
              }
              if(discount==-1 || !(discount >= 0 && discount < 100)){
            	  System.out.println("Name 6: " + nome);
            	  sendError(request, response,"sconto error");
                    return;
              }
              	
              
              
              

              //AGGIUNTA DEL PRODOTTO NEL DATABASE
              ProductBean pro = new ProductBean();
              pro.setNome(nome);
              pro.setDescrizione(description);
              pro.setPrezzo(price);
              pro.setCategoria(category);
              pro.setSconto(discount);
              pro.setImmagine(prefixedFileName);
              pro.setIVA(IVA);
              pro.setFormato(format);
              pro.setQuantita(availability);
              
              
              
              


              try {
                    model.doSave(pro);
              } catch (SQLException e) {
            	  System.out.println("Error 1:" + e.getMessage());
                  response.sendRedirect("generalError.jsp");
                    
                    return;
              }
              
        }
          
          if (action.equals("load")) {
              ProductBean farmaciToModify = new ProductBean();

              try {
                    farmaciToModify = model.doRetrieveByKey(Integer.parseInt(request.getParameter("id")));
              } catch (NumberFormatException e) {
            	  System.out.println("Error 1:" + e.getMessage());
                  response.sendRedirect("generalError.jsp");
                    return;
              } catch (SQLException e) {
            	  System.out.println("Error 1:" + e.getMessage());
                  response.sendRedirect("generalError.jsp");
                    return;
              }

              request.setAttribute("farmaci",farmaciToModify);
        }





          
          if (action.equals("modify")) {
              ProductBean pra = new ProductBean();

              int idM;
              int availabilityM;
              float IVAM;
              float priceM;
              int discountM;

              if(request.getParameter("idM").equals(""))
                    idM = 0;
              else
                    idM = Integer.parseInt(request.getParameter("idM"));

              if(request.getParameter("availabilityM").equals(""))
                    availabilityM = 0;
              else
                    availabilityM = Integer.parseInt(request.getParameter("availabilityM"));

              if(request.getParameter("IVAM").equals(""))
                    IVAM = 0;
              else
                    IVAM = Float.parseFloat(request.getParameter("IVAM"));

              if(request.getParameter("priceM").equals(""))
                    priceM = 0;
              else
                    priceM = Float.parseFloat(request.getParameter("priceM"));

              if(request.getParameter("discountM").equals(""))
                    discountM = 0;
              else
                    discountM = Integer.parseInt(request.getParameter("discountM"));

              String nameM = request.getParameter("nameM");
              String categoryM = request.getParameter("categoryM");
              String formatM = request.getParameter("formatM");
              String descriptionM = request.getParameter("descriptionM");
            

              if(idM==0 ){
                   
            	  sendError(request, response,"err 1");
                    return;
              }
              if(nameM==null || !nameM.matches("^[a-zA-Z0-9\\s\\p{P}]{1,500}$")){
                    
            	  sendError(request, response,"err 2");
                    return;
              }
              if(categoryM==null || categoryM.equals("") || (!categoryM.equals("Mamme e bambini") && !categoryM.equals("Salute e cura della persona") && !categoryM.equals("Igiene e benessere"))){
            	  System.out.println("Name 7: " + nameM);
            	  sendError(request, response,"er r");
                  
                  
                  return;
                  
                  
            }
              if(formatM==null || formatM.equals("") || (!formatM.equals("Pomate") && !formatM.equals("Compresse") && !formatM.equals("Sciroppi"))){
            	  System.out.println("Name 1: " + nameM);
                  sendError(request, response,"err 3");
                  

                  return;
            }
              if(availabilityM==0 || !(availabilityM > 0 && availabilityM <= 400)){
                    
            	  sendError(request, response,"err 4");
                    return;
              }
              if(IVAM==0 || !(IVAM > 0 && IVAM < 100)){
                  
            	  sendError(request, response,"err 5");
                    return;
              }
              if(priceM==0 || !(priceM > 0 && priceM <= 5000)){
                    
            	  sendError(request, response,"err 6");
                    return;
              }
              if(descriptionM==null || !descriptionM.matches("^[a-zA-Z0-9\\s\\p{P}]{1,500}$")){
                     
            	  sendError(request, response,"err 31");
                    return;
              }
            
              if(discountM==-1 || !(discountM >= 0 && discountM < 100)){
                    
            	  sendError(request, response,"err 123");
                    return;
              }

              pra.setId(idM);
              pra.setNome(nameM);
              pra.setDescrizione(descriptionM);
              pra.setPrezzo(priceM);
              pra.setCategoria(categoryM);
              pra.setSconto(discountM);
              pra.setImmagine(request.getParameter("imageM"));
              pra.setIVA(IVAM);
              pra.setFormato(formatM);
              pra.setQuantita(availabilityM);
              
              //effettiva modifica chiamando il DAO 
              try {
                    model.doModify(pra);
              } catch (SQLException e) {
            	  System.out.println("Error 123:" + e.getMessage());
                  response.sendRedirect("generalError.jsp");
                    return;
              }

        }
          if (action.equals("delete")) {
              String id = request.getParameter("id");

              try {
                    model.doDelete(Integer.parseInt(id));
              } catch (NumberFormatException e) {
            	  System.out.println("Error 3:" + e.getMessage());
                    response.sendRedirect("generalError.jsp");
                    return;
              } catch (SQLException e) {
            	  System.out.println("Error 3:" + e.getMessage());
                    response.sendRedirect("generalError.jsp");
                    return;
              }

        }  
          
        //azione che determina la vista di tutti gli ordini effettuati 
          if (action.equals("ordersNoFilter")){

                try {
                      orders = orderModel.doRetrieveAll();
                } catch (SQLException e) {
                	System.out.println("Error 1:" + e.getMessage());
                    response.sendRedirect("generalError.jsp");
                      return;
                }

                request.setAttribute("ordini", orders);
                
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/clientorders.jsp");
                dispatcher.forward(request, response);
                return;
          }

          //azione di ordinamento (due tipi: per data, per cliente) per la clientorders.jsp
          if (action.equals("orders")){
                
                //ordinamento per cliente
                if (Boolean.parseBoolean(request.getParameter("Order By Client"))== true){

                      String user = request.getParameter("cliente");

                      try {
                            orders = orderModel.doRetrieveByClient(user);
                      } catch (SQLException e) {
                    	  System.out.println("Error 1:" + e.getMessage());
                          response.sendRedirect("generalError.jsp");
                      }
                      
                      //controllo che l'utente inserito abbia effettuato degli ordini
                      if(orders.size()==0){
                            request.setAttribute("clientError", "This user doesn't have orders saved");
                          
                            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/clientorders.jsp");
                            dispatcher.forward(request, response);
                            return;
                      }
                      

                }//ordinamento per data
                if(Boolean.parseBoolean(request.getParameter("Order By Date"))== true){

                      String data_da = (String) request.getParameter("data_da");
                      String data_a = (String) request.getParameter("data_a");

                      if (data_da.compareTo(data_a)< 0){
                            try {
                                  orders = orderModel.DateOrders(data_da,data_a);
                            } catch (SQLException e) {
                            	System.out.println("Error 1:" + e.getMessage());
                                response.sendRedirect("generalError.jsp");
                            }
                      } 
                        else { //se la data "da" � pi� recente della data "a"
                              request.setAttribute("dateError", "Insert valid dates");
                              RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/clientorders.jsp");
                              dispatcher.forward(request, response);
                              return;
                        } 
                }
                //ordinamento sia per data che per utente
                if ((Boolean.parseBoolean(request.getParameter("Order By Date"))== true) && (Boolean.parseBoolean(request.getParameter("Order By Client"))== true)){

                      String user = request.getParameter("cliente");
                      String data_da = (String) request.getParameter("data_da");
                      String data_a = (String) request.getParameter("data_a");
                      try {
                            orders = orderModel.ClientDateOrders(user,data_da,data_a);
                      } catch (SQLException e) {
                    	  System.out.println("Error 1:" + e.getMessage());
                          response.sendRedirect("generalError.jsp");
                            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin?action=ordersNoFilter");
                            dispatcher.forward(request, response);
                            return;
                      }
                }


                request.setAttribute("ordini", orders);

                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/clientorders.jsp");
                dispatcher.forward(request, response);
                return;

          }
          //action di ordinamento dei clienti senza alcun filtro per la client.jsp
          if (action.equals("clientsNoFilter")){

                try {
                      clients = clientModel.doRetrieveAll();
                } catch (SQLException e) {
                	System.out.println("Error 1:" + e.getMessage());
                    response.sendRedirect("generalError.jsp");
                      return;
                }
                
                


                request.setAttribute("clienti", clients);

                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/client.jsp");
                dispatcher.forward(request, response);

                return;
          }

          if (action.equals("ByClient")){ //ordinamento per un particolare utente

                String user = request.getParameter("cliente");
                ClientBean person = null;

                try {
                    person = (clientModel.doRetrieveByKey(user));
                } catch (SQLException e) {
              	  
                	System.out.println("Error 1:" + e.getMessage());
                    response.sendRedirect("generalError.jsp");
                      response.sendRedirect("generalError.jsp");
                      return;
                      
                }
                //controllo che l'utente esista
                if (person==null) {
                    request.setAttribute("clientError", "This user doesn't exist");  
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/client.jsp");
                    dispatcher.forward(request, response);
                    return;
                }

                clients.add(person);
                request.setAttribute("clienti", clients);

                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/client.jsp");
                dispatcher.forward(request, response);
                return;
          }
          
          
       
          RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/admin.jsp");
          dispatcher.forward(request, response);
      }
      
      
      protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
          doGet(request, response);
    }
	  
      public void sendError(HttpServletRequest request, HttpServletResponse response, String errorMessage)
    	        throws ServletException, IOException {
    	    request.setAttribute("error", errorMessage);
    	    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/admin.jsp");
    	    dispatcher.forward(request, response);
    	}


	  
	  
	  
	  
	  
	  
}
