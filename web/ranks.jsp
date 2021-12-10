<%-- 
    Document   : ranks
    Created on : 25/out/2021, 23:14:00
    Author     : Paulo Lima
--%>

<%@page import="core.Rank"%>
<%@page import="core.TipoJogo"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="core.Jogador"%>
<%@page import="java.sql.SQLException"%>
<%@page import="db.DBWorker"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%                DBWorker dbWorker = null;

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

<%    ArrayList<Jogador> jogador = new ArrayList();
    ResultSet rs = dbWorker.executeQuery("SELECT jogador.nomeJogador, tipojogo.descritivo, ranks.rank FROM jogador INNER JOIN tipojogo ON jogador.tipojogo_idtipojogo = tipojogo.idtipojogo INNER JOIN ranks ON jogador.ranks_idrank = ranks.idrank order by ranks_idrank;");
    while (rs.next()) {
        Jogador jogadortemp = new Jogador();
        jogadortemp.setId(rs.getInt("idjogador"));
        jogadortemp.setNome(rs.getString("nomeJogador"));
        jogadortemp.setIdade(rs.getInt("idadeJogador"));

        TipoJogo t = new TipoJogo();
        t.setId(rs.getInt("idjogador"));
        t.setDescritivo(rs.getString("descritivo"));

        jogadortemp.setTipoJogo(t);
        jogador.add(jogadortemp);

    }
%>
<%
    ArrayList<TipoJogo> tiposJogo = new ArrayList();
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


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="includes/css/style.css" >
        <title>Ranks</title>
    </head>
    <body>
        <%@include file="includes/barra.inc.jsp" %>
        <br>
        <br>
        <h1>Lista Ranks</h1>
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
