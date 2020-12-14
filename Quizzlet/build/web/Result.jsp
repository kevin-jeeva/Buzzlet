<%-- 
    Document   : Result
    Created on : Dec 9, 2020, 3:52:12 PM
    Author     : kevin jeeva
--%>

<%@page import="BusinessBeans.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="BusinessBeans.QuestionBL"%>
<%@page import="BusinessBeans.Question"%>
<%@page import="DataBeans.QuestionDL"%>
<%@page import="javax.ejb.EJB"%>
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
         <link rel="stylesheet" type="text/css" href="includes/style.css">
        <title>Result</title>
    </head>
    <body>
        <div class="container-fluid">
        <%!
      // @EJB QuestionDL QDL;
        @EJB User u;
        @EJB Question Q;
        @EJB QuestionBL QBL;
        @EJB Question QU;
           // @EJB Book B;
          
            public void jspInit()
            {
            try {
             u = (User)new InitialContext().lookup("java:module/User");
            //QDL = (QuestionDL)new InitialContext().lookup("java:module/QuestionDL");
            Q = (Question)new InitialContext().lookup("java:module/Question");
            QBL = (QuestionBL)new InitialContext().lookup("java:module/QuestionBL");
            QU = (Question)new InitialContext().lookup("java:module/Question");
            //B = (Book)new InitialContext().lookup("java:module/Book");
            }
            catch (Exception ex) {
            System.out.println("ERROR CREATING OBJECT");
            }
            } //end jspInit    

            
        
        %>
        <%    
            if(request.getSession().getAttribute("questionCount") == null)
             {
                getServletContext().getRequestDispatcher("/Dashboard.jsp").forward(request, response);  
                //response.sendRedirect("Dashboard.jsp");
                return;
             }
            
            
            if(session.getAttribute("user_id") != null)
        {
        %>
        
        <div class="jumbotron text-center" style="margin-bottom:0">
        <h1>Buzzlet</h1>
        <p>Quiz Anytime</p> 
         <h2>You are logged in as <% out.println(u.getUserName());%></h2>       
        <div class="container">
             <a href="Dashboard.jsp" type="button" class="btn btn-outline-primary btn-lg">Dashboard</a>    
             <a href="logout_proc" type="button" class="btn btn-outline-danger btn-lg">Log out</a>    
         </div>
        </div> 
        <%
            }
            else
            {
%>
 <div class="jumbotron text-center" style="margin-bottom:0">
        <h1>Buzzlet</h1>
        <p>Quiz Anytime</p> 
        <div class="container">
        <a href="Quizzlet.jsp" type="button" class="btn btn-outline-primary btn-lg">Return to Home Page</a> 
        </div>
 </div>

  <% } %> 
        <%
          
         if(request.getParameter("result") != null)
        {
            String result = request.getParameter("result").toString();
            if(!(result.equals(""))) 
            {
                 out.println("<script>alert('"+result+"')</script>");
            }
        }
        int quiz_id = Integer.parseInt(session.getAttribute("quiz_id").toString()); 
        String title = QBL.GetQuizTitleById(quiz_id);
        int count = QBL.GetNumQuestion(quiz_id);
        int score = QU.getCorrectAnswer();
        int wrongAnswer = QU.getWrongAnswer();
      
        %>
        <BR>
        <div class="card bg-secondary text-white text-center">
           <div class="card-body"><h2><%=title%></h2>
        </div>
       </div>
        <div class="card bg-warning text-white text-center">
          <div class="card-body">
        <h1><span class="text-dark">Test Details</span></h1>
        <h3><span class="text-dark">Your Score: <%=score%></span></h3>
        <h3><span class="text-dark"> Correct Answer: <%=score%></span></h3><h3><span class="text-dark">  Wrong Answer: <%=wrongAnswer%></span></h3> </div>
       </div>
        <div class="card bg-light text-dark">
        <div class="card-body">
        <h1>Result</h1>
       
        <%
        
            ArrayList<Integer> correctQuestion = QBL.getCorrectQIds();
            ArrayList<Integer> wrongQuestion = QBL.getWrongQIds();
            ArrayList<Integer> AllQuestions = Q.getQuestions_id();    
            ArrayList<String> userAnswers = QBL.getUserAnswers();
            int lengthUserAnswers = userAnswers.size(); 
            int j = 0;
            if(AllQuestions != null)
            {
                //SHOW THEY WHICH QUESTION THEY ARE CORRECT AND WRONG
                for(int i: AllQuestions) 
                {
                    if(lengthUserAnswers <= j)
                    {
                        userAnswers.add("No Answer");
                    }

                    if(correctQuestion.indexOf(i) != -1)
                    {
                        Question q = QBL.GetQuestion(i);
                        out.println("<div class=\"card bg-success text-white\">");
                        out.println("<div class=\"card-body\">");
                        out.println("Correct");
                        out.println("<div class=\"card bg-dark text-white\">");
                        out.println("<div class=\"card-body\">");
                        out.println("<h5 class=\"text-success\">Question: " + q.getQuestion()+"</h5>");
                        out.println("<h5>Your Answer:  " + userAnswers.get(j)+"</h5>"); 
                        out.println("<h5 class=\"text-success\">Correct Answer: " + q.getAnswer() +"</h5>");
                        out.println("</div>");
                        out.println("</div>");
                        out.println("</div>");
                        out.println("</div>");
                        out.println("<BR>");
                    }
                    else
                    {
                        Question q = QBL.GetQuestion(i);
                        out.println("<div class=\"card bg-danger text-white\">");
                        out.println("<div class=\"card-body\">");
                        out.println("Wrong"); 
                        out.println("<div class=\"card bg-dark text-white\">");
                        out.println("<div class=\"card-body\">");
                        out.println("<h5 class=\"text-danger\">Question: " + q.getQuestion() +" </h5>");
                         out.println("<h5>Your Answer: " + userAnswers.get(j)+"</h5>"); 
                        out.println("<h5 class=\"text-success\">Correct Answer: " + q.getAnswer() +" </h5>");
                        out.println("</div>");
                        out.println("</div>"); 
                        out.println("</div>");
                        out.println("</div>");
                        out.println("<BR>");
                    }
                    j++;
                }
                 //Clear All the sessions
                session.removeAttribute("Answer"); 
                session.removeAttribute("Question"); 
                session.removeAttribute("questionCount"); 
                session.removeAttribute("quiz_id"); 

                //clear arrayList
                Q.ClearQuestionArrays();
                QBL.ClearArrayList();
            }
            
           
            
            out.println("<hr/>");
        if(session.getAttribute("user_id") != null)
{
%>
        <a href="Dashboard.jsp" type="button" class="btn btn-outline-dark btn-lg">Dashboard</a>  
        <%
         }
         else
        {   
        %>
       
        <a href="Quizzlet.jsp" type="button" class="btn btn-outline-dark btn-lg">Return to Home Page</a> 
        
        <%
         }
        %>
     
        </div>
        </div>
        </div>
    </body>
</html>
