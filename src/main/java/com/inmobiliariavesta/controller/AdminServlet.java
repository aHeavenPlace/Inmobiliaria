package com.inmobiliariavesta.controller;

import com.inmobiliariavesta.dao.AuditoriaDAO;
import com.inmobiliariavesta.dao.CaracteristicaDAO;
import com.inmobiliariavesta.dao.CiudadDAO;
import com.inmobiliariavesta.dao.InmobiliariaDAO;
import com.inmobiliariavesta.dao.ReportesDAO;
import com.inmobiliariavesta.dao.RolDAO;
import com.inmobiliariavesta.dao.TipoPropiedadDAO;
import com.inmobiliariavesta.dao.UsuarioDAO;
import com.inmobiliariavesta.model.Caracteristica;
import com.inmobiliariavesta.model.Ciudad;
import com.inmobiliariavesta.model.TipoPropiedad;
import com.inmobiliariavesta.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;

@WebServlet(name = "AdminServlet", urlPatterns = {
    "/admin/dashboard",
    "/admin/usuarios",
    "/admin/usuario-estado",
    "/admin/usuario-rol",
    "/admin/auditoria",
    "/admin/catalogos",
    "/admin/catalogo-ciudad",
    "/admin/catalogo-tipo",
    "/admin/catalogo-caracteristica"
})
public class AdminServlet extends HttpServlet {

    private UsuarioDAO usuarioDAO = new UsuarioDAO();
    private RolDAO rolDAO = new RolDAO();
    private CiudadDAO ciudadDAO = new CiudadDAO();
    private TipoPropiedadDAO tipoDAO = new TipoPropiedadDAO();
    private CaracteristicaDAO caracteristicaDAO = new CaracteristicaDAO();
    private InmobiliariaDAO inmobiliariaDAO = new InmobiliariaDAO();
    private AuditoriaDAO auditoriaDAO = new AuditoriaDAO();
    private ReportesDAO reportesDAO = new ReportesDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String path = request.getServletPath();

        switch (path) {
            case "/admin/dashboard":
                Map<String, Object> metricas = reportesDAO.obtenerMetricasDashboard(null, null);
                request.setAttribute("metricas", metricas);
                request.setAttribute("auditorias", auditoriaDAO.listarRecientes(10));
                request.setAttribute("statsCiudades", reportesDAO.obtenerEstadisticasCiudades(1));
                request.setAttribute("statsTipos", reportesDAO.obtenerEstadisticasTiposPropiedad(1));
                request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
                break;

            case "/admin/usuarios":
                request.setAttribute("usuarios", usuarioDAO.listarTodos());
                request.setAttribute("roles", rolDAO.listarTodos());
                request.getRequestDispatcher("/WEB-INF/views/admin/usuarios.jsp").forward(request, response);
                break;

            case "/admin/auditoria":
                request.setAttribute("auditorias", auditoriaDAO.listarRecientes(50));
                request.getRequestDispatcher("/WEB-INF/views/admin/auditoria.jsp").forward(request, response);
                break;

            case "/admin/catalogos":
                request.setAttribute("ciudades", ciudadDAO.listarTodas());
                request.setAttribute("tipos", tipoDAO.listarTodos());
                request.setAttribute("caracteristicas", caracteristicaDAO.listarTodas());
                request.setAttribute("inmobiliarias", inmobiliariaDAO.listarTodas());
                request.getRequestDispatcher("/WEB-INF/views/admin/catalogos.jsp").forward(request, response);
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String path = request.getServletPath();

        switch (path) {
            case "/admin/usuario-estado":
                procesarEstadoUsuario(request, response);
                break;

            case "/admin/usuario-rol":
                procesarRolUsuario(request, response);
                break;

            case "/admin/catalogo-ciudad":
                Ciudad c = new Ciudad();
                c.setNombre(request.getParameter("nombre"));
                c.setDepartamento(request.getParameter("departamento"));
                c.setCodigoPostal(request.getParameter("codigoPostal"));
                ciudadDAO.insertar(c);
                response.sendRedirect(request.getContextPath() + "/admin/catalogos?msg=ciudad_creada");
                break;

            case "/admin/catalogo-tipo":
                TipoPropiedad tp = new TipoPropiedad();
                tp.setNombre(request.getParameter("nombre"));
                tp.setDescripcion(request.getParameter("descripcion"));
                tipoDAO.insertar(tp);
                response.sendRedirect(request.getContextPath() + "/admin/catalogos?msg=tipo_creado");
                break;

            case "/admin/catalogo-caracteristica":
                Caracteristica carac = new Caracteristica();
                carac.setNombre(request.getParameter("nombre"));
                carac.setDescripcion(request.getParameter("descripcion"));
                caracteristicaDAO.insertar(carac);
                response.sendRedirect(request.getContextPath() + "/admin/catalogos?msg=caracteristica_creada");
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                break;
        }
    }

    private void procesarEstadoUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
            String nuevoEstado = request.getParameter("nuevoEstado");
            usuarioDAO.actualizarEstado(idUsuario, nuevoEstado);
            Usuario admin = (Usuario) request.getSession().getAttribute("usuarioLogueado");
            auditoriaDAO.registrar(admin != null ? admin.getIdUsuario() : null, "UPDATE_ESTADO", "usuario", idUsuario, request.getRemoteAddr());
            response.sendRedirect(request.getContextPath() + "/admin/usuarios?msg=estado_actualizado");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/admin/usuarios?error=" + e.getMessage());
        }
    }

    private void procesarRolUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
            int idRol = Integer.parseInt(request.getParameter("idRol"));
            String accion = request.getParameter("accion"); // 'asignar' o 'remover'

            if ("asignar".equalsIgnoreCase(accion)) {
                usuarioDAO.asignarRol(idUsuario, idRol);
            } else {
                usuarioDAO.removerRol(idUsuario, idRol);
            }
            response.sendRedirect(request.getContextPath() + "/admin/usuarios?msg=rol_actualizado");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/admin/usuarios?error=" + e.getMessage());
        }
    }
}
