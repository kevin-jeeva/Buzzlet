/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BusinessBeans;

import DataBeans.UserDL;
import javax.ejb.EJB;
import javax.ejb.Stateless;

/**
 *
 * @author kevin jeeva
 */
@Stateless
public class UserBL {
@EJB UserDL UDL;
@EJB User U;

     public boolean UserExists(String userName)
    {
       User user = UDL.FetchUserByName(userName);
       if(user == null)
       {
           return true;
       }
       else
       {
           return false;
       }
      
    }
    public boolean InsertUser(String userName, String password, String email)
    {
        
            boolean result = UDL.InsertUser(userName, password, email);
            if(result)
            {
                return true;
            }
            else
            {
                return false;
            }
      
    }
    public String LoginCheck(String userName, String password)
    {
        User user = UDL.FetchUserByName(userName);
        if(user != null)
        {
            if(password.equals(user.getPassword()))
            {
                U.setUserId(user.getUserId()); 
                return null;
            }
            else
            {
                return "Please enter a valid Password";
            }
        }
        else
        {
            return "Please enter a valid username";
        }            
      
    }
    
    
}
