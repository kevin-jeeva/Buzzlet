<%-- 
    Document   : signup
    Created on : Dec 6, 2020, 3:39:47 PM
    Author     : kevin jeeva
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
     <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link rel="stylesheet" type="text/css" href="includes/style.css">
        <title>Signup</title>
        <script>
            var count = 0;
            var msg = "";
            
            //SOME LOW LEVEL JAVASCRIPT VALIDATION
            function frmValidate()
            {
                var userName = trimFun("username");
                var password =  trimFun("password");
                var email = trimFun("Email");
                
               if(count == 0)
               {
                   //alert("Success");
                   return true;
               }
               else
               {
                   alert(msg);
                   count = 0;
                   msg= "";
                   return false;
               }
                
            }
            var trimFun = function(val)
            {    
                var i = document.getElementById(val).value;
                var result = i.trim();
                  if(result == "")
                  {
                      msg += val + " required " +"\n";
                      count += 1;                

                  }
                  
                

            }
        </script>      
        <title>Signup</title>
    </head>
    <body class="loginColor">
       
    <div class="wrapper"><!--BASIC FORM -->
    <form class="form-signin" method = "POST" action = "signup_proc" onsubmit="return frmValidate();">       
      <h2 class="form-signin-heading">Create Account</h2>
      <input type="text" class="form-control" name="username" id = "username"placeholder="User name" required="" autofocus="" /><BR/>
      <input type="password" class="form-control" name="password" id = "password" placeholder="Password" required=""/><br/>     
      <input type="text" class="form-control" name="Email" id = "Email"placeholder="Email address" required="" autofocus="" /><BR/>
      <button class="btn btn-lg btn-outline-primary btn-block" type="submit">Create Account</button>    
    </form>
         <%
              if(request.getSession().getAttribute("user_id") != null )
            {
                getServletContext().getRequestDispatcher("/Dashboard.jsp").forward(request, response);
                return; 
               // response.sendRedirect("Dashboard.jsp");
            }
             //GET ANY RESULT TO SHOW THEM IN THE ALERT
            if((request.getSession().getAttribute("alert") != null) && (request.getSession().getAttribute("alert") != ""))
            {
                String message = request.getSession().getAttribute("alert").toString();
                request.getSession().setAttribute("alert", "");
                 out.println("<script>alert('"+message+"')</script>");
                 
            }

        %>
    </body>
</div>
</html>
