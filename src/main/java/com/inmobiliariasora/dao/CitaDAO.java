package com.inmobiliariasora.dao;

import com.inmobiliariasora.config.DBConnection;
import com.inmobiliariasora.model.Cita;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CitaDAO {

    /**
     * CONSULTA SQL OBLIGATORIA (INNER JOIN con 3+ tablas #2):
     * Lista las citas de una inmobiliaria relacionando 4 tablas:
     * cita, usuario (cliente), perfil (datos de contacto) y propiedad (inmueble visitado).
     */
    public List<Cita> listarPorInmobiliariaConDetalle(int idInmobiliaria) {
        List<Cita> lista = new ArrayList<>();
        String sql = "SELECT ci.*, " +
                     "pr.nombres AS cliente_nombres, pr.apellidos AS cliente_apellidos, " +
                     "pr.telefono AS cliente_telefono, u.correo AS cliente_correo, " +
                     "p.titulo AS propiedad_titulo, p.direccion AS propiedad_direccion " +
                     "FROM cita ci " +
                     "INNER JOIN usuario u ON ci.id_cliente = u.id_usuario " +
                     "INNER JOIN perfil pr ON u.id_usuario = pr.id_usuario " +
                     "INNER JOIN propiedad p ON ci.id_propiedad = p.id_propiedad " +
                     "WHERE p.id_inmobiliaria = ? " +
                     "ORDER BY ci.fecha_hora DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idInmobiliaria);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Cita c = new Cita();
                    c.setIdCita(rs.getInt("id_cita"));
                    c.setIdPropiedad(rs.getInt("id_propiedad"));
                    c.setIdCliente(rs.getInt("id_cliente"));
                    c.setFechaHora(rs.getTimestamp("fecha_hora"));
                    c.setEstado(rs.getString("estado"));
                    c.setNotas(rs.getString("notas"));
                    c.setClienteNombres(rs.getString("cliente_nombres"));
                    c.setClienteApellidos(rs.getString("cliente_apellidos"));
                    c.setClienteTelefono(rs.getString("cliente_telefono"));
                    c.setClienteCorreo(rs.getString("cliente_correo"));
                    c.setPropiedadTitulo(rs.getString("propiedad_titulo"));
                    c.setPropiedadDireccion(rs.getString("propiedad_direccion"));
                    lista.add(c);
                }
            }
        } catch (SQLException e) {
            System.err.println("[CitaDAO] Error en INNER JOIN con 3+ tablas de citas: " + e.getMessage());
        }
        return lista;
    }

    public List<Cita> listarPorCliente(int idCliente) {
        List<Cita> lista = new ArrayList<>();
        String sql = "SELECT ci.*, p.titulo AS propiedad_titulo, p.direccion AS propiedad_direccion, " +
                     "i.nombre AS inmobiliaria_nombre " +
                     "FROM cita ci " +
                     "INNER JOIN propiedad p ON ci.id_propiedad = p.id_propiedad " +
                     "INNER JOIN inmobiliaria i ON p.id_inmobiliaria = i.id_inmobiliaria " +
                     "WHERE ci.id_cliente = ? " +
                     "ORDER BY ci.fecha_hora DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idCliente);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Cita c = new Cita();
                    c.setIdCita(rs.getInt("id_cita"));
                    c.setIdPropiedad(rs.getInt("id_propiedad"));
                    c.setIdCliente(rs.getInt("id_cliente"));
                    c.setFechaHora(rs.getTimestamp("fecha_hora"));
                    c.setEstado(rs.getString("estado"));
                    c.setNotas(rs.getString("notas"));
                    c.setPropiedadTitulo(rs.getString("propiedad_titulo"));
                    c.setPropiedadDireccion(rs.getString("propiedad_direccion"));
                    c.setInmobiliariaNombre(rs.getString("inmobiliaria_nombre"));
                    lista.add(c);
                }
            }
        } catch (SQLException e) {
            System.err.println("[CitaDAO] Error al listar citas por cliente: " + e.getMessage());
        }
        return lista;
    }

    public boolean agendarCita(Cita cita) throws SQLException {
        String sql = "INSERT INTO cita (id_propiedad, id_cliente, fecha_hora, estado, notas) VALUES (?, ?, ?, 'pendiente', ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cita.getIdPropiedad());
            ps.setInt(2, cita.getIdCliente());
            ps.setTimestamp(3, cita.getFechaHora());
            ps.setString(4, cita.getNotas());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean cambiarEstado(int idCita, String nuevoEstado) {
        String sql = "UPDATE cita SET estado = ? WHERE id_cita = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, nuevoEstado);
            ps.setInt(2, idCita);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[CitaDAO] Error al cambiar estado de cita: " + e.getMessage());
            return false;
        }
    }
}
