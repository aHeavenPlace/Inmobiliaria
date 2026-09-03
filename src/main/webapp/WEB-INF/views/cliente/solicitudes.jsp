<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/components/header.jsp">
    <jsp:param name="pageTitle" value="Mis Solicitudes | Inmobiliaria Sora"/>
</jsp:include>

<div class="dashboard-wrapper">
    <jsp:include page="/WEB-INF/views/components/sidebar_cliente.jsp"/>

    <div class="dashboard-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold text-primary mb-1">Mis Solicitudes de Trámite</h2>
                <p class="text-muted mb-0">Seguimiento de compras y arrendamientos radicados</p>
            </div>
            <a href="${pageContext.request.contextPath}/catalogo" class="btn btn-sora-accent">
                <i class="bi bi-file-earmark-plus"></i> Nueva Solicitud
            </a>
        </div>

        <c:if test="${param.msg == 'solicitud_radicada'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> Solicitud radicada exitosamente con documentación adjunta.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="row g-4">
            <c:forEach var="s" items="${solicitudes}">
                <div class="col-lg-6">
                    <div class="bg-white p-4 rounded-4 border border-light shadow-sm h-100">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div>
                                <span class="badge bg-primary text-uppercase px-2 py-1 mb-2">${s.tipo}</span>
                                <h5 class="fw-bold text-primary mb-1">${s.propiedadTitulo}</h5>
                                <small class="text-muted"><i class="bi bi-building"></i> ${s.inmobiliariaNombre}</small>
                            </div>
                            <span class="badge-sora ${s.estado == 'aprobada' ? 'badge-sora-success' : s.estado == 'en_revision' ? 'badge-sora-info' : s.estado == 'pendiente' ? 'badge-sora-warning' : 'badge-sora-danger'}">
                                ${s.estado}
                            </span>
                        </div>

                        <!-- Timeline visual de estado -->
                        <div class="timeline-sora my-3">
                            <div class="timeline-step active">
                                <div class="timeline-dot"></div>
                                <div class="fw-semibold small">Radicación Recibida</div>
                                <small class="text-muted">${s.fechaSolicitudFormateada}</small>
                            </div>
                            <div class="timeline-step ${s.estado == 'en_revision' || s.estado == 'aprobada' || s.estado == 'rechazada' ? 'active' : ''}">
                                <div class="timeline-dot"></div>
                                <div class="fw-semibold small">Revisión de Documentación</div>
                                <small class="text-muted">Estudio financiero y garantías</small>
                            </div>
                            <div class="timeline-step ${s.estado == 'aprobada' || s.estado == 'rechazada' ? 'active' : ''}">
                                <div class="timeline-dot" style="${s.estado == 'rechazada' ? 'background: var(--status-danger);' : ''}"></div>
                                <div class="fw-semibold small">Decisión Final: <span class="text-capitalize">${s.estado}</span></div>
                            </div>
                        </div>

                        <!-- Documentos Adjuntos -->
                        <div class="pt-3 border-top">
                            <div class="small fw-bold text-muted mb-2"><i class="bi bi-paperclip"></i> Documentos Cargados:</div>
                            <div class="d-flex flex-wrap gap-2">
                                <c:forEach var="doc" items="${s.documentos}">
                                    <span class="badge bg-light text-dark border p-2">
                                        <i class="bi bi-file-earmark-pdf text-danger me-1"></i> ${doc.nombreArchivo}
                                    </span>
                                </c:forEach>
                                <c:if test="${empty s.documentos}">
                                    <small class="text-muted fst-italic">Sin documentos adicionales adjuntos</small>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty solicitudes}">
                <div class="col-12">
                    <div class="bg-white p-5 rounded-4 text-center border border-light shadow-sm">
                        <i class="bi bi-file-earmark-text text-muted mb-3" style="font-size: 3.5rem;"></i>
                        <h4 class="fw-bold text-primary">No tienes solicitudes en curso</h4>
                        <p class="text-muted max-w-md mx-auto mb-4" style="max-width: 450px;">
                            Cuando encuentres una propiedad de tu interés en nuestro catálogo, podrás radicar tu solicitud de compra o arrendamiento con un clic.
                        </p>
                        <a href="${pageContext.request.contextPath}/catalogo" class="btn btn-sora-accent">
                            Buscar Inmuebles
                        </a>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/components/footer.jsp"/>
