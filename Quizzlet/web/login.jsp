<%-- 
    Document   : login
    Created on : Dec 6, 2020, 3:39:26 PM
    Author     : kevin jeeva
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link rel="stylesheet" type="text/css" href="includes/style.css">
        <title>Login</title>
        <script>
            var count = 0;
            var msg = "";
            
            //SOME BASIC JAVASCRIPT VALIDATION
            
            function frmValidate()
            {
                var userName = trimFun("username");
                var password =  trimFun("password");
               
                
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
    </head>
    <body class="loginColor">
        <%
            //CHECK THE USER IS LOGGED IN OR NOT
             if(request.getSession().getAttribute("user_id") != null )
            {
                getServletContext().getRequestDispatcher("/Dashboard.jsp").forward(request, response);
                return; 
                //response.sendRedirect("Dashboard.jsp");
            }
            else
             {
                 //GET THE ALERT MESSAGES TO SHOW THE USER TO LOGGED IN OR NOT                 
                if(request.getParameter("message") != null)
                {
                    String n = request.getParameter("message").toString();
                    //request.getSession().setAttribute("message","");
                    out.println("<script>alert('"+n+"')</script>");
                }

                if(request.getSession().getAttribute("message") != null && request.getSession().getAttribute("message") != "")
                {
                    String n = request.getSession().getAttribute("message").toString();
                    request.getSession().setAttribute("message","");
                    out.println("<script>alert('"+n+"')</script>");
                }  
                
            }
        %>
          <div class="wrapper"><!--BASIC FORM -->
    <form class="form-signin" method ="POST" onsubmit="return frmValidate();" action="login_proc">       
      <h2 class="form-signin-heading">login</h2>
      <input type="text" class="form-control" name="username" id="username"placeholder="User name" required="" autofocus="" /><BR/>
      <input type="password" class="form-control" name="password" id="password" placeholder="Password" required=""/><br/>
      <button class="btn btn-outline-info btn-lg btn-block" type="submit">Login</button>  
      <a href="signup.jsp" type="button" class="btn btn-outline-success btn-lg btn-block">Sign up</a>
    </form>
  </div>
    </body>
</html>
