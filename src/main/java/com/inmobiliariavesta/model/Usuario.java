package com.inmobiliariavesta.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Usuario implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idUsuario;
    private String correo;
    private String passwordHash;
    private String estado;
    private Timestamp fechaCreacion;
    private Timestamp ultimoAcceso;

    // Relaciones
    private Perfil perfil;
    private List<Rol> roles = new ArrayList<>();

    public Usuario() {}

    public Usuario(int idUsuario, String correo, String passwordHash, String estado, Timestamp fechaCreacion, Timestamp ultimoAcceso) {
        this.idUsuario = idUsuario;
        this.correo = correo;
        this.passwordHash = passwordHash;
        this.estado = estado;
        this.fechaCreacion = fechaCreacion;
        this.ultimoAcceso = ultimoAcceso;
    }

    public int getIdUsuario() { return idUsuario; }
    public void setIdUsuario(int idUsuario) { this.idUsuario = idUsuario; }

    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }

    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public Timestamp getFechaCreacion() { return fechaCreacion; }
    public void setFechaCreacion(Timestamp fechaCreacion) { this.fechaCreacion = fechaCreacion; }

    public Timestamp getUltimoAcceso() { return ultimoAcceso; }
    public void setUltimoAcceso(Timestamp ultimoAcceso) { this.ultimoAcceso = ultimoAcceso; }

    public Perfil getPerfil() { return perfil; }
    public void setPerfil(Perfil perfil) { this.perfil = perfil; }

    public List<Rol> getRoles() { return roles; }
    public void setRoles(List<Rol> roles) { this.roles = roles; }

    public boolean hasRole(String roleName) {
        if (roles == null) return false;
        for (Rol r : roles) {
            if (r.getNombre().equalsIgnoreCase(roleName)) return true;
        }
        return false;
    }

    public String getPrimaryRole() {
        if (hasRole("admin")) return "admin";
        if (hasRole("inmobiliaria")) return "inmobiliaria";
        if (hasRole("cliente")) return "cliente";
        return "visitante";
    }
}
