<%-- 
    Document   : index
    Created on : 25/out/2021, 23:10:46
    Author     : Paulo Lima
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="includes/css/style.css" >
        <title>Chess Rank</title>
        
    </head>
    <body>
        <br>
        <br>
        <%@include file="includes/barra.inc.jsp" %>
        
        
        <h1>Chess Ranks</h1>
        <div>
<!--            <form action = "ranks.jsp">
                <input type="submit" value="Ranks"/>   
            </form>-->
        </div>
        <br>
        <br>

        <div>
            <form action = "jogadores.jsp">
                <input class="botao" type="submit" value="Jogadores"/>
            </form>
        </div>
        <br>
        <br>
        <footer class="teste_login_info">
            <p>Teste login</p>
            <p>username: admin </p>
            <p>password: admin123 </p>
        </footer>


    </body>
</html>
