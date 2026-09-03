package com.inmobiliariasora.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class Auditoria implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idAuditoria;
    private Integer idUsuario;
    private String accion;
    private String tablaAfectada;
    private Integer registroId;
    private Timestamp fecha;
    private String ipAddress;

    // Enriquecido
    private String usuarioCorreo;

    public Auditoria() {}

    public Auditoria(int idAuditoria, Integer idUsuario, String accion, String tablaAfectada, Integer registroId, Timestamp fecha, String ipAddress) {
        this.idAuditoria = idAuditoria;
        this.idUsuario = idUsuario;
        this.accion = accion;
        this.tablaAfectada = tablaAfectada;
        this.registroId = registroId;
        this.fecha = fecha;
        this.ipAddress = ipAddress;
    }

    public int getIdAuditoria() { return idAuditoria; }
    public void setIdAuditoria(int idAuditoria) { this.idAuditoria = idAuditoria; }

    public Integer getIdUsuario() { return idUsuario; }
    public void setIdUsuario(Integer idUsuario) { this.idUsuario = idUsuario; }

    public String getAccion() { return accion; }
    public void setAccion(String accion) { this.accion = accion; }

    public String getTablaAfectada() { return tablaAfectada; }
    public void setTablaAfectada(String tablaAfectada) { this.tablaAfectada = tablaAfectada; }

    public Integer getRegistroId() { return registroId; }
    public void setRegistroId(Integer registroId) { this.registroId = registroId; }

    public Timestamp getFecha() { return fecha; }
    public void setFecha(Timestamp fecha) { this.fecha = fecha; }

    public String getFechaFormateada() {
        if (fecha == null) return "";
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss a");
        return sdf.format(fecha);
    }

    public String getIpAddress() { return ipAddress; }
    public void setIpAddress(String ipAddress) { this.ipAddress = ipAddress; }

    public String getUsuarioCorreo() { return usuarioCorreo; }
    public void setUsuarioCorreo(String usuarioCorreo) { this.usuarioCorreo = usuarioCorreo; }
}
