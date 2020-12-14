/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataBeans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.ejb.Singleton;
import javax.ejb.Stateless;

/**
 *
 * @author kevin jeeva
 */
@Singleton
public class GetConnection {

public static Connection conn;
    
    @PostConstruct
    public void getConnection() {
        String username = "root";
        String password = "";
        String dbUrl = "jdbc:mysql://localhost:3308/buzzletdb";
        try{

            Class.forName("com.mysql.jdbc.Driver"); //VERY IMPORTANT LINE OF CODE
            conn = (Connection) DriverManager.getConnection(dbUrl,username,password);            

        }
        catch(ClassNotFoundException cs)
        {

        }
        catch(SQLException se)
        {

            System.out.println("Error");
        }
    }
    
    @PreDestroy
    public void ClosConnection() {
     
    try {
        conn.close();
    } catch (SQLException ex) {
        Logger.getLogger(GetConnection.class.getName()).log(Level.SEVERE, null, ex);
    }
     
    }

    public java.sql.Connection getConn() {
        return (java.sql.Connection) conn;
    }

    public  void setConn(java.sql.Connection conn) {
        this.conn = (Connection) conn;
    }

    private void close() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
