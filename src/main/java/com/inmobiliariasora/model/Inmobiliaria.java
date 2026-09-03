package com.inmobiliariasora.model;

import java.io.Serializable;

public class Inmobiliaria implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idInmobiliaria;
    private String nombre;
    private String nit;
    private String telefono;
    private String correoContacto;
    private String direccion;
    private String logoUrl;
    private String estado;

    public Inmobiliaria() {}

    public Inmobiliaria(int idInmobiliaria, String nombre, String nit, String telefono, String correoContacto, String direccion, String logoUrl, String estado) {
        this.idInmobiliaria = idInmobiliaria;
        this.nombre = nombre;
        this.nit = nit;
        this.telefono = telefono;
        this.correoContacto = correoContacto;
        this.direccion = direccion;
        this.logoUrl = logoUrl;
        this.estado = estado;
    }

    public int getIdInmobiliaria() { return idInmobiliaria; }
    public void setIdInmobiliaria(int idInmobiliaria) { this.idInmobiliaria = idInmobiliaria; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getNit() { return nit; }
    public void setNit(String nit) { this.nit = nit; }

    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }

    public String getCorreoContacto() { return correoContacto; }
    public void setCorreoContacto(String correoContacto) { this.correoContacto = correoContacto; }

    public String getDireccion() { return direccion; }
    public void setDireccion(String direccion) { this.direccion = direccion; }

    public String getLogoUrl() { return logoUrl; }
    public void setLogoUrl(String logoUrl) { this.logoUrl = logoUrl; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
}
