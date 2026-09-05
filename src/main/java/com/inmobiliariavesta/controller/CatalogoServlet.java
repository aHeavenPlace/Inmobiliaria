package com.inmobiliariavesta.controller;

import com.google.gson.Gson;
import com.inmobiliariavesta.dao.CiudadDAO;
import com.inmobiliariavesta.dao.PropiedadDAO;
import com.inmobiliariavesta.dao.TipoPropiedadDAO;
import com.inmobiliariavesta.model.Propiedad;
import com.inmobiliariavesta.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(name = "CatalogoServlet", urlPatterns = {"/catalogo"})
public class CatalogoServlet extends HttpServlet {

    private PropiedadDAO propiedadDAO = new PropiedadDAO();
    private CiudadDAO ciudadDAO = new CiudadDAO();
    private TipoPropiedadDAO tipoDAO = new TipoPropiedadDAO();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuarioLogueado") : null;
        Integer idUsuario = (usuario != null) ? usuario.getIdUsuario() : null;

        // Parámetros de filtrado
        String ciudadParam = request.getParameter("ciudad");
        String tipoParam = request.getParameter("tipo");
        String operacionParam = request.getParameter("operacion");
        String precioParam = request.getParameter("precio");
        String keyword = request.getParameter("q");

        Integer idCiudad = null;
        if (ciudadParam != null && !ciudadParam.isBlank()) {
            try { idCiudad = Integer.parseInt(ciudadParam); } catch (NumberFormatException ignored) {}
        }

        Integer idTipo = null;
        if (tipoParam != null && !tipoParam.isBlank()) {
            try { idTipo = Integer.parseInt(tipoParam); } catch (NumberFormatException ignored) {}
        }

        BigDecimal maxPrecio = null;
        if (precioParam != null && !precioParam.isBlank()) {
            try { maxPrecio = new BigDecimal(precioParam); } catch (Exception ignored) {}
        }

        List<Propiedad> propiedades = propiedadDAO.listarCatalogoConFiltros(
            idCiudad, idTipo, operacionParam, maxPrecio, idUsuario, keyword
        );

        // Si se solicita formato JSON (para búsquedas reactivas con AJAX)
        String format = request.getParameter("format");
        if ("json".equalsIgnoreCase(format)) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(gson.toJson(propiedades));
            return;
        }

        request.setAttribute("propiedades", propiedades);
        request.setAttribute("ciudades", ciudadDAO.listarTodas());
        request.setAttribute("tiposPropiedad", tipoDAO.listarTodos());

        // Mantener valores de filtros en la vista
        request.setAttribute("filtroCiudad", idCiudad);
        request.setAttribute("filtroTipo", idTipo);
        request.setAttribute("filtroOperacion", operacionParam);
        request.setAttribute("filtroPrecio", precioParam);
        request.setAttribute("filtroQ", keyword);

        request.getRequestDispatcher("/WEB-INF/views/public/catalogo.jsp").forward(request, response);
    }
}
