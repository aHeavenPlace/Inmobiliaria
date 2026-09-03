<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<jsp:include page="/WEB-INF/views/components/header.jsp">
    <jsp:param name="pageTitle" value="Error del Servidor (500) | Inmobiliaria Sora"/>
</jsp:include>

<div class="container py-5 text-center" style="min-height: 65vh; display: flex; flex-direction: column; justify-content: center; align-items: center;">
    <div class="mb-4">
        <i class="bi bi-exclamation-octagon text-warning" style="font-size: 5rem;"></i>
    </div>
    <h1 class="display-4 fw-bold text-primary mb-2">500</h1>
    <h3 class="fw-semibold mb-3">Ha ocurrido una incidencia técnica</h3>
    <p class="text-muted max-w-md mx-auto mb-4" style="max-width: 550px;">
        Hemos registrado el evento en nuestros registros de auditoría. Nuestro equipo de soporte técnico se encuentra atendiendo la situación.
    </p>
    <div class="d-flex gap-3">
        <a href="${pageContext.request.contextPath}/home" class="btn btn-sora-primary">
            <i class="bi bi-house-door me-1"></i> Ir al Inicio
        </a>
    </div>
</div>

<jsp:include page="/WEB-INF/views/components/footer.jsp"/>
