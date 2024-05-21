package it.unisa.model;



import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class ClientDAO {
    
    private static final String TABLE = "cliente";

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

    public ClientDAO(){
        //costruttore vuoto
    }

    public synchronized int doSave(ClientBean client) throws SQLException{
        //SALVA NEL DATABASE
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        int result = 0;

        String insertSQL = "INSERT INTO " + ClientDAO.TABLE
                           + " (Email, Username, CF, Password, Nome, Cognome, Telefono, CAP, Citta, Via, Provincia) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(insertSQL);
            preparedStatement.setString(1, client.getEmail());
            preparedStatement.setString(2, client.getUsername());
            preparedStatement.setString(3, client.getCf());
            preparedStatement.setString(4, client.getPassword());
            preparedStatement.setString(5, client.getNome());
            preparedStatement.setString(6, client.getCognome());
            preparedStatement.setString(7, client.getTelefono());
            preparedStatement.setString(8, client.getCap());
            preparedStatement.setString(9, client.getCitta());
            preparedStatement.setString(10, client.getVia());
            preparedStatement.setString(11, client.getProvincia());

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
        return result;
    }

    public synchronized ClientBean doRetrieveByEmailAndPassword(String email, String password) throws SQLException {
        // PRENDE UN UTENTE DAL SUO EMAIL E PASSWORD
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String selectSQL = "SELECT * FROM " + ClientDAO.TABLE + " WHERE Email=?";
        ClientBean client = null;

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1, email);

            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");

                // Cripta la password inserita dall'utente
                MessageDigest digest = MessageDigest.getInstance("SHA-1");
                digest.reset();
                digest.update(password.getBytes(StandardCharsets.UTF_8));
                String encryptedInputPassword = String.format("%040x", new BigInteger(1, digest.digest()));

                // Confronta la password criptata con quella memorizzata
                if (storedPassword.equals(encryptedInputPassword)) {
                    client = new ClientBean();
                    client.setEmail(rs.getString("Email"));
                    client.setUsername(rs.getString("Username"));
                    client.setCf(rs.getString("Cf"));
                    client.setPassword(storedPassword);
                    client.setNome(rs.getString("Nome"));
                    client.setCognome(rs.getString("Cognome"));
                    client.setTelefono(rs.getString("Telefono"));
                    client.setCap(rs.getString("Cap"));
                    client.setCitta(rs.getString("Citta"));
                    client.setVia(rs.getString("Via"));
                    client.setProvincia(rs.getString("Provincia"));
                }
            }
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                if (connection != null)
                    connection.close();
            }
        }
        return client;
    }

    
    public synchronized ClientBean doRetrieveByKey(String username) throws SQLException{
        //PRENDE UN UTENTE DAL SUO USERNAME
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String selectSQL = "SELECT * FROM " + ClientDAO.TABLE + " WHERE username=?";
        ClientBean client = null;
        

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1, username);

            ResultSet rs = preparedStatement.executeQuery();
            
           

            while (rs.next()) {
            	
            	client = new ClientBean();

            	client.setEmail(rs.getString("email"));
                client.setUsername(rs.getString("username"));
                client.setCf(rs.getString("cf"));
                client.setNome(rs.getString("nome"));
                client.setCognome(rs.getString("cognome"));
                client.setTelefono(rs.getString("telefono"));
                client.setCap(rs.getString("cap"));
                client.setCitta(rs.getString("citta"));
                client.setVia(rs.getString("via"));
                client.setProvincia(rs.getString("provincia"));

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
        
        
        return client;
    }
    
    public synchronized int doModify(ClientBean client) throws SQLException{
        //SALVA LE MODIFICHE NEL DATABASE
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        int result = 0;

        String updateSQL = "UPDATE "+ TABLE+ " SET  cf = ?, nome = ?, cognome = ?, via = ?, citta = ?, provincia = ?, cap = ?, telefono = ?, email = ? " + "WHERE username = ?";
        

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(updateSQL);
            preparedStatement.setString(1, client.getEmail());
            preparedStatement.setString(2, client.getUsername());
            preparedStatement.setString(3, client.getCf());
            preparedStatement.setString(5, client.getNome());
            preparedStatement.setString(6, client.getCognome());
            preparedStatement.setString(7, client.getTelefono());
            preparedStatement.setString(8, client.getCap());
            preparedStatement.setString(9, client.getCitta());
            preparedStatement.setString(10, client.getVia());
            preparedStatement.setString(11, client.getProvincia());

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
        return result;
    }
    
    public synchronized ClientBean doRetrieveByEmail(String email) throws SQLException{
        //PRENDE UN UTENTE DAL SUO EMAIL E PASSWORD
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String selectSQL = "SELECT * FROM " + ClientDAO.TABLE + " WHERE email=?";
        ClientBean client = null;


        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1, email);
            

            ResultSet rs = preparedStatement.executeQuery();
            
            while (rs.next()) {

                client = new ClientBean();

            	client.setEmail(rs.getString("email"));
                client.setUsername(rs.getString("username"));
                client.setCf(rs.getString("cf"));
                client.setNome(rs.getString("nome"));
                client.setCognome(rs.getString("cognome"));
                client.setTelefono(rs.getString("telefono"));
                client.setCap(rs.getString("cap"));
                client.setCitta(rs.getString("citta"));
                client.setVia(rs.getString("via"));
                client.setProvincia(rs.getString("provincia"));


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


        return client;
    }
    
    public synchronized ArrayList < ClientBean > doRetrieveAll() throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        ArrayList < ClientBean > clients = new ArrayList < ClientBean > ();
     

        String selectSQL = "SELECT * FROM " + TABLE + " WHERE username <> 'FarMai'" ;
        
        ClientBean client = null;

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
            	
                client = new ClientBean();

            	client.setEmail(rs.getString("email"));
                client.setUsername(rs.getString("username"));
                client.setCf(rs.getString("cf"));
                client.setPassword(rs.getString("password"));
                client.setNome(rs.getString("nome"));
                client.setCognome(rs.getString("cognome"));
                client.setTelefono(rs.getString("telefono"));
                client.setCap(rs.getString("cap"));
                client.setCitta(rs.getString("citta"));
                client.setVia(rs.getString("via"));
                client.setProvincia(rs.getString("provincia"));


                clients.add(client);
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
        return clients;
    }
}