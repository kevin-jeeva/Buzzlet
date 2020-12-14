/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataBeans;

import BusinessBeans.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.ejb.Stateless;

/**
 *
 * @author kevin jeeva
 */
@Stateless
public class UserDL {

@EJB GetConnection conn;
@EJB User u;

  // private static Connection conn;
    
//    @PostConstruct
//    public void getConnection() {
//        String username = "root";
//        String password = "";
//        String dbUrl = "jdbc:mysql://localhost:3308/buzzletdb";
//        try{
//
//            Class.forName("com.mysql.jdbc.Driver"); //VERY IMPORTANT LINE OF CODE
//            conn = DriverManager.getConnection(dbUrl,username,password);            
//
//        }
//        catch(ClassNotFoundException cs)
//        {
//
//        }
//        catch(SQLException se)
//        {
//
//            System.out.println("Error");
//        }
//    }
//    
//    @PreDestroy
//    public void ClosConnection() {
//     
//       try {
//           conn.close();
//       } catch (SQLException ex) {
//           Logger.getLogger(UserDL.class.getName()).log(Level.SEVERE, null, ex);
//       }
//     
//    }
//
//    public Connection getConn() {
//        return conn;
//    }
//
//    public  void setConn(Connection conn) {
//        this.conn = conn;
//    }
//    
    public boolean InsertUser(String userName, String password, String email)
    {
        String sql = "Insert into user(user_name,password,Email) Values(?,?,?)";
        try {
            Connection con = conn.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, userName);
            ps.setString(2, password);
            ps.setString(3,email);
            int rowCount = ps.executeUpdate();
            if(rowCount != 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(BusinessBeans.User.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    public User FetchUserByName(String userName)
  {
    try {
        String sql = "Select * from user where user_name = UPPER(?)";
        Connection con = conn.getConn();
        PreparedStatement ps = con.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE);
        ps.setString(1,userName);
        ResultSet set = ps.executeQuery();
        if(set != null)
        {
            if(set.next())
            {
                u.setUserId(set.getInt(1)); 
                u.setUserName(set.getString(2));
                u.setPassword(set.getString(3));                
                u.setEmail(set.getString(5));              
                return u;
            }
            else
            {
                return null;
            }
        }
    } catch (SQLException ex) {
        Logger.getLogger(UserDL.class.getName()).log(Level.SEVERE, null, ex);
    }
    return null;
  }
}
