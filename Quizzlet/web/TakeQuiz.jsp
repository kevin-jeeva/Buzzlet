<%-- 
    Document   : TakeQuiz
    Created on : Dec 6, 2020, 11:40:27 PM
    Author     : kevin jeeva
--%>

<%@page import="java.math.RoundingMode"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="BusinessBeans.User"%>
<%@page import="BusinessBeans.Question"%>
<%@page import="BusinessBeans.QuestionBL"%>
<%@page import="DataBeans.QuestionDL"%>
<%@page import="javax.ejb.EJB"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="DataBeans.QuizDL"%>
<%@page import="BusinessBeans.QuizBL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <!--Sources-->
        <meta name="viewport" content="width=device-width, initial-scale=1">
       
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        
        <title>Take Quiz</title>
    </head>
    <body>
        <div class="container-fluid">
        
        <%!
         //INJECTING ALL THE CLASSES 
          @EJB User u;
          @EJB QuestionDL QDL;  
          @EJB QuestionBL QBL;
          @EJB Question QU; 
           // @EJB Book B;
          
            public void jspInit()
            {
            try {
            u = (User)new InitialContext().lookup("java:module/User");
            QDL = (QuestionDL)new InitialContext().lookup("java:global/Quizzlet/QuestionDL");
            QBL = (QuestionBL)new InitialContext().lookup("java:global/Quizzlet/QuestionBL");
            QU = (Question)new InitialContext().lookup("java:global/Quizzlet/Question");
            //B = (Book)new InitialContext().lookup("java:module/Book");
            }
            catch (Exception ex) {
            System.out.println("ERROR CREATING OBJECT");
            }
            } //end jspInit    
        
        %>
        
       <%
        int quiz_id = 0;
        
        //GET THE MESSAGE WHETHER IT IS CORRECT OR WRONG AND TELL IT TO THE USER
        if(request.getParameter("result") != null)
        {
            String result = request.getParameter("result").toString();
            if(!(result.equals("")))
            {
                 out.println("<script>alert('"+result+"')</script>");
            }
        }
        
        //CLEAN ALL THE LIST OF IDS AND ANSWER INORDER TO GET OUT OF EXCEPTION
        if(request.getParameter("quiz_id") != null)
        {   
            QU.setCorrectAnswer(0);
            QU.setWrongAnswer(0); 
            QBL.ClearArrayList();
            quiz_id = Integer.parseInt(request.getParameter("quiz_id").toString()); 
            session.setAttribute("quiz_id", quiz_id); 
        }
        else
        {
            quiz_id = Integer.parseInt(session.getAttribute("quiz_id").toString());
        }
        
      
       %>
       <div class="card bg-light text-black">
           <div class="card-body"><h3><%=QBL.GetQuizTitleById(quiz_id)%></h3>
        </div>
       </div>
        <BR>
       <%
       
        int count = QBL.GetNumQuestion(quiz_id); //GET THE NUM OF QUESTIONS
        int submitGrey = count -2; //SOME GREY OUT EFFECTS NOT WORKS JUST TO TRY IT
        int questionCount = 0;
        String question = "";
        if(count != 0)
        {
            
             //GET THE COUNTER MOST IMPORTANT
             questionCount = Integer.parseInt(session.getAttribute("questionCount").toString());   
            //if the question count is zero we need to get the first question
            if(questionCount == 0) 
            {
                //INITIALIZE THE COUNTER IN THE PREVIOUS PAGE, SO BEGING OF THE TEST IT WILL GO TO THE PROC PAGE TO
                //GET THE FIRST QUESTION
                 response.sendRedirect("TakeQuiz_proc?quiz_id="+quiz_id+"");
            }
            else
            {               
                //SOME UNECESSARY INITIALIZATION, DONT KNOW WHY BUT WITHOUT THESE LINES THE CODE DOES NOT WORK :)
                question = request.getSession().getAttribute("Question").toString();               
                session.setAttribute("questionCount", questionCount);
               
            }
            
             //SOME SCORES AND ANSWERS TO DISPLAY TO THE USER
             String questionAnswered = Integer.toString(questionCount -1) + "/" + Integer.toString(count);
             String  Score = Integer.toString(QU.getCorrectAnswer()) + "/" + Integer.toString(count);
             String correctAnswer = Integer.toString(QU.getCorrectAnswer());
             String wrongAnswer = Integer.toString(QU.getWrongAnswer());
        
        
        %>
         <div class="card bg-dark text-white">
         <div class="card-body">
     
        <h3>Question: </h3>
        <div class="card bg-light text-dark">
            <div class="card-body"><h4><%=question%></h4></div>
        </div>
        <BR>
       <form method ="POST" action="TakeQuiz_proc">            
           <div class="form-group">
               <label>Fill your Answer: </label>
               <input type="text" id="txtAnswer" name="txtAnswer" class="form-control" required="true"><BR>
              <input type="submit" id="AnsSubmit" class="btn btn-success btn-lg"  value="Next Question">       
           </div>
         
       </form>
       <button onclick="submitFrm()"  href="Result.jsp" class="btn btn-outline-danger btn-lg">Submit Quiz</button>
        </div>
       </div>
       <hr/>
         <div class="card bg-light text-black">
         <div class="card-body">
         <div class="card bg-secondary text-white">
         <div class="card-body">
        <h4>Total number of Question: <%=count%></h4>
        </div>
         </div>
         <div class="card bg-primary text-black">
         <div class="card-body">
        <h4>Question Answered:  <%=questionAnswered%></h4>
         </div>
         </div>
         <div class="card bg-info text-black">
         <div class="card-body">
        <h4>Your Score:  <%=Score%></h4>
         </div>
         </div>
          <div class="card bg-success text-black">
         <div class="card-body">
        <h4>Correct Answer: <%=correctAnswer%></h4>
        </div>
         </div>
        <div class="card bg-warning text-black">
         <div class="card-body">
        <h4>Wrong Answer: <%=wrongAnswer%></h4>
         </div>
         </div>
         </div>
         </div>
         <script>
             
             //BORING AND SUBMIT THE QUIZ, CHECK THEY REALLY WANT TO EXIT THE QUIZ
            var submitFrm = function()
            {
                if(confirm("Are you sure to submit quiz"))
                {
                    location.replace("Result.jsp");
                }
            }
         </script>
         <%
             if(count == submitGrey)
            {
                out.println("<script>"
                    + "document.getElementById(\"AnsSubmit\").disabled = true;"
                        + "</script");
            }
         }
        else
        {
            //THE USER IS LAZY AND FORGET TO ADD THE QUESTION TO THE QUIZ
            out.println("No questions available");
            out.println("<script>"
                    + "document.getElementById(\"txtAnswer\").disabled = true;"
                    +"document.getElementById(\"AnsSubmit\").disabled = true;"
                    +"document.getElementById(\"ResultSubmit\").disabled = true;"                    
                    + "</script>");
        }
       %>
       </div>
    </body>
</html>
