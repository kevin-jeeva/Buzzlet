<%-- 
    Document   : AddQuestion
    Created on : Dec 7, 2020, 10:49:56 PM
    Author     : kevin jeeva
--%>

<%@page import="BusinessBeans.QuizBL"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="DataBeans.GetConnection"%>
<%@page import="DataBeans.GetConnection"%>
<%@page import="DataBeans.UserDL"%>
<%@page import="BusinessBeans.User"%>
<%@page import="BusinessBeans.User"%>
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
        <title>Add question</title>
    </head>
    <body>
        <div class="container-fluid">
          <%!
              //INJECTION AS USUAL 
            @EJB User u;
            @EJB UserDL UDL;
            @EJB GetConnection GDC;
            @EJB QuizBL QBL;
          
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
         <%
             if(request.getSession().getAttribute("user_id") == null)
            {
                getServletContext().getRequestDispatcher("/Quizzlet.jsp").forward(request, response);
                return;
            }
             //GET THE QUIZ ID AND CALL THE INSERT QUESTION METHOD IN THE QUIZBL TO INSER THE QUESTION INTO THE APPROPRIATE QUIZ
          String quizid =  request.getParameter("quiz_id");
          //QuizBL QZBL = new QuizBL();
          String title = QBL.GetTitleById(Integer.parseInt(quizid));
          if(request.getParameter("message") != null)
          {
               String message = request.getParameter("message").toString();
               out.println("<script>alert('"+message+"')</script>");
          }
          
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
         <h1>Add your questions to <span class="text-success"><%=title%></span></h1><hr/>
        <div class="container">
         <div class="card bg-dark text-white">
         <div class="card-body">
        <form method="POST" action="AddQuestion_proc">
            <div class ="form-group">
            <label>Add your Question:</label>
            <input type="text" required="true" class="form-control" requiredMesage="Please fill the question" id="question" name="question"><BR>
            </div>
            <div class="form-group">
            <label>Enter you answer</label>
            <input type="text" required="true" class="form-control" requiredMesage="Please fill the answer" id="answer" name ="answer"><BR>
            <input type="hidden" id="quiz_id" name="quiz_id" value="<%=quizid%>">
            <input type="submit" class="btn btn-outline-info btn-lg" value="Submit Question">
            <a href="Dashboard.jsp" type="button" value="Exit" class="btn btn-outline-danger btn-lg"> Exit</a>
            </div>
           </form>   
         </div>
         </div>
        </div>
        </div>
    </body>
</html>
