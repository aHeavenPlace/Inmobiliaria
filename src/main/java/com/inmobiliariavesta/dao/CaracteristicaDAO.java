package com.inmobiliariavesta.dao;

import com.inmobiliariavesta.config.DBConnection;
import com.inmobiliariavesta.model.Caracteristica;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CaracteristicaDAO {

    public List<Caracteristica> listarTodas() {
        List<Caracteristica> lista = new ArrayList<>();
        String sql = "SELECT * FROM caracteristica ORDER BY nombre ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(new Caracteristica(
                    rs.getInt("id_caracteristica"),
                    rs.getString("nombre"),
                    rs.getString("descripcion")
                ));
            }
        } catch (SQLException e) {
            System.err.println("[CaracteristicaDAO] Error al listar características: " + e.getMessage());
        }
        return lista;
    }

    public Caracteristica obtenerPorId(int idCaracteristica) {
        String sql = "SELECT * FROM caracteristica WHERE id_caracteristica = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idCaracteristica);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Caracteristica(
                        rs.getInt("id_caracteristica"),
                        rs.getString("nombre"),
                        rs.getString("descripcion")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("[CaracteristicaDAO] Error al obtener característica: " + e.getMessage());
        }
        return null;
    }

    public boolean insertar(Caracteristica c) {
        String sql = "INSERT INTO caracteristica (nombre, descripcion) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, c.getNombre());
            ps.setString(2, c.getDescripcion());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[CaracteristicaDAO] Error al insertar característica: " + e.getMessage());
            return false;
        }
    }
}
