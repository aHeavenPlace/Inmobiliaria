package com.inmobiliariasora.dao;

import com.inmobiliariasora.config.DBConnection;
import com.inmobiliariasora.model.Rol;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RolDAO {

    public List<Rol> listarTodos() {
        List<Rol> lista = new ArrayList<>();
        String sql = "SELECT * FROM rol ORDER BY id_rol ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(new Rol(
                    rs.getInt("id_rol"),
                    rs.getString("nombre"),
                    rs.getString("descripcion")
                ));
            }
        } catch (SQLException e) {
            System.err.println("[RolDAO] Error al listar roles: " + e.getMessage());
        }
        return lista;
    }

    public Rol obtenerPorId(int idRol) {
        String sql = "SELECT * FROM rol WHERE id_rol = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idRol);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Rol(
                        rs.getInt("id_rol"),
                        rs.getString("nombre"),
                        rs.getString("descripcion")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("[RolDAO] Error al obtener rol: " + e.getMessage());
        }
        return null;
    }
}
