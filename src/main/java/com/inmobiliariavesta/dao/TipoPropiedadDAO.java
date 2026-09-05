package com.inmobiliariavesta.dao;

import com.inmobiliariavesta.config.DBConnection;
import com.inmobiliariavesta.model.TipoPropiedad;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TipoPropiedadDAO {

    public List<TipoPropiedad> listarTodos() {
        List<TipoPropiedad> lista = new ArrayList<>();
        String sql = "SELECT * FROM tipo_propiedad ORDER BY nombre ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(new TipoPropiedad(
                    rs.getInt("id_tipo"),
                    rs.getString("nombre"),
                    rs.getString("descripcion")
                ));
            }
        } catch (SQLException e) {
            System.err.println("[TipoPropiedadDAO] Error al listar tipos de propiedad: " + e.getMessage());
        }
        return lista;
    }

    public TipoPropiedad obtenerPorId(int idTipo) {
        String sql = "SELECT * FROM tipo_propiedad WHERE id_tipo = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idTipo);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new TipoPropiedad(
                        rs.getInt("id_tipo"),
                        rs.getString("nombre"),
                        rs.getString("descripcion")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("[TipoPropiedadDAO] Error al obtener tipo de propiedad: " + e.getMessage());
        }
        return null;
    }

    public boolean insertar(TipoPropiedad tipo) {
        String sql = "INSERT INTO tipo_propiedad (nombre, descripcion) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, tipo.getNombre());
            ps.setString(2, tipo.getDescripcion());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[TipoPropiedadDAO] Error al insertar tipo: " + e.getMessage());
            return false;
        }
    }
}
