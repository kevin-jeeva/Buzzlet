/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BusinessBeans;

import java.util.ArrayList;
import javax.ejb.Stateful;
import javax.ejb.Stateless;

/**
 *
 * @author kevin jeeva
 */
@Stateless
public class Question {

private int question_id;
private String question;
private String answer;
private int quiz_id;
private int correctAnswer;
private int wrongAnswer;
private ArrayList<Integer> questions_id;
private ArrayList<Question> questions;

    public int getCorrectAnswer() {
        return correctAnswer;
    }

    public void setCorrectAnswer(int correctAnswer) {
        this.correctAnswer = correctAnswer;
    }

    public int getWrongAnswer() {
        return wrongAnswer;
    }

    public void setWrongAnswer(int wrongAnswer) {
        this.wrongAnswer = wrongAnswer;
    }

public ArrayList<Question> getQuestions() {
    return questions;
}

public void setQuestions(ArrayList<Question> questions) {
    this.questions = questions;
}



    public ArrayList<Integer> getQuestions_id() {
        return questions_id;
    }

    public void setQuestions_id(ArrayList<Integer> questions_id) {
        this.questions_id = questions_id;
    }


    public int getQuestion_id() {
        return question_id;
    }

    public void setQuestion_id(int question_id) {
        this.question_id = question_id;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public int getQuiz_id() {
        return quiz_id;
    }

    public void setQuiz_id(int quiz_id) {
        this.quiz_id = quiz_id;
    }

    public void ClearQuestionArrays()
    {
        questions_id.removeAll(questions_id);
        //questions.removeAll(questions);
    }

    
}
