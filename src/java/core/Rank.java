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
public class Rank {

   
    private Integer idrank;
    private String nomeRank;

    public Integer getIdrank() {
        return idrank;
    }

    public void setIdrank(Integer idrank) {
        this.idrank = idrank;
    }

    public String getNomeRank() {
        return nomeRank;
    }

    public void setNomeRank(String nomeRank) {
        this.nomeRank = nomeRank;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 53 * hash + Objects.hashCode(this.idrank);
        hash = 53 * hash + Objects.hashCode(this.nomeRank);
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
        final Rank other = (Rank) obj;
        if (!Objects.equals(this.nomeRank, other.nomeRank)) {
            return false;
        }
        if (!Objects.equals(this.idrank, other.idrank)) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Rank{" + "idrank=" + idrank + ", nomeRank=" + nomeRank + '}';
    }
  
    
   
    
}
