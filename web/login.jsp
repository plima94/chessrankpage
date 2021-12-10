<%-- 
    Document   : login
    Created on : 2/nov/2021, 22:58:50
    Author     : Paulo Lima
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="db.DBWorker"%>



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

    String username = request.getParameter("txtUsername");
    String password = request.getParameter("txtPassword");
    
    if(username != null && password != null && !username.isEmpty() && !password.isEmpty()){
        String sql = "SELECT * FROM utilizador WHERE login = '"+username+"' AND pword = '"+password+"' LIMIT 1;";
        ResultSet rs = dbWorker.executeQuery(sql);
        if(rs.next()){
            String nome_utilizador = rs.getString("login");
            session.setAttribute("utilizador", nome_utilizador);
            out.print("Utilizador autenticado com sucesso");
            response.sendRedirect("index.jsp");
        }else{
            out.print("Dados de login inválidos");
        }
    }else{
        out.print("Dados de login inválidos");
    }

%>