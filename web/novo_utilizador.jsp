<%-- 
    Document   : novo_utilizador
    Created on : 3/nov/2021, 10:13:19
    Author     : Paulo Lima
--%>

<%@page import="core.Utilizador"%>
<%@page import="java.sql.SQLException"%>
<%@page import="db.DBWorker"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    DBWorker dbWorker = null;

    try {
        dbWorker = new DBWorker("127.0.0.1", "root", "", "mydb");
    } catch (ClassNotFoundException ex) {
        System.out.println("ERRO AO LIGAR A BD");
    } catch (IllegalAccessException ex) {
        System.out.println("ERRO AO LIGAR A BD");
    } catch (InstantiationException ex) {
        System.out.println("ERRO AO LIGAR A BD");
    } catch (SQLException ex) {
        System.out.println("ERRO AO LIGAR A BD");
    }
%>
<%    
        Utilizador utilizador = new Utilizador();
        utilizador.setUtilizador(request.getParameter("txtNovoUtilizador"));
        utilizador.setPassword(request.getParameter("txtNovaPassword"));
        
    String acao = request.getParameter("acao");

    if (acao != null) {
        if (acao.equals("registar")) {
            out.print("Foi feito um pedido para registar um utilizador ");    
try {

                String sql = "INSERT INTO utilizador (login, pword) values ('" +utilizador.getUtilizador()+ "','" +utilizador.getPassword()+"')"; 
                int res = dbWorker.executeUpdate(sql);
                if (res > 0) {
                    out.print("Utilizador guardado com sucesso");
                    response.sendRedirect("index.jsp");
                } else {
                    out.print("Erro ao guardar jogador");
                }
               
            } catch (SQLException ex) {
                out.print("Erro de base de dados: " + ex.getMessage());
            }
        }
    }
%>





<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="includes/css/style.css" >
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registar</title>
    </head>
    <body>
        <h1>Registar novo utilizador</h1>
        <form action = novo_utilizador.jsp?acao=registar method="POST">
            <p>Preencha os seguintes campos:</p>
            <p>Utilizador:
                <input type="text" name="txtNovoUtilizador" required>
            </p>
            <p>Password:
                <input type="password" name="txtNovaPassword" required>
            </p>
            <input type="submit" value="Registar Novo Utilizador" name="registar">
        </form>
        <br>
        <br>
        <br>
        <form action = "index.jsp">
            <input type="submit" value="Voltar à página inicial"/>
        </form>
    </body>


</html>
