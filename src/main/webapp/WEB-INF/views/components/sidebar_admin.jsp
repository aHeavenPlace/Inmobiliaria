<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="dashboard-sidebar">
    <div class="sidebar-user">
        <img src="${not empty sessionScope.usuarioLogueado.perfil.fotoUrl ? sessionScope.usuarioLogueado.perfil.fotoUrl : 'https://i.pravatar.cc/150?u=' + sessionScope.usuarioLogueado.idUsuario}" 
             alt="Avatar" class="sidebar-avatar">
        <div class="overflow-hidden">
            <h6 class="fw-bold mb-0 text-truncate">${sessionScope.nombreUsuario}</h6>
            <small class="text-muted d-block text-truncate">Super Administrador</small>
            <span class="badge bg-danger bg-opacity-10 text-danger small px-2 py-0 mt-1">Admin Global</span>
        </div>
    </div>

    <div class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link ${pageContext.request.servletPath == '/admin/dashboard' ? 'active' : ''}">
            <i class="bi bi-speedometer2"></i>
            <span>Dashboard Global</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/usuarios" class="sidebar-link ${pageContext.request.servletPath == '/admin/usuarios' ? 'active' : ''}">
            <i class="bi bi-people"></i>
            <span>Usuarios & Roles</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/catalogos" class="sidebar-link ${pageContext.request.servletPath == '/admin/catalogos' ? 'active' : ''}">
            <i class="bi bi-sliders"></i>
            <span>Parametrización</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/auditoria" class="sidebar-link ${pageContext.request.servletPath == '/admin/auditoria' ? 'active' : ''}">
            <i class="bi bi-journal-text"></i>
            <span>Auditoría del Sistema</span>
        </a>
        <hr class="my-2 text-muted opacity-25">
        <a href="${pageContext.request.contextPath}/catalogo" class="sidebar-link">
            <i class="bi bi-eye"></i>
            <span>Portal Público</span>
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="sidebar-link text-danger">
            <i class="bi bi-box-arrow-right"></i>
            <span>Cerrar Sesión</span>
        </a>
    </div>
</div>
