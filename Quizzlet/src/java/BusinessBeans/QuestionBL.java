/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BusinessBeans;

import DataBeans.QuestionDL;
import java.util.ArrayList;
import javax.ejb.EJB;
import javax.ejb.Stateless;

/**
 *
 * @author kevin jeeva
 */
@Stateless
public class QuestionBL {
@EJB Question Q;
@EJB QuestionDL QDL;



private ArrayList<Integer> wrongQIds = new ArrayList<Integer>();
private ArrayList<Integer> correctQIds = new ArrayList<Integer>();
private ArrayList<String> userAnswers = new ArrayList<String>();

    public ArrayList<String> getUserAnswers() {
        return userAnswers;
    }

    public void setUserAnswers(ArrayList<String> userAnswers) {
        this.userAnswers = userAnswers;
    }

    public void SetUserAnswers(String answer)
    {
        userAnswers.add(answer);
    }
    public ArrayList<Integer> getWrongQIds() {
        return wrongQIds;
    }

    public void setWrongQIds(ArrayList<Integer> wrongQIds) {
        this.wrongQIds = wrongQIds;
    }

    public ArrayList<Integer> getCorrectQIds() {
        return correctQIds;
    }

    public void setCorrectQIds(ArrayList<Integer> correctQIds) {
        this.correctQIds = correctQIds;
    }
public void ClearArrayList()
{
    wrongQIds.removeAll(wrongQIds);
    correctQIds.removeAll(correctQIds);
    userAnswers.removeAll(userAnswers);
}
public void SetCorrectQIds(int qId)
{
    correctQIds.add(qId);
}
public  void SetWrongQIds(int qId)
{
    wrongQIds.add(qId);
}    
public int GetNumQuestion(int quiz_id)
{
    int count = QDL.GetNumquestion(quiz_id);
    if(count != 0)
    {
        return count;
    }
    else
    {
        return 0;
    }
}
   public String GetQuizTitleById(int quiz_id)
   {
     String title = QDL.GetQuizTitle(quiz_id);
     if(title != null)
     {
         return title;
     }
     else
     {
         return "No Title Available";
     }
   }
   
   public void FillQuestionIds(int quiz_id)           
   {
       ArrayList<Integer> questionIds = QDL.GetAllQuestionIds(quiz_id);
     if(questionIds != null)
     {
           Q.setQuestions_id(questionIds);
     }
     else
     {
         Q.setQuestions_id(null); 
     }
       
   }
   public Question GetQuestion(int question_id)
   {
       Question question = QDL.GetQuestion(question_id);
       if(question != null)
       {
           return question;
       }
       else
       {
           return null;
       }
   }
    
}
