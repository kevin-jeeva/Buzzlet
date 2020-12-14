/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataBeans;

import BusinessBeans.Question;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.ejb.Stateful;
import javax.ejb.Stateless;

/**
 *
 * @author kevin jeeva
 */
@Stateless
public class QuestionDL {
@EJB GetConnection connt;

public int GetNumquestion(int quiz_id)
{
    int count = 0;
    Connection con = connt.conn;
    String sql = "select Count(question_id) from question where quiz_id = ?";
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
                    count = set.getInt(1);
                    return count;
                }while(set.next());
            }
        }
    } catch (SQLException ex) {
        Logger.getLogger(QuizDL.class.getName()).log(Level.SEVERE, null, ex);
    }
    return count;
}

public String GetQuizTitle(int quiz_id)
{
    String title="";
    Connection con = connt.conn;
    String sql = "select title from quiz where quiz_id = ?";
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
                    title = set.getString(1);
                    return title;
                }while(set.next());
            }
        }
    } catch (SQLException ex) {
        Logger.getLogger(QuizDL.class.getName()).log(Level.SEVERE, null, ex);
    }
    return null;
}
public ArrayList<Integer> GetAllQuestionIds(int quiz_id)
{
    Connection con = connt.conn;
    ArrayList<Integer> questionIds = new ArrayList<Integer> ();
    String sql = "Select question_id from question where quiz_id = ? ORDER BY question_id ";
    try {
        PreparedStatement ps = con.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
        ps.setInt(1, quiz_id);
        ResultSet set = ps.executeQuery();
        if(set != null)
        {
            if(set.next())
            {
                set.first();
                do
                {
                    int Qid = set.getInt(1);
                    questionIds.add(Qid);
                }while(set.next());
                
                return questionIds;
            }
        }
    } catch (SQLException ex) {
        Logger.getLogger(QuestionDL.class.getName()).log(Level.SEVERE, null, ex);
    }
    return null;
}
public Question GetQuestion(int question_id)
{
    Question question  = new Question();
    Connection con = connt.conn;
    String sql = "Select question, answer from question where question_id = ?";
    try {
        PreparedStatement ps = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
        ps.setInt(1, question_id);
        ResultSet set = ps.executeQuery();
        if(set != null)
        {
            if(set.next())
            {
                set.first();
                do
                {
                    question.setQuestion(set.getString(1));
                    question.setAnswer(set.getString(2));
                    
                }while(set.next());
                return question;
                
            }
        }
    } catch (SQLException ex) {
        Logger.getLogger(QuestionDL.class.getName()).log(Level.SEVERE, null, ex);
    }
    return null;
}
}
