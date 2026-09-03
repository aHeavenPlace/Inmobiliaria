package com.inmobiliariasora.model;

import java.io.Serializable;

public class Ciudad implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idCiudad;
    private String nombre;
    private String departamento;
    private String codigoPostal;

    public Ciudad() {}

    public Ciudad(int idCiudad, String nombre, String departamento, String codigoPostal) {
        this.idCiudad = idCiudad;
        this.nombre = nombre;
        this.departamento = departamento;
        this.codigoPostal = codigoPostal;
    }

    public int getIdCiudad() { return idCiudad; }
    public void setIdCiudad(int idCiudad) { this.idCiudad = idCiudad; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDepartamento() { return departamento; }
    public void setDepartamento(String departamento) { this.departamento = departamento; }

    public String getCodigoPostal() { return codigoPostal; }
    public void setCodigoPostal(String codigoPostal) { this.codigoPostal = codigoPostal; }
}
