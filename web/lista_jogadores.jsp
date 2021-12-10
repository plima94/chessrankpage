<%-- 
    Document   : lista_jogadores
    Created on : 25/out/2021, 23:23:21
    Author     : Paulo Lima
--%>

<%@page import="core.Rank"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="core.Jogador"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.SQLException"%>
<%@page import="db.DBWorker"%>
<%@page import="core.TipoJogo"%>

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
<%  ArrayList<TipoJogo> tiposJogo = new ArrayList();
    ResultSet rsT = dbWorker.executeQuery("SELECT * FROM tipojogo ORDER by idtipojogo");
    while (rsT.next()) {
        TipoJogo tjogo = new TipoJogo();
        tjogo.setId(rsT.getInt("idtipojogo"));
        tjogo.setDescritivo(rsT.getString("descritivo"));
        tiposJogo.add(tjogo);
    }

%>
<%    
    ArrayList<Rank> rank = new ArrayList();
    ResultSet rSet = dbWorker.executeQuery("SELECT * FROM ranks ORDER by idrank");
    while (rSet.next()) {
        Rank ranks = new Rank();
        ranks.setIdrank(rSet.getInt("idrank"));
        ranks.setNomeRank(rSet.getString("rank"));
        rank.add(ranks);
    }

%>
<%    
    ArrayList<Jogador> jogador = new ArrayList();
    ResultSet rs = dbWorker.executeQuery("SELECT jogador.idjogador, jogador.nomeJogador, jogador.idadeJogador, tipojogo.descritivo, ranks.rank, ranks.idrank FROM jogador INNER JOIN tipojogo ON jogador.tipojogo_idtipojogo = tipojogo.idtipojogo INNER JOIN ranks ON jogador.ranks_idrank = ranks.idrank ORDER BY idjogador;");

    while (rs.next()) {
        Jogador jogadortemp = new Jogador();
        jogadortemp.setId(rs.getInt("idjogador"));
        jogadortemp.setNome(rs.getString("nomeJogador"));
        jogadortemp.setIdade(rs.getInt("idadeJogador"));

        TipoJogo t = new TipoJogo();
        t.setId(rs.getInt("idjogador"));
        t.setDescritivo(rs.getString("descritivo"));
        jogadortemp.setTipoJogo(t);

        Rank r = new Rank();
        r.setIdrank(rs.getInt("idrank"));
        r.setNomeRank(rs.getString("rank"));
        jogadortemp.setRank(r);

        jogador.add(jogadortemp);

    }
%>



<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="includes/css/style.css" >
        <title>Lista Jogadores</title>
    </head>
    <body>
        <%@include file="includes/barra.inc.jsp" %>
        <br>
        <br>
        <h1>Lista Jogadores</h1>
        <table>
            <tr>    
                <td>    
                    ID
                </td>
                <td>    
                    NOME
                </td>
                <td>    
                    IDADE
                </td>
                <td>    
                    TIPO JOGO
                </td>
                <td>    
                    RANK
                </td>
                <td>
                    AÇÃO
                </td>
                
            </tr>

            <%                for (Jogador jogador1 : jogador) {
            %>
            <tr>
                <td>
                    <%= jogador1.getId()%>
                </td>
                <td>
                    <%= jogador1.getNome()%>
                </td>
                <td>
                    <%= jogador1.getIdade()%>
                </td>
                <td>
                    <%= jogador1.getTipoJogo().getDescritivo()%>
                </td>
                <td>
                    <%= jogador1.getRank().getNomeRank() %> 
                </td>
                <td style="text-align: center;">
                    <a href="editar_jogador.jsp?acao=apagar&id=<%= jogador1.getId() %>"> <img class="icon_small" src="images/delete.png" /> </a>
                    <a href="editar_jogador.jsp?acao=edit&id=<%= jogador1.getId() %>"> <img class="icon_small" src="images/edit.png" /> </a>
                </td>

            </tr>
            <%
                
                }
            %>

        </table>
        <br>
        <br>
        <br>
        <br>
        <form action = "index.jsp">
            <input type="submit" value="Voltar à página inicial"/>
        </form>
    </body>
</html>
