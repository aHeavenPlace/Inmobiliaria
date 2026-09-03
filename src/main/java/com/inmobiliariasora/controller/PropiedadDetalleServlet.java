package com.inmobiliariasora.controller;

import com.inmobiliariasora.dao.FavoritoDAO;
import com.inmobiliariasora.dao.PropiedadDAO;
import com.inmobiliariasora.model.Propiedad;
import com.inmobiliariasora.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "PropiedadDetalleServlet", urlPatterns = {"/propiedad"})
public class PropiedadDetalleServlet extends HttpServlet {

    private PropiedadDAO propiedadDAO = new PropiedadDAO();
    private FavoritoDAO favoritoDAO = new FavoritoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/catalogo");
            return;
        }

        try {
            int idPropiedad = Integer.parseInt(idParam);
            Propiedad propiedad = propiedadDAO.obtenerPorIdConDetalle(idPropiedad);

            if (propiedad == null) {
                response.sendRedirect(request.getContextPath() + "/catalogo?error=no_encontrada");
                return;
            }

            // Verificar si es favorito del usuario actual
            HttpSession session = request.getSession(false);
            Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuarioLogueado") : null;
            if (usuario != null) {
                propiedad.setEsFavorito(favoritoDAO.esFavorito(usuario.getIdUsuario(), idPropiedad));
            }

            // Propiedades similares en la misma ciudad
            List<Propiedad> similares = propiedadDAO.listarCatalogoConFiltros(
                propiedad.getIdCiudad(), null, null, null, usuario != null ? usuario.getIdUsuario() : null, null
            );
            similares.removeIf(p -> p.getIdPropiedad() == idPropiedad);

            request.setAttribute("propiedad", propiedad);
            request.setAttribute("similares", similares);
            request.getRequestDispatcher("/WEB-INF/views/public/detalle.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/catalogo");
        }
    }
}
