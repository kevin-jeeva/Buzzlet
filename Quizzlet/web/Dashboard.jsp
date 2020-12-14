<%-- 
    Document   : Dashboard
    Created on : Dec 6, 2020, 3:40:45 PM
    Author     : kevin jeeva
--%>

<%@page import="DataBeans.GetConnection"%>
<%@page import="DataBeans.UserDL"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DataBeans.QuizDL"%>
<%@page import="javax.inject.Inject"%>
<%@page import="BusinessBeans.Quiz"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.ejb.EJB"%>
<%@page import="BusinessBeans.User"%>
<%@page import="BusinessBeans.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <!--Sources-->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
         <link rel="stylesheet" type="text/css" href="includes/style.css">
    <head> 
       
        <title>Dashboard</title>
    </head>
    <body>
        <div class="container-fluid">
        <%!
            //INJECTION
            @EJB User u;
            @EJB UserDL UDL;
            @EJB GetConnection GDC;
           // @EJB Book B;
          
            public void jspInit()
            {
            try {
            u = (User)new InitialContext().lookup("java:module/User");
            UDL = (UserDL)new InitialContext().lookup("java:module/UserDL");
            GDC = (GetConnection)new InitialContext().lookup("java:module/UserDL");
            //B = (Book)new InitialContext().lookup("java:module/Book");
            }
            catch (Exception ex) {
            System.out.println("ERROR CREATING OBJECT");
            }
            } //end jspInit
        %>
        
        <%
       
            //MAKE SURE THE USER IS LOGGED IN
        if(request.getSession().getAttribute("user_id") != null && request.getSession().getAttribute("user_id") != "")
        {
            
            String n = request.getSession().getAttribute("user_id").toString();
          
            if(request.getParameter("message") != null)
           {
               String message = request.getParameter("message").toString();
               out.println("<script>alert('"+message+"')</script>");
           } 

        }
        else
        {
             getServletContext().getRequestDispatcher("/Quizzlet.jsp").forward(request, response);
             return; 
        }

        
        %>
        <div class="jumbotron text-center" style="margin-bottom:0">
        <h1>Buzzlet</h1>
        <p>Quiz Anytime</p> 
         <h2>You are logged in as <% out.println(u.getUserName());%></h2>       
        <div class="container">          
             <a href="faces/Title.xhtml" type="button" class="btn btn-outline-success btn-lg">Create Quiz</a>    
             <a href="AllQuiz.jsp" type="button" class="btn btn-outline-info btn-lg">Take All Quiz</a>    
             <a href="logout_proc" type="button" class="btn btn-outline-danger btn-lg">Log out</a>    
         </div>
        </div> 
       
        <h1>List of Quizes created</h1><hr/>
        <table class ="table table-dark table-hover">
            <thead>
                <tr>
                    <th> Quiz title </th>
                    <th> Date Created </th>
                    <th> Modify </th>
                    <th> Take Quiz </th>
                </tr>
            </thead>
        
        <%
            QuizDL QDL = new QuizDL();
            ArrayList<Quiz> quizes = QDL.GetQuizByUserId(u.getUserId());
            if(quizes != null)
            {
                for(Quiz q : quizes)
                {  
                    out.println("<tr>");
                    out.println("<td>" +q.getTitle()+"</td>");
                    out.println("<td>" +q.getDate_created()+ "</td>");
                    out.println("<td>");
                    out.println("<form method=\"GET\" action=\"AddQuestion.jsp\">");                    
                    out.println("<input type=\"hidden\" id=\"quiz_id\" name = \"quiz_id\" value ="+ q.getQuiz_id()+">");
                    out.println("<button type=\"submit\"class=\"btn btn-outline-info\">Add Question </button>");
                    out.println("</form>");
                    out.println("</td>");
                    out.println("<td>");
                    out.println("<form method=\"POST\" action=\"TakeQuiz.jsp\">");
                    out.println("<button type=\"submit\"class=\"btn btn-outline-warning\">Take This Quiz </button>");
                    out.println("<input type=\"hidden\" id=\"quiz_id\" name = \"quiz_id\" value ="+ q.getQuiz_id()+">");
                    out.println("</form>");
                    out.println("</td>");
                    out.println("</tr>");
                }
                //set the question to zero so it will get the first question
                 session.setAttribute("questionCount", 0);
            }
            else
            {
                out.println("<h3>No Quizes available at this momemt</h3>");
            }
           
        
        %>
        </table>
        </div>
    </body>
</html>
