package com.inmobiliariasora.controller;

import com.google.gson.Gson;
import com.inmobiliariasora.dao.PropiedadDAO;
import com.inmobiliariasora.dao.ReportesDAO;
import com.inmobiliariasora.model.EstadisticaCiudadDTO;
import com.inmobiliariasora.model.EstadisticaTipoDTO;
import com.inmobiliariasora.model.Propiedad;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "ReporteServlet", urlPatterns = {
    "/api/reportes/ciudades",
    "/api/reportes/tipos",
    "/api/reportes/metricas",
    "/reportes/exportar-csv"
})
public class ReporteServlet extends HttpServlet {

    private ReportesDAO reportesDAO = new ReportesDAO();
    private PropiedadDAO propiedadDAO = new PropiedadDAO();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/api/reportes/ciudades".equals(path)) {
            List<EstadisticaCiudadDTO> lista = reportesDAO.obtenerEstadisticasCiudades(1);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(gson.toJson(lista));
            return;
        }

        if ("/api/reportes/tipos".equals(path)) {
            List<EstadisticaTipoDTO> lista = reportesDAO.obtenerEstadisticasTiposPropiedad(1);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(gson.toJson(lista));
            return;
        }

        if ("/api/reportes/metricas".equals(path)) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(gson.toJson(reportesDAO.obtenerMetricasDashboard(null, null)));
            return;
        }

        if ("/reportes/exportar-csv".equals(path)) {
            exportarCSV(request, response);
            return;
        }
    }

    private void exportarCSV(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/csv; charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=\"reporte_propiedades_sora.csv\"");

        PrintWriter writer = response.getWriter();
        // BOM UTF-8 para Excel
        writer.write('\ufeff');
        writer.println("ID;Matricula;Titulo;Ciudad;Tipo;Operacion;Precio;Area_m2;Habitaciones;Banos;Estado;Fecha");

        List<Propiedad> propiedades = propiedadDAO.listarCatalogoConFiltros(null, null, null, null, null, null);
        for (Propiedad p : propiedades) {
            writer.printf("%d;\"%s\";\"%s\";\"%s\";\"%s\";\"%s\";%s;%s;%d;%d;\"%s\";\"%s\"%n",
                p.getIdPropiedad(),
                p.getMatriculaInmobiliaria() != null ? p.getMatriculaInmobiliaria() : "",
                p.getTitulo() != null ? p.getTitulo().replace("\"", "\"\"") : "",
                p.getCiudadNombre() != null ? p.getCiudadNombre() : "",
                p.getTipoNombre() != null ? p.getTipoNombre() : "",
                p.getTipoOperacion() != null ? p.getTipoOperacion() : "",
                p.getPrecio() != null ? p.getPrecio().toString() : "0",
                p.getAreaM2() != null ? p.getAreaM2().toString() : "0",
                p.getHabitaciones(),
                p.getBanos(),
                p.getEstado() != null ? p.getEstado() : "",
                p.getFechaPublicacion() != null ? p.getFechaPublicacion().toString() : ""
            );
        }
        writer.flush();
    }
}
