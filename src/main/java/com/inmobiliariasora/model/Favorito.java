package com.inmobiliariasora.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Favorito implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idFavorito;
    private int idUsuario;
    private int idPropiedad;
    private Timestamp fechaAgregado;

    // Objeto propiedad asociado
    private Propiedad propiedad;

    public Favorito() {}

    public Favorito(int idFavorito, int idUsuario, int idPropiedad, Timestamp fechaAgregado) {
        this.idFavorito = idFavorito;
        this.idUsuario = idUsuario;
        this.idPropiedad = idPropiedad;
        this.fechaAgregado = fechaAgregado;
    }

    public int getIdFavorito() { return idFavorito; }
    public void setIdFavorito(int idFavorito) { this.idFavorito = idFavorito; }

    public int getIdUsuario() { return idUsuario; }
    public void setIdUsuario(int idUsuario) { this.idUsuario = idUsuario; }

    public int getIdPropiedad() { return idPropiedad; }
    public void setIdPropiedad(int idPropiedad) { this.idPropiedad = idPropiedad; }

    public Timestamp getFechaAgregado() { return fechaAgregado; }
    public void setFechaAgregado(Timestamp fechaAgregado) { this.fechaAgregado = fechaAgregado; }

    public Propiedad getPropiedad() { return propiedad; }
    public void setPropiedad(Propiedad propiedad) { this.propiedad = propiedad; }
}
