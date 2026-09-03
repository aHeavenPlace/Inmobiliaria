package com.inmobiliariasora.filter;

import com.inmobiliariasora.model.Usuario;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/cliente/*", "/inmobiliaria/*", "/admin/*", "/favorito/*"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        // Prevenir caché de páginas privadas en el navegador (botón atrás)
        res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        res.setHeader("Pragma", "no-cache");
        res.setDateHeader("Expires", 0);

        HttpSession session = req.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuarioLogueado") : null;

        String path = req.getRequestURI().substring(req.getContextPath().length());

        // 1. Si no está autenticado, redirigir al login
        if (usuario == null) {
            res.sendRedirect(req.getContextPath() + "/login?error=debe_iniciar_sesion&redirect=" + path);
            return;
        }

        // 2. Si el usuario está inactivo o bloqueado
        if (!"activo".equalsIgnoreCase(usuario.getEstado())) {
            session.invalidate();
            res.sendRedirect(req.getContextPath() + "/login?error=cuenta_inactiva");
            return;
        }

        // 3. Control de acceso según rol
        if (path.startsWith("/admin")) {
            if (!usuario.hasRole("admin")) {
                res.sendError(HttpServletResponse.SC_FORBIDDEN, "Acceso no autorizado al panel de administración.");
                return;
            }
        } else if (path.startsWith("/inmobiliaria")) {
            if (!usuario.hasRole("inmobiliaria") && !usuario.hasRole("admin")) {
                res.sendError(HttpServletResponse.SC_FORBIDDEN, "Acceso no autorizado al panel inmobiliario.");
                return;
            }
        } else if (path.startsWith("/cliente") || path.startsWith("/favorito")) {
            if (!usuario.hasRole("cliente") && !usuario.hasRole("admin") && !usuario.hasRole("inmobiliaria")) {
                res.sendError(HttpServletResponse.SC_FORBIDDEN, "Acceso no autorizado al panel de cliente.");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
