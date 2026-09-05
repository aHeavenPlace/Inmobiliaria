package com.inmobiliariavesta.dao;

import com.inmobiliariavesta.config.DBConnection;
import com.inmobiliariavesta.model.Inmobiliaria;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class InmobiliariaDAO {

    public List<Inmobiliaria> listarTodas() {
        List<Inmobiliaria> lista = new ArrayList<>();
        String sql = "SELECT * FROM inmobiliaria WHERE estado = 'activo' ORDER BY nombre ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(new Inmobiliaria(
                    rs.getInt("id_inmobiliaria"),
                    rs.getString("nombre"),
                    rs.getString("nit"),
                    rs.getString("telefono"),
                    rs.getString("correo_contacto"),
                    rs.getString("direccion"),
                    rs.getString("logo_url"),
                    rs.getString("estado")
                ));
            }
        } catch (SQLException e) {
            System.err.println("[InmobiliariaDAO] Error al listar inmobiliarias: " + e.getMessage());
        }
        return lista;
    }

    public Inmobiliaria obtenerPorId(int idInmobiliaria) {
        String sql = "SELECT * FROM inmobiliaria WHERE id_inmobiliaria = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idInmobiliaria);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Inmobiliaria(
                        rs.getInt("id_inmobiliaria"),
                        rs.getString("nombre"),
                        rs.getString("nit"),
                        rs.getString("telefono"),
                        rs.getString("correo_contacto"),
                        rs.getString("direccion"),
                        rs.getString("logo_url"),
                        rs.getString("estado")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("[InmobiliariaDAO] Error al obtener inmobiliaria: " + e.getMessage());
        }
        return null;
    }
}
