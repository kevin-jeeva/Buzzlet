<%-- 
    Document   : AllQuiz
    Created on : Dec 9, 2020, 10:58:35 PM
    Author     : kevin jeeva
--%>

<%@page import="BusinessBeans.QuizBL"%>
<%@page import="javax.inject.Inject"%>
<%@page import="BusinessBeans.Quiz"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DataBeans.QuizDL"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="DataBeans.GetConnection"%>
<%@page import="BusinessBeans.User"%>
<%@page import="BusinessBeans.User"%>
<%@page import="DataBeans.UserDL"%>
<%@page import="javax.ejb.EJB"%>
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
        <title>ALL QUIZ</title>
    </head>
    <body>
        <div class="container-fluid">
            
       
         <%!
             //INJECTION
            @EJB User u;            
            @EJB UserDL UDL;            
            @EJB QuizBL QBL;
            @EJB GetConnection GDC;
         
          
            public void jspInit()
            {
            try {
            u = (User)new InitialContext().lookup("java:module/User");
            UDL = (UserDL)new InitialContext().lookup("java:module/UserDL");
            GDC = (GetConnection)new InitialContext().lookup("java:module/GetConnection");
            QBL = (QuizBL)new InitialContext().lookup("java:module/QuizBL");
          
            }
            catch (Exception ex) {
            System.out.println("ERROR CREATING OBJECT");
            }
            } //end jspInit
        %>
         <div class="jumbotron text-center" style="margin-bottom:0">
        <h1>Buzzlet</h1>
        <p>Quiz Anytime</p> 
         <h2>You are logged in as <% out.println(u.getUserName());%></h2>       
        <div class="container">
             <%
             if(session.getAttribute("user_id") != null)
            {          
            out.println("<a = href =\"Dashboard.jsp\" type=\"button\"class=\"btn btn-outline-primary btn-lg\">Dashboard</a>");           
            }
             %>
             <a href="faces/Title.xhtml" type="button" class="btn btn-outline-success btn-lg">Create Quiz</a>    
              
             <a href="logout_proc" type="button" class="btn btn-outline-danger btn-lg">Log out</a> 
            
         </div>
        </div> 
       <h1>List of all available quizes</h1><hr/>
        <%
           // QuizBL QBL = new QuizBL();
            ArrayList<Quiz> quizes = QBL.GetAllQuizes();
            if(quizes != null)
            {
               %>
               <table class="table table-dark table-hover">
                   <thead>
                       <tr>
                           <th>Quiz Title</th>
                           <th> Date Created</th>
                           <th>Take Quiz</th>
                       </tr>
                   </thead>
                   <tbody>
               
               <%
                for(Quiz q : quizes)
                {  
                    out.println("<tr>");
                    out.println("<td>"+q.getTitle()+"</td>");
                    out.println("<td>" + q.getDate_created() +"</td>");
                    out.println("<td>");
                    out.println("<form method=\"POST\" action=\"TakeQuiz.jsp\">");
                    out.println("<button type=\"submit\" class=\"btn btn-outline-warning\">Take Quiz</button>");
                    out.println("<input type=\"hidden\" id=\"quiz_id\" name = \"quiz_id\" value ="+ q.getQuiz_id()+">");
                    out.println("</form>");
                    out.println("</td>");
                    out.println("</tr>");
                    
                }
                //set the question to zero so it will get the first question
                 session.setAttribute("questionCount", 0);
                 %>
                 </tbody>
                 </table> 
                 <%
            }
            else
            {
                out.println("<h3>No Quizes available at this momemt</h3>");
            }
           

%>
<BR>
       </div>
    </body>
</html>
