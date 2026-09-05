<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/components/header.jsp">
    <jsp:param name="pageTitle" value="Solicitudes Recibidas | Inmobiliaria Vesta"/>
</jsp:include>

<div class="dashboard-wrapper">
    <jsp:include page="/WEB-INF/views/components/sidebar_inmobiliaria.jsp"/>

    <div class="dashboard-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold text-primary mb-1">Solicitudes de Trámite Recibidas</h2>
                <p class="text-muted mb-0">Revisión de documentos de identidad, soportes de ingresos y toma de decisiones</p>
            </div>
        </div>

        <c:if test="${param.msg == 'estado_actualizado'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> Estado de la solicitud actualizado correctamente.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="row g-4">
            <c:forEach var="s" items="${solicitudes}">
                <div class="col-lg-6">
                    <div class="bg-white p-4 rounded-4 border border-light shadow-sm h-100 d-flex flex-column justify-content-between">
                        <div>
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <span class="badge bg-primary text-uppercase px-2 py-1">Solicitud de ${s.tipo}</span>
                                <span class="badge-vesta ${s.estado == 'aprobada' ? 'badge-vesta-success' : s.estado == 'en_revision' ? 'badge-vesta-info' : s.estado == 'pendiente' ? 'badge-vesta-warning' : 'badge-vesta-danger'}">
                                    ${s.estado}
                                </span>
                            </div>

                            <h5 class="fw-bold text-primary mb-1">${s.propiedadTitulo}</h5>
                            <small class="text-muted d-block mb-3"><i class="bi bi-geo-alt"></i> ${s.propiedadDireccion}</small>

                            <div class="p-3 bg-light rounded-3 mb-3">
                                <div class="fw-bold text-dark mb-1"><i class="bi bi-person me-1"></i> Cliente: ${s.clienteNombreCompleto}</div>
                                <div class="small text-muted"><i class="bi bi-envelope me-1"></i> ${s.clienteCorreo} &bull; <i class="bi bi-telephone me-1"></i> ${s.clienteTelefono}</div>
                                <c:if test="${not empty s.comentarios}">
                                    <div class="small text-secondary mt-2 pt-2 border-top">
                                        <strong>Comentarios:</strong> "${s.comentarios}"
                                    </div>
                                </c:if>
                            </div>

                            <div class="mb-3">
                                <div class="small fw-bold text-muted mb-2"><i class="bi bi-paperclip"></i> Soportes Adjuntos:</div>
                                <div class="d-flex flex-wrap gap-2">
                                    <c:forEach var="doc" items="${s.documentos}">
                                        <span class="badge bg-white text-dark border p-2 shadow-xs">
                                            <i class="bi bi-file-earmark-pdf-fill text-danger me-1"></i>
                                            ${doc.nombreArchivo} (${doc.tipoDocumento})
                                        </span>
                                    </c:forEach>
                                    <c:if test="${empty s.documentos}">
                                        <span class="small text-muted fst-italic">Sin documentos</span>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <div class="pt-3 border-top d-flex gap-2">
                            <form action="${pageContext.request.contextPath}/inmobiliaria/solicitud-estado" method="POST" class="flex-grow-1">
                                <input type="hidden" name="idSolicitud" value="${s.idSolicitud}">
                                <input type="hidden" name="nuevoEstado" value="en_revision">
                                <button type="submit" class="btn btn-sm btn-outline-info w-100" ${s.estado == 'en_revision' ? 'disabled' : ''}>
                                    <i class="bi bi-hourglass-split"></i> En Revisión
                                </button>
                            </form>
                            <form action="${pageContext.request.contextPath}/inmobiliaria/solicitud-estado" method="POST" class="flex-grow-1">
                                <input type="hidden" name="idSolicitud" value="${s.idSolicitud}">
                                <input type="hidden" name="nuevoEstado" value="aprobada">
                                <button type="submit" class="btn btn-sm btn-success w-100" ${s.estado == 'aprobada' ? 'disabled' : ''}>
                                    <i class="bi bi-check-lg"></i> Aprobar
                                </button>
                            </form>
                            <form action="${pageContext.request.contextPath}/inmobiliaria/solicitud-estado" method="POST" class="flex-grow-1">
                                <input type="hidden" name="idSolicitud" value="${s.idSolicitud}">
                                <input type="hidden" name="nuevoEstado" value="rechazada">
                                <button type="submit" class="btn btn-sm btn-outline-danger w-100" ${s.estado == 'rechazada' ? 'disabled' : ''}>
                                    <i class="bi bi-x-lg"></i> Rechazar
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty solicitudes}">
                <div class="col-12">
                    <div class="bg-white p-5 rounded-4 text-center border border-light shadow-sm">
                        <i class="bi bi-folder-check text-muted mb-3" style="font-size: 3.5rem;"></i>
                        <h4 class="fw-bold text-primary">No hay solicitudes por tramitar</h4>
                        <p class="text-muted mb-0">Todas las radicaciones de tus inmuebles están al día.</p>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/components/footer.jsp"/>
