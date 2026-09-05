package com.inmobiliariavesta.controller;

import com.google.gson.Gson;
import com.inmobiliariavesta.dao.AuditoriaDAO;
import com.inmobiliariavesta.dao.CitaDAO;
import com.inmobiliariavesta.dao.FavoritoDAO;
import com.inmobiliariavesta.dao.PerfilDAO;
import com.inmobiliariavesta.dao.PropiedadDAO;
import com.inmobiliariavesta.dao.ReportesDAO;
import com.inmobiliariavesta.dao.SolicitudDAO;
import com.inmobiliariavesta.model.Cita;
import com.inmobiliariavesta.model.DocumentoSolicitud;
import com.inmobiliariavesta.model.Perfil;
import com.inmobiliariavesta.model.Propiedad;
import com.inmobiliariavesta.model.Solicitud;
import com.inmobiliariavesta.model.Usuario;
import com.inmobiliariavesta.util.FileUploadUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ClienteServlet", urlPatterns = {
    "/cliente/dashboard",
    "/cliente/favoritos",
    "/cliente/favorito-toggle",
    "/cliente/citas",
    "/cliente/agendar-cita",
    "/cliente/solicitudes",
    "/cliente/radicar-solicitud",
    "/cliente/perfil"
})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 10 * 1024 * 1024,  // 10 MB
    maxRequestSize = 15 * 1024 * 1024 // 15 MB
)
public class ClienteServlet extends HttpServlet {

    private PropiedadDAO propiedadDAO = new PropiedadDAO();
    private FavoritoDAO favoritoDAO = new FavoritoDAO();
    private CitaDAO citaDAO = new CitaDAO();
    private SolicitudDAO solicitudDAO = new SolicitudDAO();
    private PerfilDAO perfilDAO = new PerfilDAO();
    private ReportesDAO reportesDAO = new ReportesDAO();
    private AuditoriaDAO auditoriaDAO = new AuditoriaDAO();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
        int idCliente = usuario.getIdUsuario();

        String path = request.getServletPath();

        switch (path) {
            case "/cliente/dashboard":
                cargarDashboard(request, response, idCliente);
                break;

            case "/cliente/favoritos":
                request.setAttribute("favoritos", favoritoDAO.listarPorUsuario(idCliente));
                request.getRequestDispatcher("/WEB-INF/views/cliente/favoritos.jsp").forward(request, response);
                break;

            case "/cliente/citas":
                request.setAttribute("citas", citaDAO.listarPorCliente(idCliente));
                request.getRequestDispatcher("/WEB-INF/views/cliente/citas.jsp").forward(request, response);
                break;

            case "/cliente/solicitudes":
                request.setAttribute("solicitudes", solicitudDAO.listarPorCliente(idCliente));
                request.getRequestDispatcher("/WEB-INF/views/cliente/solicitudes.jsp").forward(request, response);
                break;

            case "/cliente/perfil":
                request.setAttribute("perfil", perfilDAO.obtenerPorIdUsuario(idCliente));
                request.getRequestDispatcher("/WEB-INF/views/cliente/perfil.jsp").forward(request, response);
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/cliente/dashboard");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
        int idCliente = usuario.getIdUsuario();

        String path = request.getServletPath();

        switch (path) {
            case "/cliente/favorito-toggle":
                procesarToggleFavorito(request, response, idCliente);
                break;

            case "/cliente/agendar-cita":
                procesarAgendarCita(request, response, idCliente);
                break;

            case "/cliente/radicar-solicitud":
                procesarRadicarSolicitud(request, response, idCliente);
                break;

            case "/cliente/perfil":
                procesarActualizarPerfil(request, response, usuario);
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/cliente/dashboard");
                break;
        }
    }

    private void cargarDashboard(HttpServletRequest request, HttpServletResponse response, int idCliente) 
            throws ServletException, IOException {
        Map<String, Object> metricas = reportesDAO.obtenerMetricasDashboard(null, idCliente);
        List<Cita> proximasCitas = citaDAO.listarPorCliente(idCliente);
        List<Solicitud> ultimasSolicitudes = solicitudDAO.listarPorCliente(idCliente);
        List<Propiedad> misFavoritos = favoritoDAO.listarPorUsuario(idCliente);

        request.setAttribute("metricas", metricas);
        request.setAttribute("citas", proximasCitas);
        request.setAttribute("solicitudes", ultimasSolicitudes);
        request.setAttribute("favoritos", misFavoritos);

        request.getRequestDispatcher("/WEB-INF/views/cliente/dashboard.jsp").forward(request, response);
    }

