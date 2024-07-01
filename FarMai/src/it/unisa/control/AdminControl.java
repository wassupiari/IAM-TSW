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

@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
	    maxFileSize = 1024 * 1024 * 10,      // 10 MB
	    maxRequestSize = 1024 * 1024 * 50    // 50 MB
	)
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
        		    sendError(request, response); // Invia errore se il Part dell'immagine è mancante o vuoto
        		    return;
        		}

        	// Ottenere il nome del file dal campo del form
        	String nome = request.getParameter("name");
        	String estensione = "jpg";
        	String fileName = nome + "." + estensione;

        	// Costruire il percorso completo per la destinazione del file sul server locale
        	String destinazioneLocale = UPLOAD_DIRECTORY + fileName;
        	Path pathDestinazioneLocale = Paths.get(destinazioneLocale);

        	// Se esiste già un file con lo stesso nome, rinominalo
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
        	    sendError(request, response);
        	    return;
        	}

        	    


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
              	
              if (nome == null || nome.trim().isEmpty() || !nome.matches("^[A-Za-z ]+$")) {
            	  System.out.println("Name 12: " + nome);
            	    sendError(request, response);
            	    return;
            	}
              if(category==null || category.equals("") || (!category.equals("Mamme e bambini") && !category.equals("Salute e cura della persona") && !category.equals("Igiene e benessere"))){
            	  System.out.println("Name 7: " + nome);
                  sendError(request, response);
                  
                  
                  return;
                  
                  
            }
              if(format==null || format.equals("") || (!format.equals("Pomate") && !format.equals("Compresse") && !format.equals("Sciroppi"))){
            	  System.out.println("Name 1: " + nome);
                  sendError(request, response);
                  

                  return;
            }
              if(availability==0 || !(availability > 0 && availability < 100)){
            	  System.out.println("Name 2: " + nome);
                    sendError(request, response);
                    return;
              }
              if(IVA==0 || !(IVA > 0 && IVA < 100)){
            	  System.out.println("Name 3: " + nome);
                    sendError(request, response);
                    return;
              }
              if(price==0 || !(price > 0 && price <= 5000)){
            	  System.out.println("Name 4: " + nome);
                    sendError(request, response);
                    return;
              }
              if(description==null || !description.matches("^[a-zA-Z0-9\\s\\p{P}]{1,500}$")){
            	  System.out.println("Name 5: " + nome);
                    sendError(request, response);
                    return;
              }
              if(discount==-1 || !(discount >= 0 && discount < 100)){
            	  System.out.println("Name 6: " + nome);
                    sendError(request, response);
                    return;
              }
              	
              
              
              

              //AGGIUNTA DEL PRODOTTO NEL DATABASE
              ProductBean pro = new ProductBean();
              pro.setNome(nome);
              pro.setDescrizione(description);
              pro.setPrezzo(price);
              pro.setCategoria(category);
              pro.setSconto(discount);
              pro.setImmagine(fileName);
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
              
              if (action.equals("load")) {
                  ProductBean jewelToModify = new ProductBean();

                  try {
                        jewelToModify = model.doRetrieveByKey(Integer.parseInt(request.getParameter("id")));
                  } catch (NumberFormatException e) {
                	  System.out.println("Error 1:" + e.getMessage());
                        response.sendRedirect("generalError.jsp");
                        return;
                  } catch (SQLException e) {
                	  System.out.println("Error 1:" + e.getMessage());
                        response.sendRedirect("generalError.jsp");
                        return;
                  }

                  request.setAttribute("jewel",jewelToModify);
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
                       
                        sendError(request, response);
                        return;
                  }
                  if(nameM==null || !nameM.matches("^[A-Za-z ]+$")){
                        
                        sendError(request, response);
                        return;
                  }
                  if(categoryM==null || categoryM.equals("") || (!categoryM.equals("Mamme e bambini") && !categoryM.equals("Salute e cura della persona") && !categoryM.equals("Igiene e benessere"))){
                	  System.out.println("Name 7: " + nome);
                      sendError(request, response);
                      
                      
                      return;
                      
                      
                }
                  if(formatM==null || formatM.equals("") || (!formatM.equals("Pomate") && !formatM.equals("Compresse") && !formatM.equals("Sciroppi"))){
                	  System.out.println("Name 1: " + nome);
                      sendError(request, response);
                      

                      return;
                }
                  if(availabilityM==0 || !(availabilityM > 0 && availabilityM <= 100)){
                        
                        sendError(request, response);
                        return;
                  }
                  if(IVAM==0 || !(IVAM > 0 && IVAM < 100)){
                      
                        sendError(request, response);
                        return;
                  }
                  if(priceM==0 || !(priceM > 0 && priceM <= 5000)){
                        
                        sendError(request, response);
                        return;
                  }
                  if(descriptionM==null || !descriptionM.matches("^[a-zA-Z0-9\\s\\p{P}]{1,500}$")){
                        
                        sendError(request, response);
                        return;
                  }
                
                  if(discountM==-1 || !(discountM >= 0 && discountM < 100)){
                        
                        sendError(request, response);
                        return;
                  }

                  pra.setId(idM);
                  pra.setNome(nome);
                  pra.setDescrizione(description);
                  pra.setPrezzo(price);
                  pra.setCategoria(category);
                  pra.setSconto(discount);
                  pra.setImmagine(fileName);
                  pra.setIVA(IVA);
                  pra.setFormato(format);
                  pra.setQuantita(availability);
                  
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

        }
       
          RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/admin.jsp");
          dispatcher.forward(request, response);
      }
      
      
      protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
          doGet(request, response);
    }
	  
      public void sendError(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
          request.setAttribute("error", "FarMai ha incontrato un problema durante l'invio. Per favore, prova a compilare di nuovo il modulo.");
          RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/admin.jsp");
          dispatcher.forward(request, response);
    }
	  
	  
	  
	  
	  
	  
}
