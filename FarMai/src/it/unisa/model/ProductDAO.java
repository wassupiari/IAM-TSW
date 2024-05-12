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
	  
	  
	  public synchronized ProductBean doRetrieveByKey(int id) throws SQLException{
		    Connection connection = null;
		    PreparedStatement preparedStatement = null;

		    String selectSQL = "SELECT * FROM " + ProductDAO.TABLE_NAME + " WHERE ID = ?";
		    ProductBean drug = new ProductBean();
		    
		    try {
		      connection = ds.getConnection();
		      preparedStatement = connection.prepareStatement(selectSQL);
		      preparedStatement.setInt(1, id);

		      ResultSet rs = preparedStatement.executeQuery();

		      while (rs.next()) {
		    
		        drug.setId(rs.getString("ID"));
		        drug.setNome(rs.getString("Nome"));
		        drug.setCategoria(rs.getString("Categoria"));
		        drug.setImmagine(rs.getString("Immagine"));
		        drug.setQuantitaS(rs.getInt("Quantità"));
		        drug.setIVA(rs.getFloat("IVA"));
		        drug.setPrezzo(rs.getFloat("prezzo"));
		        drug.setDescrizione(rs.getString("Descrizione"));
		        drug.setFormato(rs.getString("Formato"));
		        drug.setSconto(rs.getInt("Sconto"));
		        
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
		    	  
			        drug.setId(rs.getString("ID"));
			        drug.setNome(rs.getString("Nome"));
			        drug.setCategoria(rs.getString("Categoria"));
			        drug.setImmagine(rs.getString("Immagine"));
			        drug.setQuantitaS(rs.getInt("Quantità"));
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
	  
	  public synchronized List<ProductBean> findSimilarProducts(String categoria, int id) throws SQLException {
		  Connection connection = null;
		    PreparedStatement preparedStatement = null;
		    List<ProductBean> similarProducts = new ArrayList<>();

		    String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE Categoria = ? AND ID != ? LIMIT 3";
		    
		    try {
		        connection = ds.getConnection();
		        preparedStatement = connection.prepareStatement(selectSQL);
		        preparedStatement.setString(1, categoria);
		        preparedStatement.setInt(2, id);

		        ResultSet rs = preparedStatement.executeQuery();

		        while (rs.next()) {
		            ProductBean product = new ProductBean();
		            product.setId(rs.getString("ID"));
		            product.setNome(rs.getString("Nome"));
		            product.setCategoria(rs.getString("Categoria"));
		            product.setImmagine(rs.getString("Immagine"));
		            product.setQuantitaS(rs.getInt("Quantità"));
		            product.setIVA(rs.getFloat("IVA"));
		            product.setPrezzo(rs.getFloat("prezzo"));
		            product.setDescrizione(rs.getString("Descrizione"));
		            product.setFormato(rs.getString("Formato"));
		            product.setSconto(rs.getInt("Sconto"));

		            similarProducts.add(product);
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
		    return similarProducts;
		}
	
}
