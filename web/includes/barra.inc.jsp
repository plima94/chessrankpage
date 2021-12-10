

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="barra-login">

    <%
        if (session.getAttribute("utilizador") != null) {
            out.print((String) session.getAttribute("utilizador"));
            out.print("<a href=\"logout.jsp\" class=\"link_button\">Sair</a>");
        } else {

    %>
    <form name="login" action="login.jsp" method="POST">
        <input type="text" style="width: 150px;" name="txtUsername" value="" placeholder="Utilizador..." />
        <input type="password" style="width: 150px;"  name="txtPassword" value="" placeholder="Senha..." />
        <input class="link_button" type="submit" name="cmdEntrar" value="Entrar" />
        
        
    </form>
    <%        }
    %>
        <form class="registar" name="registar" action="novo_utilizador.jsp" method="POST">
            <input type="submit" value ="Registar"/>
        </form>
</div>
