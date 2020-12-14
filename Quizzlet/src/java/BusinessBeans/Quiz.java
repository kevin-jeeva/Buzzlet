/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BusinessBeans;

import java.io.Serializable;
import javax.ejb.Stateless;
import javax.inject.Named;
import javax.enterprise.context.Dependent;
import javax.enterprise.context.RequestScoped;
import javax.faces.view.ViewScoped;

@Stateless
@Named(value = "quiz")
@Dependent
public class Quiz implements Serializable{
    
    private int quiz_id = 0;
    private String title = "";
    private String date_created = "";
    private int userid = 0;
    private boolean message = false;

    public boolean getMessage() {
        return message;
    }

    public void setMessage(boolean message) {
        this.message = message;
    }
    
    public Quiz()
    {
       quiz_id = 0;
      title = "";
      date_created = "";
      userid = 0;
    }
    public Quiz(int quiz_id, String title, int userid) {
        this.quiz_id = quiz_id;
        this.title = title;
        this.userid = userid;
    }

    public int getQuiz_id() {
        return quiz_id;
    }

    public void setQuiz_id(int quiz_id) {
        this.quiz_id = quiz_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDate_created() {
        return date_created;
    }

    public void setDate_created(String date_created) {
        this.date_created = date_created;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }  
    
    
}

