<%-- 
    Document   : editar_jogador
    Created on : 12/nov/2021, 21:39:39
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
      
    Jogador jogador = null;
  
    if (acao.equals("apagar")) {

        try {
            
            int id = Integer.parseInt(request.getParameter("id"));
            dbWorker.executeUpdate("DELETE FROM jogador WHERE idjogador = " + id);
            response.sendRedirect("lista_jogadores.jsp");
        } catch (NumberFormatException ex) {
            out.print("ID invaliado " + ex.getMessage());
        }
    } else {
        if (acao.equals("edit")) {
            try {
                
                int id = Integer.parseInt(request.getParameter("id"));

                String sql = "SELECT * FROM jogador WHERE idjogador = " + id;
                ResultSet rs3 = dbWorker.executeQuery(sql);
                if (rs3.next()) {

                    TipoJogo tipojogo = null;
                    Rank ranks = null;

                    for (TipoJogo tipojogo1 : tiposJogo) {
                        if (tipojogo1.getId() == rs3.getInt("idjogador")) {
                            tipojogo = tipojogo1;
                        }
                    }

                    for (Rank rank1 : rank) {
                        if (rank1.getIdrank() == rs3.getInt("ranks_idrank")) {
                            ranks = rank1;
                        }
                    }
                    jogador = new Jogador();
                    jogador.setNome(request.getParameter("txtNome"));
                    jogador.setIdade(Integer.parseInt(request.getParameter("txtIdade")));
                    jogador.setTipoJogo(tipojogo);
                    jogador.setRank(ranks);

                    
                }
            } catch (NumberFormatException ex) {
                out.print("Erro: ID Invalido " + ex.getMessage());
            }
        }
    }

%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="includes/css/style.css" >
        <title>Editar Jogador</title>
    </head>
    <body>
        <h1>Editor de jogador</h1>
        <form action = jogadores.jsp?acao=guardar method="POST">
            <p>Editar Jogador:</p>
            <p>Nome:
                <input type="text" name="txtNome" value="<%= jogador != null ? jogador.getNome() : ""%>" placeholder="Novo nome ... " />
            </p>

            <p>Idade:
                <input type="number" min="0" name="txtIdade" value="<%= jogador != null ? jogador.getIdade() : ""%>" placeholder="Nova idade..." />
            </p>
            <label for="tipos_jogo">Tipo de Jogo:</label>
            <select id="tipos_jogo" name="cmbTipoJogo" required>
                <%                    for (TipoJogo tipoJogo : tiposJogo) {
                %>          
                <option value="<%= tipoJogo.getId()%>"<%= jogador != null && jogador.getId() == tipoJogo.getId() ? "SELECTED" : ""%>> <%= tipoJogo.getDescritivo()%>

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


</table>
</body>
</html>
