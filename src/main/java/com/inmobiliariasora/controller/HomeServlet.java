package com.inmobiliariasora.controller;

import com.inmobiliariasora.dao.CiudadDAO;
import com.inmobiliariasora.dao.PropiedadDAO;
import com.inmobiliariasora.dao.TipoPropiedadDAO;
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

@WebServlet(name = "HomeServlet", urlPatterns = {"", "/home"})
public class HomeServlet extends HttpServlet {

    private PropiedadDAO propiedadDAO = new PropiedadDAO();
    private CiudadDAO ciudadDAO = new CiudadDAO();
    private TipoPropiedadDAO tipoDAO = new TipoPropiedadDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuarioLogueado") : null;
        Integer idUsuario = (usuario != null) ? usuario.getIdUsuario() : null;

        // Propiedades destacadas (últimas 6 disponibles)
        List<Propiedad> destacadas = propiedadDAO.listarDestacadas(6, idUsuario);

        // Catálogos para el buscador flotante
        request.setAttribute("propiedadesDestacadas", destacadas);
        request.setAttribute("ciudades", ciudadDAO.listarTodas());
        request.setAttribute("tiposPropiedad", tipoDAO.listarTodos());

        request.getRequestDispatcher("/WEB-INF/views/public/index.jsp").forward(request, response);
    }
}
