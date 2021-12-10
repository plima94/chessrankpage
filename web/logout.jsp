<%-- 
    Document   : logout
    Created on : 2/nov/2021, 23:27:30
    Author     : Paulo Lima
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    session.invalidate();
    response.sendRedirect("index.jsp");
%>