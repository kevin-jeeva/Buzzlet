<%-- 
    Document   : Quizzlet
    Created on : Dec 6, 2020, 3:36:45 PM
    Author     : kevin jeeva
--%>

<%@page import="BusinessBeans.Quiz"%>
<%@page import="BusinessBeans.QuizBL"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="DataBeans.GetConnection"%>
<%@page import="DataBeans.UserDL"%>
<%@page import="BusinessBeans.User"%>
<%@page import="BusinessBeans.User"%>
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
        <title>Quizzlet</title>
<style> 
 
</style>
    </head>
    <body>
        <div class="container-fluid">
        <div class="jumbotron text-center" style="margin-bottom:0">
        <h1>Buzzlet</h1>
        <p>Quiz Anytime</p> 
        <div class="container">
          
             <a href="login.jsp" type="button" class="btn btn-outline-primary btn-lg">Log In</a>    
             <a href="signup.jsp" type="button" class="btn btn-outline-success btn-lg">Sign up</a>
           
         </div>
        </div> 
           
        <%
           //CHECK IF THE USER IS LOGGED IN 
         if(request.getSession().getAttribute("user_id") != null)
        {
            getServletContext().getRequestDispatcher("/Dashboard.jsp").forward(request, response);
            //response.sendRedirect("Dashboard.jsp");
        }
         else
         {
             //GET THE RESULT FROM THE GET 
            if(request.getParameter("message") != null && request.getParameter("message") != "")
            {
                String message = request.getParameter("message").toString();
                  out.println("<script>alert('"+message+"')</script>");
            }
         }
        
        %>
          <%!
            //INJECTING THE CLASSES 
            @EJB User u;            
            @EJB UserDL UDL;            
            @EJB GetConnection GDC;
            @EJB QuizBL QBL;
          
          
            public void jspInit()
            {
            try {
            u = (User)new InitialContext().lookup("java:module/User");
            UDL = (UserDL)new InitialContext().lookup("java:module/UserDL");
            QBL = (QuizBL)new InitialContext().lookup("java:global/Quizzlet/QuizBL");
            //GDC = (GetConnection)new InitialContext().lookup("java:module/GetConnection");
          
            }
            catch (Exception ex) {
            System.out.println("ERROR CREATING OBJECT");
            }
            } //end jspInit
        %>
         <h1>List of all available quizes</h1><hr/>
        <%
            //GET THE LIST OF ALL QUIZES CREATED BY ALL USER
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
                    //CREATE A ROW FOR EACH QUIZ INSIDE A TABLE
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
           
if(session.getAttribute("user_id") != null) //CHECK THE USER ID TO MAKE SURE TO SHOW THE RETURN TO DASHBOARD BUTTON
{
%><hr/><BR>
        <form action="Dashboard.jsp">
            <input type="submit" value="Return to Dashboard">
        </form>
        <%
        }
        %>
         
        
              
         
              
            </div><!--one column-->
    </body>
</html>
