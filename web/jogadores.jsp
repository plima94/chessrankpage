<%-- 
    Document   : jogadores
    Created on : 25/out/2021, 23:27:17
    Author     : Paulo Lima
--%>

<%@page import="core.Rank"%>
<%@page import="core.Jogador"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="core.TipoJogo"%>
<%@page import="java.util.ArrayList"%>
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

<%    ArrayList<TipoJogo> tiposJogo = new ArrayList();
    ResultSet rs = dbWorker.executeQuery("SELECT * FROM tipojogo ORDER by idtipojogo");
    while (rs.next()) {
        TipoJogo tjogo = new TipoJogo();
        tjogo.setId(rs.getInt("idtipojogo"));
        tjogo.setDescritivo(rs.getString("descritivo"));
        tiposJogo.add(tjogo);
    }

%>
<%    ArrayList<Rank> rank = new ArrayList();
    ResultSet rSet = dbWorker.executeQuery("SELECT * FROM ranks ORDER by idrank");
    while (rSet.next()) {
        Rank ranks = new Rank();
        ranks.setIdrank(rSet.getInt("idrank"));
        ranks.setNomeRank(rSet.getString("rank"));
        rank.add(ranks);
    }

%>



<%    String acao = request.getParameter("acao");

    if (acao != null) {
        if (acao.equals("guardar")) {
            out.print("Foi feito um pedido para adicionar um jogador ");

            TipoJogo tipojogo = null;
            Rank tiporank = null;

            try {
                for (TipoJogo tipoJogo1 : tiposJogo) {
                    System.out.println(request.getParameter("cmbTipoJogo"));

                    if (tipoJogo1.getId() == Integer.parseInt(request.getParameter("cmbTipoJogo"))) {

                        tipojogo = tipoJogo1;
                    }
                }

            } catch (NumberFormatException ex) {
                out.print("Erro ao converter o tipo de jogo: " + ex.getMessage());
            }
            try {
                for (Rank tiporank1 : rank) {
                    System.out.println(request.getParameter("cmbTipoRank"));

                    if (tiporank1.getIdrank() == Integer.parseInt(request.getParameter("cmbTipoRank"))) {

                        tiporank = tiporank1;
                        System.out.println(tiporank1.getIdrank() + "entrei no rank" + Integer.parseInt(request.getParameter("cmbTipoRank")));
                    }
                }

            } catch (NumberFormatException ex) {
                out.print("Erro ao converter o tipo de rank: " + ex.getMessage());
            }

            Jogador jogador = new Jogador();
            jogador.setNome(request.getParameter("txtNome"));
            jogador.setIdade(Integer.parseInt(request.getParameter("txtIdade")));
            jogador.setTipoJogo(tipojogo);
            jogador.setRank(tiporank);

            try {

                String sql = "INSERT INTO jogador values (null, '" + jogador.getNome() + "','" + jogador.getIdade() + "','" + jogador.getTipoJogo().getId() + "','" + jogador.getRank().getIdrank() + "')"
                        + " ON DUPLICATE KEY UPDATE nomeJogador = '" + jogador.getNome() + "', idadeJogador = " + jogador.getIdade()+ ", ranks_idrank =" + jogador.getRank().getIdrank() + ", tipojogo_idtipojogo=" + jogador.getTipoJogo().getId() + ";";

                int res = dbWorker.executeUpdate(sql);
                if (res > 0) {
                    out.print("Jogador guardado com sucesso");
                    response.sendRedirect("lista_jogadores.jsp");
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="includes/css/style.css" >
        <title>Jogadores</title>
    </head>
    <body>
        <br>
        <br>
        <%@include file="includes/barra.inc.jsp" %>
        <h1>Jogadores</h1>

        <p>
        <form action = jogadores.jsp?acao=guardar method="POST">
            <p>Adicionar Novo Jogador:</p>
            <p>Nome:
                <input type="text" name="txtNome" required>
            </p>
            <p>Idade:
                <input type="number" min="0" name="txtIdade" required>
            </p>
            <label for="tipos_jogo">Tipo de Jogo:</label>
            <select id="tipos_jogo" name="cmbTipoJogo" required>
                <%                    for (TipoJogo tipoJogo : tiposJogo) {
                %>          
                <option value="<%= tipoJogo.getId()%>">
                    <%= tipoJogo.getDescritivo()%>
                </option>
                <%
                    }
                %>
            </select>
            <br>
            <br>
            <label for="tipos_rank">Rank:</label>
            <select id="tipos_rank" name="cmbTipoRank" required>
                <%                    for (Rank temprank : rank) {
                %>          
                <option value="<%= temprank.getIdrank()%>">
                    <%= temprank.getNomeRank()%>
                </option>
                <%
                    }
                %>
            </select>
            <br>
            <br>
            <input type="submit" value="Adicionar Jogador" name="guardar">
        </form>
        <br>

        <div>
            <form action = "lista_jogadores.jsp">
                <input type="submit" value="Listar Jogadores"/>   
            </form>
        </div>
    </p>

    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <form action = "index.jsp">
        <input type="submit" value="Voltar à página inicial"/>
    </form>

</body>
</html>
