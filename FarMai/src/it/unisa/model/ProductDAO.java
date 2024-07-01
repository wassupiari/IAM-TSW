package it.unisa.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ProductDAO  {
	
	
	private static DataSource ds;

	static {
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context) initCtx.lookup("java:comp/env");

			ds = (DataSource) envCtx.lookup("jdbc/farmacia");

		} catch (NamingException e) {
			System.out.println("Error:" + e.getMessage());
		}
	}
	
	private static final String TABLE_NAME = "prodotto";
	  
	  public ProductDAO(){
	  }
	  
	  
	  
	  public synchronized int doSave(ProductBean product) throws SQLException {
		    Connection connection = null;
		    PreparedStatement preparedStatement = null;
		    int id = -1;

		    String insertSQL = "INSERT INTO " + TABLE_NAME
		                       + " (nome, descrizione, prezzo, categoria, sconto, immagine, iva, formato, quantita) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

		    try {
		        connection = ds.getConnection();
		        preparedStatement = connection.prepareStatement(insertSQL, PreparedStatement.RETURN_GENERATED_KEYS);
		        preparedStatement.setString(1, product.getNome());
		        preparedStatement.setString(2, product.getDescrizione());
		        preparedStatement.setFloat(3, product.getPrezzo());
		        preparedStatement.setString(4, product.getCategoria());
		        preparedStatement.setInt(5, product.getSconto());
		        preparedStatement.setString(6, product.getImmagine());
		        preparedStatement.setFloat(7, product.getIVA());
		        preparedStatement.setString(8, product.getFormato());
		        preparedStatement.setInt(9, product.getQuantita());

		        preparedStatement.executeUpdate();

		        ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
		        if (generatedKeys.next()) {
		            id = generatedKeys.getInt(1);
		        } else {
		            throw new SQLException("Inserimento fallito, nessun ID generato.");
		        }
		    } finally {
		        try {
		            if (preparedStatement != null) {
		                preparedStatement.close();
		            }
		        } finally {
		            if (connection != null) {
		                connection.close();
		            }
		        }
		    }
		    return id;
		}


	  
	  public synchronized ProductBean doRetrieveByKey(int id) throws SQLException {
		    Connection connection = null;
		    PreparedStatement preparedStatement = null;
		    ResultSet rs = null;
		    ProductBean drug = null; // Inizializziamo a null per gestire il caso in cui il prodotto non sia trovato

		    String selectSQL = "SELECT * FROM " + ProductDAO.TABLE_NAME + " WHERE ID = ?";

		    try {
		        connection = ds.getConnection();
		        preparedStatement = connection.prepareStatement(selectSQL);
		        preparedStatement.setInt(1, id);

		        rs = preparedStatement.executeQuery();

		        if (rs.next()) {
		            drug = new ProductBean();
		            drug.setId(rs.getInt("ID"));
		            drug.setNome(rs.getString("Nome"));
		            drug.setDescrizione(rs.getString("Descrizione"));
		            drug.setPrezzo(rs.getFloat("Prezzo"));
		            drug.setCategoria(rs.getString("Categoria"));
		            drug.setSconto(rs.getInt("Sconto"));
		            drug.setImmagine(rs.getString("Immagine"));
		            drug.setIVA(rs.getFloat("IVA"));
		            drug.setFormato(rs.getString("Formato"));
		            drug.setQuantita(rs.getInt("Quantita"));
		            // Impostare gli altri attributi del prodotto se necessario
		        }

		    } finally {
		        try {
		            if (rs != null) rs.close();
		            if (preparedStatement != null) preparedStatement.close();
		        } finally {
		            if (connection != null) connection.close();
		        }
		    }

		    return drug;
		}

	  
	  
	  public synchronized List<ProductBean> doRetrieveAll() throws SQLException{
		    //tutti i prodotti
		    Connection connection = null;
		    PreparedStatement preparedStatement = null;

		    List<ProductBean> products = new ArrayList<ProductBean>();
		    
		    String selectSQL = "SELECT * FROM " + ProductDAO.TABLE_NAME + " ORDER BY Sconto DESC";

		    
		    
		    try{
		      connection = ds.getConnection();
		      preparedStatement = connection.prepareStatement(selectSQL);
		      
		      ResultSet rs = preparedStatement.executeQuery();
		      
		      while (rs.next()) {
		    	    ProductBean drug = new ProductBean();
		    	  
			        drug.setId(rs.getInt("ID"));
			        drug.setNome(rs.getString("Nome"));
			        drug.setCategoria(rs.getString("Categoria"));
			        drug.setImmagine(rs.getString("Immagine"));
			        drug.setQuantitaS(rs.getInt("Quantita"));
			        drug.setIVA(rs.getFloat("IVA"));
			        drug.setPrezzo(rs.getFloat("prezzo"));
			        drug.setDescrizione(rs.getString("Descrizione"));
			        drug.setFormato(rs.getString("Formato"));
			        drug.setSconto(rs.getInt("Sconto"));
			        
			        products.add(drug);
			      }
		      
		      
		    } finally {
		      try {
		        if (preparedStatement != null)
		          preparedStatement.close();
		      } finally {
		        if (connection != null)
		          connection.close();
		      }
		    }
		    return products;
		  }
	  
	  public synchronized void updateQuantity (int id, int newQuantity) throws SQLException {  

		    Connection connection = null;
		    PreparedStatement preparedStatement = null; 

		    String updateSQL = "UPDATE " + ProductDAO.TABLE_NAME + " SET Quantita = ? WHERE id = ?";  

		    try {
		      connection = ds.getConnection(); 
		      preparedStatement = connection.prepareStatement(updateSQL);
		      preparedStatement.setInt(1, newQuantity);
		      preparedStatement.setInt(2, id);

		      preparedStatement.executeUpdate(); 

		      
		    }

		    finally {
		      try {
		        if (preparedStatement != null)
		          preparedStatement.close();
		      } 

		      finally {
		        if (connection != null)
		          connection.close();
		      }
		    }
		  }
	  
	  
	  public synchronized boolean doDelete(int id) throws SQLException{
		    //ELIMINA UN PRODOTTO DAL DATABASE
		    Connection connection = null;
		    PreparedStatement preparedStatement = null;
		    
		    int result = 0;
		    
		    String deleteSQL = "DELETE FROM " + TABLE_NAME + " WHERE id = ?";
		    try {
		      connection = ds.getConnection();
		      preparedStatement = connection.prepareStatement(deleteSQL);
		      preparedStatement.setInt(1, id);

		      result = preparedStatement.executeUpdate();

		    } finally{
		      try {
		        if (preparedStatement != null)
		          preparedStatement.close();
		      } finally {
		        if (connection != null)
		          connection.close();
		      }
		    }
		    
			return (result != 0);
		  }
	  
	  
	  public synchronized boolean doModify(ProductBean pro) throws SQLException {
		    Connection connection = null;
		    PreparedStatement preparedStatement = null;
		    
		    int result = 0;
		    
		    String updateSQL = "UPDATE prodotto " +
		                       "SET Nome = ?, " +
		                       "Categoria = ?, " +
		                       "Prezzo = ?, " +
		                       "Descrizione = ?, " +
		                       "Sconto = ?, " +
		                       "Immagine = ?, " +
		                       "IVA = ?, " +
		                       "Formato = ?, " +
		                       "Quantita = ? " +
		                       "WHERE ID = ?";
		    
		    try {
		        connection = ds.getConnection();
		        preparedStatement = connection.prepareStatement(updateSQL);

		        preparedStatement.setString(1, pro.getNome());
		        preparedStatement.setString(2, pro.getCategoria());
		        preparedStatement.setFloat(3, pro.getPrezzo());
		        preparedStatement.setString(4, pro.getDescrizione());
		        preparedStatement.setInt(5, pro.getSconto());
		        preparedStatement.setString(6, pro.getImmagine());
		        preparedStatement.setFloat(7, pro.getIVA());
		        preparedStatement.setString(8, pro.getFormato());
		        preparedStatement.setInt(9, pro.getQuantita());
		        preparedStatement.setInt(10, pro.getId());

		        result = preparedStatement.executeUpdate();
		    } finally {
		        try {
		            if (preparedStatement != null) {
		                preparedStatement.close();
		            }
		        } finally {
		            if (connection != null) {
		                connection.close();
		            }
		        }
		    }
		    
		    return result != 0;
		}

}
