/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataBeans;

import BusinessBeans.Quiz;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.enterprise.context.Dependent;
import javax.inject.Named;
import javax.inject.Inject;

@Named(value = "quizDL")
@Stateless
@Dependent
public class QuizDL implements Serializable{
    
@EJB GetConnection connt;
@EJB Quiz Q;
@EJB QuizDL QDL;

public QuizDL() {

}


public boolean InsertQuiz(String title, int user_id)
{
    Connection con = connt.getConn();
    String sql = "Insert into quiz(title, user_id) Values(?,?)";
    try {
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, title);
        ps.setInt(2, user_id);
        ps.executeUpdate();
        return true;
    } catch (SQLException ex) {
        Logger.getLogger(QuizDL.class.getName()).log(Level.SEVERE, null, ex);
    }
    return false;
}
   
public ArrayList<Quiz> GetQuizByUserId(int user_id)
{
   
   ArrayList<Quiz> quizes = new ArrayList<Quiz>();
   String sql = "Select * from Quiz where user_id = ? order by date_created desc";
   //conn.getConnection();
   Connection con = connt.conn;
    try {
        PreparedStatement ps = con.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
        ps.setInt(1, user_id);
        ResultSet set = ps.executeQuery();
        if(set != null)
        {
            if(set.next())
            {
                set.first();
                do
                {
                    Quiz q = new Quiz(set.getInt(1), set.getString(2), set.getInt(4));
                    String[] mydtArray = set.getString(3).split(" ");                    
                    q.setDate_created(mydtArray[0]);
                    quizes.add(q);
                }while(set.next());
                return quizes;
            }
            else
            {
                return null;
            }
        }
        else
        {
            return null;
        }
    } catch (SQLException ex) {
        Logger.getLogger(QuizDL.class.getName()).log(Level.SEVERE, null, ex);
    }
   return null;
}
public boolean AddQuestion(int quiz_id, String question, String answer)
{
    Connection con = connt.conn;
    String sql = "Insert into question(quiz_id, question, answer) Values (?,?,?)";
    try {
        PreparedStatement ps = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
        ps.setInt(1, quiz_id);
        ps.setString(2, question);
        ps.setString(3, answer);
        ps.executeUpdate();
        return true;
    } catch (SQLException ex) {
        Logger.getLogger(QuizDL.class.getName()).log(Level.SEVERE, null, ex);
    }
    return false;
}

public ArrayList<Quiz> GetAllQuizes()
{
    ArrayList<Quiz> quizes = new ArrayList<>();
    Connection con = connt.conn;
    if(con == null)
    {
       GetConnection connection = new GetConnection();
       connection.getConnection();
       con = connection.getConn();
    }
    String sql = "Select * from quiz order by date_created desc";
    try {
        PreparedStatement ps = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
        ResultSet set = ps.executeQuery();
        if(set != null)
        {
            if(set.next())
            {
                set.first();
                do
                {
                    Quiz q = new Quiz();
                    q.setQuiz_id(set.getInt(1));
                    String[] mydtArray = set.getString(3).split(" ");                    
                    q.setDate_created(mydtArray[0]);
                    q.setTitle(set.getString(2));
                    quizes.add(q);
                }while(set.next());
                return quizes;
            }
        }
    } catch (SQLException ex) {
        Logger.getLogger(QuizDL.class.getName()).log(Level.SEVERE, null, ex);
    }
    return null;
}
public String GetQuizTitleById(int quiz_id)
{
    Connection con = connt.conn;
    String sql = "Select title from quiz where quiz_id = ?";
    try {
        PreparedStatement ps = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
        ps.setInt(1, quiz_id);
        ResultSet set = ps.executeQuery();
        if(set != null)
        {
            if(set.next())
            {
                set.first();
                do
                {
                    String title = set.getString(1);
                    return title;
                }while(set.next());
            }
        }
    } catch (SQLException ex) {
        Logger.getLogger(QuizDL.class.getName()).log(Level.SEVERE, null, ex);
    }
    return null;
}

}
