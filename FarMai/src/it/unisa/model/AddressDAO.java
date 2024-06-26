package it.unisa.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;




import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;



public class AddressDAO {

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
    private static final String TABLE_NAME = "indirizzo";

    public synchronized int doSave(AddressBean address) throws SQLException {
        // SALVA NEL DATABASE UN'ISTANZA DELLA TABELLA INDIRIZZO

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        int id = -1;

        String insertSQL = "INSERT INTO " + TABLE_NAME + " (Citta, CAP, Via, Email_Cliente) VALUES (?, ?, ?, ?)";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS);
            
            preparedStatement.setString(1, address.getCitta());
            preparedStatement.setString(2, address.getCAP());
            preparedStatement.setString(3, address.getVia());
            preparedStatement.setString(4, address.getEmail());

            preparedStatement.executeUpdate();
            
            ResultSet key = preparedStatement.getGeneratedKeys();
            
            if (key.next()) {
                id = key.getInt(1);
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
        
        return id;
    }


    public synchronized AddressBean doRetrieveByKey(int id) throws SQLException {
        // RESTITUISCE L'INDIRIZZO DI UN CLIENTE CON UN DATO ID
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        
        String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE id = ? ";
        AddressBean bean = new AddressBean();
        
        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setInt(1, id);
          

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
            	
            	bean.setId(rs.getInt("id"));
                bean.setVia(rs.getString("Citta"));
                bean.setCitta(rs.getString("CAP"));
                bean.setCAP(rs.getString("via")); 
                bean.setEmail(rs.getString("Email_Cliente")); 
                
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


        return bean;
    }

    public synchronized ArrayList<AddressBean> doRetrieveByClient(String username) throws SQLException {
        // RESTITUISCE TUTTI GLI INDIRIZZI DI UN CLIENTE
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        
        String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE email_cliente = ?";

        ArrayList<AddressBean> addresses = new ArrayList<AddressBean>();

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1, username);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                AddressBean bean = new AddressBean();

                bean.setId(rs.getInt("id"));
                bean.setVia(rs.getString("Citta"));
                bean.setCitta(rs.getString("CAP"));
                bean.setCAP(rs.getString("via")); 
                bean.setEmail(rs.getString("Email_Cliente")); 
                

                addresses.add(bean);
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
        return addresses;
    }

   

    
public synchronized boolean doDelete(int id) throws SQLException {
        //ELIMINA UN INDIRIZZO 
    Connection connection = null;
    PreparedStatement preparedStatement = null;

    int result = 0;

    String deleteSQL = "DELETE  FROM " + TABLE_NAME + " where id = ?";

    try {
        connection = ds.getConnection();
        preparedStatement = connection.prepareStatement(deleteSQL);
        preparedStatement.setInt(1, id);
        

        result = preparedStatement.executeUpdate();

    } finally {
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
    
}