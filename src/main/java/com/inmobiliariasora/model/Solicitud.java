package com.inmobiliariasora.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class Solicitud implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idSolicitud;
    private int idPropiedad;
    private int idCliente;
    private String tipo;   // 'compra', 'arriendo'
    private String estado; // 'pendiente', 'en_revision', 'aprobada', 'rechazada'
    private Timestamp fechaSolicitud;
    private String comentarios;

    // Campos enriquecidos
    private String propiedadTitulo;
    private String propiedadDireccion;
    private String clienteNombres;
    private String clienteApellidos;
    private String clienteCorreo;
    private String clienteTelefono;
    private String inmobiliariaNombre;

    // Documentos asociados
    private List<DocumentoSolicitud> documentos = new ArrayList<>();

    public Solicitud() {}

    public int getIdSolicitud() { return idSolicitud; }
    public void setIdSolicitud(int idSolicitud) { this.idSolicitud = idSolicitud; }

    public int getIdPropiedad() { return idPropiedad; }
    public void setIdPropiedad(int idPropiedad) { this.idPropiedad = idPropiedad; }

    public int getIdCliente() { return idCliente; }
    public void setIdCliente(int idCliente) { this.idCliente = idCliente; }

    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public Timestamp getFechaSolicitud() { return fechaSolicitud; }
    public void setFechaSolicitud(Timestamp fechaSolicitud) { this.fechaSolicitud = fechaSolicitud; }

    public String getFechaSolicitudFormateada() {
        if (fechaSolicitud == null) return "";
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy hh:mm a");
        return sdf.format(fechaSolicitud);
    }

    public String getComentarios() { return comentarios; }
    public void setComentarios(String comentarios) { this.comentarios = comentarios; }

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

    public String getClienteCorreo() { return clienteCorreo; }
    public void setClienteCorreo(String clienteCorreo) { this.clienteCorreo = clienteCorreo; }

    public String getClienteTelefono() { return clienteTelefono; }
    public void setClienteTelefono(String clienteTelefono) { this.clienteTelefono = clienteTelefono; }

    public String getInmobiliariaNombre() { return inmobiliariaNombre; }
    public void setInmobiliariaNombre(String inmobiliariaNombre) { this.inmobiliariaNombre = inmobiliariaNombre; }

    public List<DocumentoSolicitud> getDocumentos() { return documentos; }
    public void setDocumentos(List<DocumentoSolicitud> documentos) { this.documentos = documentos; }
}