    private void procesarToggleFavorito(HttpServletRequest request, HttpServletResponse response, int idCliente) 
            throws IOException {
        String idPropiedadStr = request.getParameter("idPropiedad");
        Map<String, Object> res = new HashMap<>();

        try {
            int idPropiedad = Integer.parseInt(idPropiedadStr);
            boolean esFavorito = favoritoDAO.toggleFavorito(idCliente, idPropiedad);
            res.put("success", true);
            res.put("esFavorito", esFavorito);
            res.put("mensaje", esFavorito ? "Propiedad agregada a favoritos" : "Propiedad removida de favoritos");
        } catch (Exception e) {
            res.put("success", false);
            res.put("error", e.getMessage());
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(gson.toJson(res));
    }

    private void procesarAgendarCita(HttpServletRequest request, HttpServletResponse response, int idCliente) 
            throws IOException {
        String idPropiedadStr = request.getParameter("idPropiedad");
        String fechaHoraStr = request.getParameter("fechaHora");
        String notas = request.getParameter("notas");

        try {
            int idPropiedad = Integer.parseInt(idPropiedadStr);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            java.util.Date parsedDate = sdf.parse(fechaHoraStr);
            Timestamp timestamp = new Timestamp(parsedDate.getTime());

            Cita cita = new Cita();
            cita.setIdPropiedad(idPropiedad);
            cita.setIdCliente(idCliente);
            cita.setFechaHora(timestamp);
            cita.setNotas(notas);

            citaDAO.agendarCita(cita);
            auditoriaDAO.registrar(idCliente, "INSERT", "cita", idPropiedad, request.getRemoteAddr());

            response.sendRedirect(request.getContextPath() + "/cliente/citas?msg=cita_agendada");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/propiedad?id=" + idPropiedadStr + "&error=error_cita");
        }
    }

    private void procesarRadicarSolicitud(HttpServletRequest request, HttpServletResponse response, int idCliente) 
            throws IOException {
        String idPropiedadStr = request.getParameter("idPropiedad");
        String tipo = request.getParameter("tipo"); // 'compra' o 'arriendo'
        String comentarios = request.getParameter("comentarios");
        String nombreDocumento = request.getParameter("nombreDocumento");

        try {
            int idPropiedad = Integer.parseInt(idPropiedadStr);
            Solicitud s = new Solicitud();
            s.setIdPropiedad(idPropiedad);
            s.setIdCliente(idCliente);
            s.setTipo(tipo != null ? tipo : "compra");
            s.setComentarios(comentarios);

            List<DocumentoSolicitud> docs = new ArrayList<>();
            if (nombreDocumento != null && !nombreDocumento.isBlank()) {
                docs.add(new DocumentoSolicitud(0, 0, nombreDocumento, "/uploads/docs/" + nombreDocumento, "Documento Identidad / Soporte", null));
            }

            int idSol = solicitudDAO.crearSolicitud(s, docs);
            auditoriaDAO.registrar(idCliente, "INSERT", "solicitud", idSol, request.getRemoteAddr());

            response.sendRedirect(request.getContextPath() + "/cliente/solicitudes?msg=solicitud_radicada");
        } catch (SQLException e) {
            response.sendRedirect(request.getContextPath() + "/cliente/solicitudes?error=error_solicitud");
        }
    }

    private void procesarActualizarPerfil(HttpServletRequest request, HttpServletResponse response, Usuario usuario) 
            throws IOException {
        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String documento = request.getParameter("documento");
        String telefono = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");
        
        // Manejar subida de foto de perfil
        Part fotoPart = request.getPart("fotoPerfil");
        String fotoUrl = null;
        
        if (fotoPart != null && fotoPart.getSize() > 0) {
            try {
                String uploadPath = getServletContext().getRealPath("") + "/uploads/perfiles";
                fotoUrl = FileUploadUtil.saveImage(fotoPart, uploadPath);
            } catch (IllegalArgumentException e) {
                response.sendRedirect(request.getContextPath() + "/cliente/perfil?error=" + e.getMessage());
                return;
            } catch (Exception e) {
                // Si falla la subida, continuamos sin actualizar la foto
                fotoUrl = null;
            }
        }

        Perfil p = new Perfil();
        p.setIdUsuario(usuario.getIdUsuario());
        p.setNombres(nombres);
        p.setApellidos(apellidos);
        p.setDocumento(documento);
        p.setTelefono(telefono);
        p.setDireccion(direccion);
        
        // Si se subió una nueva foto, la usamos; si no, mantenemos la existente
        if (fotoUrl != null) {
            p.setFotoUrl(fotoUrl);
        } else if (usuario.getPerfil() != null) {
            p.setFotoUrl(usuario.getPerfil().getFotoUrl());
        }

        perfilDAO.actualizar(p);
        usuario.setPerfil(p);
        request.getSession().setAttribute("nombreUsuario", p.getNombreCompleto());
        auditoriaDAO.registrar(usuario.getIdUsuario(), "UPDATE", "perfil", usuario.getIdUsuario(), request.getRemoteAddr());

        response.sendRedirect(request.getContextPath() + "/cliente/perfil?msg=perfil_actualizado");
    }
}
