package com.inmobiliariasora.dao;

import com.inmobiliariasora.config.DBConnection;
import com.inmobiliariasora.model.Auditoria;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class AuditoriaDAO {

    public void registrar(Integer idUsuario, String accion, String tablaAfectada, Integer registroId, String ipAddress) {
        String sql = "INSERT INTO auditoria (id_usuario, accion, tabla_afectada, registro_id, ip_address) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            if (idUsuario != null && idUsuario > 0) {
                ps.setInt(1, idUsuario);
            } else {
                ps.setNull(1, Types.INTEGER);
            }
            ps.setString(2, accion);
            ps.setString(3, tablaAfectada);
            if (registroId != null && registroId > 0) {
                ps.setInt(4, registroId);
            } else {
                ps.setNull(4, Types.INTEGER);
            }
            ps.setString(5, ipAddress != null ? ipAddress : "127.0.0.1");

            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("[AuditoriaDAO] Error al registrar auditoría: " + e.getMessage());
        }
    }

    public List<Auditoria> listarRecientes(int limit) {
        List<Auditoria> lista = new ArrayList<>();
        String sql = "SELECT a.*, u.correo AS usuario_correo " +
                     "FROM auditoria a " +
                     "LEFT JOIN usuario u ON a.id_usuario = u.id_usuario " +
                     "ORDER BY a.fecha DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Auditoria a = new Auditoria();
                    a.setIdAuditoria(rs.getInt("id_auditoria"));
                    int idU = rs.getInt("id_usuario");
                    a.setIdUsuario(rs.wasNull() ? null : idU);
                    a.setAccion(rs.getString("accion"));
                    a.setTablaAfectada(rs.getString("tabla_afectada"));
                    int regId = rs.getInt("registro_id");
                    a.setRegistroId(rs.wasNull() ? null : regId);
                    a.setFecha(rs.getTimestamp("fecha"));
                    a.setIpAddress(rs.getString("ip_address"));
                    a.setUsuarioCorreo(rs.getString("usuario_correo"));
                    lista.add(a);
                }
            }
        } catch (SQLException e) {
            System.err.println("[AuditoriaDAO] Error al listar auditoría: " + e.getMessage());
        }
        return lista;
    }
}
