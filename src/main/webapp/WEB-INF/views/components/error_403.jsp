<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/components/header.jsp">
    <jsp:param name="pageTitle" value="Acceso Restringido (403) | Inmobiliaria Vesta"/>
</jsp:include>

<div class="container py-5 text-center" style="min-height: 65vh; display: flex; flex-direction: column; justify-content: center; align-items: center;">
    <div class="mb-4">
        <i class="bi bi-shield-slash text-danger" style="font-size: 5rem;"></i>
    </div>
    <h1 class="display-4 fw-bold text-danger mb-2">403</h1>
    <h3 class="fw-semibold mb-3">Acceso Restringido</h3>
    <p class="text-muted max-w-md mx-auto mb-4" style="max-width: 500px;">
        No cuentas con los permisos o el rol requerido para visualizar este panel o recurso del sistema.
    </p>
    <div class="d-flex gap-3">
        <a href="${pageContext.request.contextPath}/home" class="btn btn-vesta-primary">
            <i class="bi bi-house-door me-1"></i> Volver al Inicio
        </a>
        <a href="${pageContext.request.contextPath}/login" class="btn btn-vesta-outline">
            <i class="bi bi-box-arrow-in-right me-1"></i> Cambiar de Cuenta
        </a>
    </div>
</div>

<jsp:include page="/WEB-INF/views/components/footer.jsp"/>
