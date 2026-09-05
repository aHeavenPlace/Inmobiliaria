package com.inmobiliariavesta.dao;

import com.inmobiliariavesta.config.DBConnection;
import com.inmobiliariavesta.model.Ciudad;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CiudadDAO {

    public List<Ciudad> listarTodas() {
        List<Ciudad> lista = new ArrayList<>();
        String sql = "SELECT * FROM ciudad ORDER BY nombre ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(new Ciudad(
                    rs.getInt("id_ciudad"),
                    rs.getString("nombre"),
                    rs.getString("departamento"),
                    rs.getString("codigo_postal")
                ));
            }
        } catch (SQLException e) {
            System.err.println("[CiudadDAO] Error al listar ciudades: " + e.getMessage());
        }
        return lista;
    }

    public Ciudad obtenerPorId(int idCiudad) {
        String sql = "SELECT * FROM ciudad WHERE id_ciudad = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idCiudad);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Ciudad(
                        rs.getInt("id_ciudad"),
                        rs.getString("nombre"),
                        rs.getString("departamento"),
                        rs.getString("codigo_postal")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("[CiudadDAO] Error al obtener ciudad: " + e.getMessage());
        }
        return null;
    }

    public boolean insertar(Ciudad ciudad) {
        String sql = "INSERT INTO ciudad (nombre, departamento, codigo_postal) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, ciudad.getNombre());
            ps.setString(2, ciudad.getDepartamento());
            ps.setString(3, ciudad.getCodigoPostal());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[CiudadDAO] Error al insertar ciudad: " + e.getMessage());
            return false;
        }
    }
}
