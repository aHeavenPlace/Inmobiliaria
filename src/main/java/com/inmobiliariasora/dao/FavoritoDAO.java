package com.inmobiliariasora.dao;

import com.inmobiliariasora.config.DBConnection;
import com.inmobiliariasora.model.Propiedad;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FavoritoDAO {

    /**
     * Alterna (toggle) una propiedad en favoritos del usuario.
     * Si ya existe, la elimina y retorna false.
     * Si no existe, la agrega y retorna true.
     */
    public boolean toggleFavorito(int idUsuario, int idPropiedad) {
        if (esFavorito(idUsuario, idPropiedad)) {
            eliminarFavorito(idUsuario, idPropiedad);
            return false;
        } else {
            agregarFavorito(idUsuario, idPropiedad);
            return true;
        }
    }

    public boolean esFavorito(int idUsuario, int idPropiedad) {
        String sql = "SELECT 1 FROM favorito WHERE id_usuario = ? AND id_propiedad = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            ps.setInt(2, idPropiedad);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            System.err.println("[FavoritoDAO] Error verificando favorito: " + e.getMessage());
            return false;
        }
    }

    public boolean agregarFavorito(int idUsuario, int idPropiedad) {
        String sql = "INSERT INTO favorito (id_usuario, id_propiedad) VALUES (?, ?) ON CONFLICT DO NOTHING";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            ps.setInt(2, idPropiedad);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[FavoritoDAO] Error agregando favorito: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminarFavorito(int idUsuario, int idPropiedad) {
        String sql = "DELETE FROM favorito WHERE id_usuario = ? AND id_propiedad = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            ps.setInt(2, idPropiedad);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[FavoritoDAO] Error eliminando favorito: " + e.getMessage());
            return false;
        }
    }

    public List<Propiedad> listarPorUsuario(int idUsuario) {
        List<Propiedad> lista = new ArrayList<>();
        String sql = "SELECT p.*, c.nombre AS ciudad_nombre, tp.nombre AS tipo_nombre, " +
                     "i.nombre AS inmobiliaria_nombre, img.url AS imagen_principal " +
                     "FROM favorito f " +
                     "INNER JOIN propiedad p ON f.id_propiedad = p.id_propiedad " +
                     "INNER JOIN ciudad c ON p.id_ciudad = c.id_ciudad " +
                     "INNER JOIN tipo_propiedad tp ON p.id_tipo = tp.id_tipo " +
                     "INNER JOIN inmobiliaria i ON p.id_inmobiliaria = i.id_inmobiliaria " +
                     "LEFT JOIN ( " +
                     "    SELECT DISTINCT ON (id_propiedad) id_propiedad, url " +
                     "    FROM imagen_propiedad " +
                     "    ORDER BY id_propiedad, orden ASC " +
                     ") img ON p.id_propiedad = img.id_propiedad " +
                     "WHERE f.id_usuario = ? " +
                     "ORDER BY f.fecha_agregado DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Propiedad p = new Propiedad();
                    p.setIdPropiedad(rs.getInt("id_propiedad"));
                    p.setTitulo(rs.getString("titulo"));
                    p.setDescripcion(rs.getString("descripcion"));
                    p.setDireccion(rs.getString("direccion"));
                    p.setPrecio(rs.getBigDecimal("precio"));
                    p.setAreaM2(rs.getBigDecimal("area_m2"));
                    p.setHabitaciones(rs.getInt("habitaciones"));
                    p.setBanos(rs.getInt("banos"));
                    p.setTipoOperacion(rs.getString("tipo_operacion"));
                    p.setEstado(rs.getString("estado"));
                    p.setCiudadNombre(rs.getString("ciudad_nombre"));
                    p.setTipoNombre(rs.getString("tipo_nombre"));
                    p.setInmobiliariaNombre(rs.getString("inmobiliaria_nombre"));
                    p.setImagenPrincipal(rs.getString("imagen_principal"));
                    p.setEsFavorito(true);
                    lista.add(p);
                }
            }
        } catch (SQLException e) {
            System.err.println("[FavoritoDAO] Error listando favoritos: " + e.getMessage());
        }
        return lista;
    }
}
