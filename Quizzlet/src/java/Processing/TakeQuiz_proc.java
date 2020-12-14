/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Processing;

import BusinessBeans.Question;
import BusinessBeans.QuestionBL;
import BusinessBeans.QuizBL;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.ejb.EJB;
import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "TakeQuiz_proc", urlPatterns = {"/TakeQuiz_proc"})
public class TakeQuiz_proc extends HttpServlet {
  @EJB Question Q;
  @EJB QuestionBL QUBL;
  @EJB QuizBL QBL;
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            //CHECK THE QUESTION COUNT IF IT IS NULL
            if(request.getSession().getAttribute("questionCount") == null)
             {
               getServletContext().getRequestDispatcher("/Dashboard.jsp").forward(request, response);
               return;
             
             }
            
            
            int quiz_id = 0;
            boolean correctORwrong = false;
            String result = "";
            if(request.getParameter("quiz_id") != null)
            {
                //IF IT IS FROM THE PARAMETER GET IT FROM HERE
                quiz_id = Integer.parseInt(request.getParameter("quiz_id").toString());
               
             
            }
            else
            {
                //GET THE QUIZ_ID FROM THE SESSION
              quiz_id = Integer.parseInt(request.getSession().getAttribute("quiz_id").toString());
                
                //check whether the question is correct or not
                
                String answer = request.getSession().getAttribute("Answer").toString();
                String answer2 = request.getParameter("txtAnswer");
                if(CompareStrings(answer.toUpperCase(),answer2.toUpperCase()))
                {
                    result = "Correct Answer";
                    int correct = Q.getCorrectAnswer();
                    correct += 1;
                    Q.setCorrectAnswer(correct); 
                    QUBL.SetUserAnswers(answer2); 
                    correctORwrong = true;
                    //QUBL.SetCorrectQIds(question_id);
                }
                else
                {
                    result = "Wrong Answer";
                    int wrong = Q.getWrongAnswer();
                    wrong += 1;
                    Q.setWrongAnswer(wrong); 
                    QUBL.SetUserAnswers(answer2); 
                    correctORwrong = false;
                   // QUBL.SetWrongQIds(question_id); 
                }
            }
            
            int Qcount = Integer.parseInt(request.getSession().getAttribute("questionCount").toString());
            if(Qcount == 0)
            {
                GetFirstQuestion(quiz_id);
               
            }
            int count = QUBL.GetNumQuestion(quiz_id) ;
            
           
                ArrayList<Integer> firstquestion = Q.getQuestions_id();        
            
                int question_id = 0;
                if(Qcount != count)
                 {
                    question_id = firstquestion.get(Qcount);
                 }
              
                if(Qcount != 0)
                {
                    //SETTING THE CORRECT AND WRONG IDS INTO A ARRAYLIST IN THE QUIZBL
                    int preQuestion_id = firstquestion.get(Qcount-1);
                    if(correctORwrong)
                    {
                        QUBL.SetCorrectQIds(preQuestion_id);
                    }
                    else
                    {
                         QUBL.SetWrongQIds(preQuestion_id); 
                    }
                }
                
                if(Qcount == count)
                {
                    //IF THE COUNT IS EQUAL TO THE QUESTION LENGTH THEN REDIRECT TO THE RESULT PAGE
                    getServletContext().getRequestDispatcher("/Result.jsp?result=" +result+"").forward(request, response);
                }
                else
                {
                    //IF NOT THE LENGTH IS EQUAL THEN STAY HERE AND SET THE ANSWER AND QUESTION SESSION
                   Question question = GetQuestion(question_id);
                   request.getSession().setAttribute("Question", question.getQuestion());
                   request.getSession().setAttribute("Answer", question.getAnswer());
                   Qcount += 1;
                   request.getSession().setAttribute("questionCount", Qcount);
                   getServletContext().getRequestDispatcher("/TakeQuiz.jsp?result=" +result+"").forward(request, response);
                }
        }
    }
    
   

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
    private Question GetQuestion(int question_id)
    {
        Question question = QUBL.GetQuestion(question_id);        
        return question;
    }
    private void GetFirstQuestion(int quid_id) {
        
       QUBL.FillQuestionIds(quid_id);
        
    }
    
    // you are 100% sure that I copied from stackoverflow :)
     public static int levenshteinDistance( String s1, String s2 ) 
     {
         return dist( s1.toCharArray(), s2.toCharArray() );
     }
     
    public static int dist( char[] s1, char[] s2 ) 
    {
        // memoize only previous line of distance matrix     
        int[] prev = new int[ s2.length + 1 ];

        for( int j = 0; j < s2.length + 1; j++ ) {
            prev[ j ] = j;
        }

        for( int i = 1; i < s1.length + 1; i++ ) {

            // calculate current line of distance matrix     
            int[] curr = new int[ s2.length + 1 ];
            curr[0] = i;

            for( int j = 1; j < s2.length + 1; j++ ) {
                int d1 = prev[ j ] + 1;
                int d2 = curr[ j - 1 ] + 1;
                int d3 = prev[ j - 1 ];
                if ( s1[ i - 1 ] != s2[ j - 1 ] ) {
                    d3 += 1;
                }
                curr[ j ] = Math.min( Math.min( d1, d2 ), d3 );
            }

            // define current line of distance matrix as previous     
            prev = curr;
        }
        return prev[ s2.length ];
    }
    
    public boolean CompareStrings(String Organswer, String answer)
    {
        int leven = levenshteinDistance(Organswer, answer);
        int grace =  (int) Math.floor(((Organswer.length() * 80)*0.01));//some cool math
        int graceScore = Organswer.length() - grace;
        if(leven <= graceScore)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

}
