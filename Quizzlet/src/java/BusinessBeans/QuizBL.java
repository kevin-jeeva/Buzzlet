/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BusinessBeans;

import DataBeans.QuizDL;
import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.enterprise.context.Dependent;
import javax.inject.Named;
import javax.enterprise.context.RequestScoped;

import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.faces.view.ViewScoped;
import javax.inject.Inject;


@Named(value = "quizBL")
@Stateless
@Dependent
public class QuizBL implements Serializable{
@EJB User u;
@EJB Quiz Q;
@EJB QuizDL QDL; 



    public QuizBL() {
        
    }


   public void InsertQuiz()
   {
      boolean result = QDL.InsertQuiz(Q.getTitle(), u.getUserId());
      if(result)
      { 
          Q.setTitle("");
          try {
            ExternalContext context = FacesContext.getCurrentInstance().getExternalContext();
            context.redirect(FacesContext.getCurrentInstance().getExternalContext()
                    .getRequestContextPath() + "/Dashboard.jsp?message=Quiz Created!");
        } catch (IOException ex) {
            Logger.getLogger(QuizBL.class.getName()).log(Level.SEVERE, null, ex);
        }
          Q.setMessage(true);
          //return true;
      }
      else
      {
         //return false;
      }
   }
   public ArrayList<Quiz> GetQuizesByUserId(int user_id)
   {
       ArrayList<Quiz> quizes = QDL.GetQuizByUserId(user_id);
       if(quizes != null)
       {
           return quizes;
       }
       else
       {
           return null;
       }
   }
   public boolean AddQuestion(int quiz_id, String question, String answer)
   {
       boolean result = QDL.AddQuestion(quiz_id, question, answer);
       if(result)
       {
           return true;
       }
       else
       {
           return false;
       }
   }


   
   public ArrayList<Quiz> GetFirstQuestion(int quiz_id)
   {
       return null;
   }
   
   public ArrayList<Quiz> GetAllQuizes()
   {
      
       ArrayList<Quiz> quizes = QDL.GetAllQuizes();
       if(quizes != null)
       {
           return quizes;
       }
       else
       {
           return null;
       }
   }
   public String GetTitleById(int quiz_id)
   {
       if(QDL == null)
       {
           QDL = new QuizDL();
       }
       String title = QDL.GetQuizTitleById(quiz_id);
       if(title != null)
       {
           return title;
       }
       else
       {
           return null;
       }
   }
    
}
