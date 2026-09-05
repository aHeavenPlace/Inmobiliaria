<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/components/header.jsp">
    <jsp:param name="pageTitle" value="Página no encontrada (404) | Inmobiliaria Vesta"/>
</jsp:include>

<div class="container py-5 text-center" style="min-height: 65vh; display: flex; flex-direction: column; justify-content: center; align-items: center;">
    <div class="mb-4">
        <i class="bi bi-compass text-muted" style="font-size: 5rem;"></i>
    </div>
    <h1 class="display-4 fw-bold text-primary mb-2">404</h1>
    <h3 class="fw-semibold mb-3">Página no encontrada</h3>
    <p class="text-muted max-w-md mx-auto mb-4" style="max-width: 500px;">
        La propiedad o sección que buscas no existe o ha sido reubicada en nuestro portal.
    </p>
    <div class="d-flex gap-3">
        <a href="${pageContext.request.contextPath}/home" class="btn btn-vesta-primary">
            <i class="bi bi-house-door me-1"></i> Ir al Inicio
        </a>
        <a href="${pageContext.request.contextPath}/catalogo" class="btn btn-vesta-outline">
            <i class="bi bi-search me-1"></i> Explorar Catálogo
        </a>
    </div>
</div>

<jsp:include page="/WEB-INF/views/components/footer.jsp"/>
