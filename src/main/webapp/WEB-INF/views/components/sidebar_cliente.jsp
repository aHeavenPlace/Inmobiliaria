<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="dashboard-sidebar">
    <div class="sidebar-user">
        <img src="${not empty sessionScope.usuarioLogueado.perfil.fotoUrl ? sessionScope.usuarioLogueado.perfil.fotoUrl : 'https://i.pravatar.cc/150?u=' + sessionScope.usuarioLogueado.idUsuario}" 
             alt="Avatar" class="sidebar-avatar">
        <div class="overflow-hidden">
            <h6 class="fw-bold mb-0 text-truncate">${sessionScope.nombreUsuario}</h6>
            <small class="text-muted d-block text-truncate">${sessionScope.correoUsuario}</small>
            <span class="badge bg-success bg-opacity-10 text-success small px-2 py-0 mt-1">Cliente</span>
        </div>
    </div>

    <div class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/cliente/dashboard" class="sidebar-link ${pageContext.request.servletPath == '/cliente/dashboard' ? 'active' : ''}">
            <i class="bi bi-speedometer2"></i>
            <span>Resumen</span>
        </a>
        <a href="${pageContext.request.contextPath}/cliente/favoritos" class="sidebar-link ${pageContext.request.servletPath == '/cliente/favoritos' ? 'active' : ''}">
            <i class="bi bi-heart"></i>
            <span>Mis Favoritos</span>
        </a>
        <a href="${pageContext.request.contextPath}/cliente/citas" class="sidebar-link ${pageContext.request.servletPath == '/cliente/citas' ? 'active' : ''}">
            <i class="bi bi-calendar-check"></i>
            <span>Mis Citas</span>
        </a>
        <a href="${pageContext.request.contextPath}/cliente/solicitudes" class="sidebar-link ${pageContext.request.servletPath == '/cliente/solicitudes' ? 'active' : ''}">
            <i class="bi bi-file-earmark-text"></i>
            <span>Mis Solicitudes</span>
        </a>
        <a href="${pageContext.request.contextPath}/cliente/perfil" class="sidebar-link ${pageContext.request.servletPath == '/cliente/perfil' ? 'active' : ''}">
            <i class="bi bi-person-gear"></i>
            <span>Mi Perfil</span>
        </a>
        <hr class="my-2 text-muted opacity-25">
        <a href="${pageContext.request.contextPath}/catalogo" class="sidebar-link">
            <i class="bi bi-search"></i>
            <span>Explorar Inmuebles</span>
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="sidebar-link text-danger">
            <i class="bi bi-box-arrow-right"></i>
            <span>Cerrar Sesión</span>
        </a>
    </div>
</div>
