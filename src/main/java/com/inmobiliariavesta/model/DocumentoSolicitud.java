package com.inmobiliariavesta.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class DocumentoSolicitud implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idDocumento;
    private int idSolicitud;
    private String nombreArchivo;
    private String url;
    private String tipoDocumento;
    private Timestamp fechaCarga;

    public DocumentoSolicitud() {}

    public DocumentoSolicitud(int idDocumento, int idSolicitud, String nombreArchivo, String url, String tipoDocumento, Timestamp fechaCarga) {
        this.idDocumento = idDocumento;
        this.idSolicitud = idSolicitud;
        this.nombreArchivo = nombreArchivo;
        this.url = url;
        this.tipoDocumento = tipoDocumento;
        this.fechaCarga = fechaCarga;
    }

    public int getIdDocumento() { return idDocumento; }
    public void setIdDocumento(int idDocumento) { this.idDocumento = idDocumento; }

    public int getIdSolicitud() { return idSolicitud; }
    public void setIdSolicitud(int idSolicitud) { this.idSolicitud = idSolicitud; }

    public String getNombreArchivo() { return nombreArchivo; }
    public void setNombreArchivo(String nombreArchivo) { this.nombreArchivo = nombreArchivo; }

    public String getUrl() { return url; }
    public void setUrl(String url) { this.url = url; }

    public String getTipoDocumento() { return tipoDocumento; }
    public void setTipoDocumento(String tipoDocumento) { this.tipoDocumento = tipoDocumento; }

    public Timestamp getFechaCarga() { return fechaCarga; }
    public void setFechaCarga(Timestamp fechaCarga) { this.fechaCarga = fechaCarga; }
}
