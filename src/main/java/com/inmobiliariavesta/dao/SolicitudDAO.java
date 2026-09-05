package com.inmobiliariavesta.dao;

import com.inmobiliariavesta.config.DBConnection;
import com.inmobiliariavesta.model.DocumentoSolicitud;
import com.inmobiliariavesta.model.Solicitud;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class SolicitudDAO {

    public List<Solicitud> listarPorInmobiliaria(int idInmobiliaria) {
        List<Solicitud> lista = new ArrayList<>();
        String sql = "SELECT s.*, " +
                     "p.titulo AS propiedad_titulo, p.direccion AS propiedad_direccion, " +
                     "pr.nombres AS cliente_nombres, pr.apellidos AS cliente_apellidos, " +
                     "u.correo AS cliente_correo, pr.telefono AS cliente_telefono " +
                     "FROM solicitud s " +
                     "INNER JOIN propiedad p ON s.id_propiedad = p.id_propiedad " +
                     "INNER JOIN usuario u ON s.id_cliente = u.id_usuario " +
                     "INNER JOIN perfil pr ON u.id_usuario = pr.id_usuario " +
                     "WHERE p.id_inmobiliaria = ? " +
                     "ORDER BY s.fecha_solicitud DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idInmobiliaria);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Solicitud s = new Solicitud();
                    s.setIdSolicitud(rs.getInt("id_solicitud"));
                    s.setIdPropiedad(rs.getInt("id_propiedad"));
                    s.setIdCliente(rs.getInt("id_cliente"));
                    s.setTipo(rs.getString("tipo"));
                    s.setEstado(rs.getString("estado"));
                    s.setFechaSolicitud(rs.getTimestamp("fecha_solicitud"));
                    s.setComentarios(rs.getString("comentarios"));
                    s.setPropiedadTitulo(rs.getString("propiedad_titulo"));
                    s.setPropiedadDireccion(rs.getString("propiedad_direccion"));
                    s.setClienteNombres(rs.getString("cliente_nombres"));
                    s.setClienteApellidos(rs.getString("cliente_apellidos"));
                    s.setClienteCorreo(rs.getString("cliente_correo"));
                    s.setClienteTelefono(rs.getString("cliente_telefono"));
                    s.setDocumentos(obtenerDocumentos(s.getIdSolicitud()));
                    lista.add(s);
                }
            }
        } catch (SQLException e) {
            System.err.println("[SolicitudDAO] Error al listar por inmobiliaria: " + e.getMessage());
        }
        return lista;
    }

    public List<Solicitud> listarPorCliente(int idCliente) {
        List<Solicitud> lista = new ArrayList<>();
        String sql = "SELECT s.*, " +
                     "p.titulo AS propiedad_titulo, p.direccion AS propiedad_direccion, " +
                     "i.nombre AS inmobiliaria_nombre " +
                     "FROM solicitud s " +
                     "INNER JOIN propiedad p ON s.id_propiedad = p.id_propiedad " +
                     "INNER JOIN inmobiliaria i ON p.id_inmobiliaria = i.id_inmobiliaria " +
                     "WHERE s.id_cliente = ? " +
                     "ORDER BY s.fecha_solicitud DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idCliente);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Solicitud s = new Solicitud();
                    s.setIdSolicitud(rs.getInt("id_solicitud"));
                    s.setIdPropiedad(rs.getInt("id_propiedad"));
                    s.setIdCliente(rs.getInt("id_cliente"));
                    s.setTipo(rs.getString("tipo"));
                    s.setEstado(rs.getString("estado"));
                    s.setFechaSolicitud(rs.getTimestamp("fecha_solicitud"));
                    s.setComentarios(rs.getString("comentarios"));
                    s.setPropiedadTitulo(rs.getString("propiedad_titulo"));
                    s.setPropiedadDireccion(rs.getString("propiedad_direccion"));
                    s.setInmobiliariaNombre(rs.getString("inmobiliaria_nombre"));
                    s.setDocumentos(obtenerDocumentos(s.getIdSolicitud()));
                    lista.add(s);
                }
            }
        } catch (SQLException e) {
            System.err.println("[SolicitudDAO] Error al listar solicitudes por cliente: " + e.getMessage());
        }
        return lista;
    }

    public int crearSolicitud(Solicitud s, List<DocumentoSolicitud> docs) throws SQLException {
        String sqlSol = "INSERT INTO solicitud (id_propiedad, id_cliente, tipo, estado, comentarios) VALUES (?, ?, ?, 'pendiente', ?)";
        String sqlDoc = "INSERT INTO documento_solicitud (id_solicitud, nombre_archivo, url, tipo_documento) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                int idSolGenerado = -1;
                try (PreparedStatement psS = conn.prepareStatement(sqlSol, Statement.RETURN_GENERATED_KEYS)) {
                    psS.setInt(1, s.getIdPropiedad());
                    psS.setInt(2, s.getIdCliente());
                    psS.setString(3, s.getTipo());
                    psS.setString(4, s.getComentarios());
                    psS.executeUpdate();

                    try (ResultSet rs = psS.getGeneratedKeys()) {
                        if (rs.next()) {
                            idSolGenerado = rs.getInt(1);
                        }
                    }
                }

                if (idSolGenerado <= 0) {
                    throw new SQLException("No se pudo generar la solicitud.");
                }

                if (docs != null && !docs.isEmpty()) {
                    try (PreparedStatement psD = conn.prepareStatement(sqlDoc)) {
                        for (DocumentoSolicitud doc : docs) {
                            psD.setInt(1, idSolGenerado);
                            psD.setString(2, doc.getNombreArchivo());
                            psD.setString(3, doc.getUrl());
                            psD.setString(4, doc.getTipoDocumento());
                            psD.addBatch();
                        }
                        psD.executeBatch();
                    }
                }

                conn.commit();
                return idSolGenerado;

            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    public boolean cambiarEstado(int idSolicitud, String nuevoEstado) {
        String sql = "UPDATE solicitud SET estado = ? WHERE id_solicitud = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, nuevoEstado);
            ps.setInt(2, idSolicitud);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[SolicitudDAO] Error al cambiar estado de solicitud: " + e.getMessage());
            return false;
        }
    }

    public List<DocumentoSolicitud> obtenerDocumentos(int idSolicitud) {
        List<DocumentoSolicitud> lista = new ArrayList<>();
        String sql = "SELECT * FROM documento_solicitud WHERE id_solicitud = ? ORDER BY fecha_carga ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idSolicitud);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(new DocumentoSolicitud(
                        rs.getInt("id_documento"),
                        rs.getInt("id_solicitud"),
                        rs.getString("nombre_archivo"),
                        rs.getString("url"),
                        rs.getString("tipo_documento"),
                        rs.getTimestamp("fecha_carga")
                    ));
                }
            }
        } catch (SQLException e) {
            System.err.println("[SolicitudDAO] Error al obtener documentos: " + e.getMessage());
        }
        return lista;
    }
}
