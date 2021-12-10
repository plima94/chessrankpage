/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package core;

import java.util.Objects;

/**
 *
 * @author Paulo Lima
 */
public class Jogador {
    
    private Integer id;
    private String nome;
    private Integer idade;
    private TipoJogo tipoJogo;
    private Rank rank;

    public Rank getRank() {
        return rank;
    }

    public void setRank(Rank rank) {
        this.rank = rank;
    }

//    public Jogador(Integer id, String nome, Integer idade, TipoJogo tipoJogo, Rank rank) {
//        this.id = id;
//        this.nome = nome;
//        this.idade = idade;
//        this.tipoJogo = tipoJogo;
//        this.rank = rank;
//    }

    public TipoJogo getTipoJogo() {
        return tipoJogo;
    }

    public void setTipoJogo(TipoJogo tipoJogo) {
        this.tipoJogo = tipoJogo;
    }


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public Integer getIdade() {
        return idade;
    }

    public void setIdade(Integer idade) {
        this.idade = idade;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 41 * hash + Objects.hashCode(this.id);
        hash = 41 * hash + Objects.hashCode(this.nome);
        hash = 41 * hash + Objects.hashCode(this.idade);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Jogador other = (Jogador) obj;
        if (!Objects.equals(this.nome, other.nome)) {
            return false;
        }
        if (!Objects.equals(this.id, other.id)) {
            return false;
        }
        if (!Objects.equals(this.idade, other.idade)) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Jogador{" + "id=" + id + ", nome=" + nome + ", idade=" + idade + '}';
    }

  
    
}
