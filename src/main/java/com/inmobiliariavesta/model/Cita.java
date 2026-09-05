package com.inmobiliariavesta.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class Cita implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idCita;
    private int idPropiedad;
    private int idCliente;
    private Timestamp fechaHora;
    private String estado; // 'pendiente', 'confirmada', 'cancelada', 'realizada'
    private String notas;

    // Campos enriquecidos
    private String propiedadTitulo;
    private String propiedadDireccion;
    private String clienteNombres;
    private String clienteApellidos;
    private String clienteTelefono;
    private String clienteCorreo;
    private String inmobiliariaNombre;

    public Cita() {}

    public int getIdCita() { return idCita; }
    public void setIdCita(int idCita) { this.idCita = idCita; }

    public int getIdPropiedad() { return idPropiedad; }
    public void setIdPropiedad(int idPropiedad) { this.idPropiedad = idPropiedad; }

    public int getIdCliente() { return idCliente; }
    public void setIdCliente(int idCliente) { this.idCliente = idCliente; }

    public Timestamp getFechaHora() { return fechaHora; }
    public void setFechaHora(Timestamp fechaHora) { this.fechaHora = fechaHora; }

    public String getFechaHoraFormateada() {
        if (fechaHora == null) return "";
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy hh:mm a");
        return sdf.format(fechaHora);
    }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public String getNotas() { return notas; }
    public void setNotas(String notas) { this.notas = notas; }

    public String getPropiedadTitulo() { return propiedadTitulo; }
    public void setPropiedadTitulo(String propiedadTitulo) { this.propiedadTitulo = propiedadTitulo; }

    public String getPropiedadDireccion() { return propiedadDireccion; }
    public void setPropiedadDireccion(String propiedadDireccion) { this.propiedadDireccion = propiedadDireccion; }

    public String getClienteNombres() { return clienteNombres; }
    public void setClienteNombres(String clienteNombres) { this.clienteNombres = clienteNombres; }

    public String getClienteApellidos() { return clienteApellidos; }
    public void setClienteApellidos(String clienteApellidos) { this.clienteApellidos = clienteApellidos; }

    public String getClienteNombreCompleto() {
        return (clienteNombres != null ? clienteNombres : "") + " " + (clienteApellidos != null ? clienteApellidos : "");
    }

    public String getClienteTelefono() { return clienteTelefono; }
    public void setClienteTelefono(String clienteTelefono) { this.clienteTelefono = clienteTelefono; }

    public String getClienteCorreo() { return clienteCorreo; }
    public void setClienteCorreo(String clienteCorreo) { this.clienteCorreo = clienteCorreo; }

    public String getInmobiliariaNombre() { return inmobiliariaNombre; }
    public void setInmobiliariaNombre(String inmobiliariaNombre) { this.inmobiliariaNombre = inmobiliariaNombre; }
}
