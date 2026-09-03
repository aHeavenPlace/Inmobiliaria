<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/components/header.jsp">
    <jsp:param name="pageTitle" value="Mis Citas Agendadas | Inmobiliaria Sora"/>
</jsp:include>

<div class="dashboard-wrapper">
    <jsp:include page="/WEB-INF/views/components/sidebar_cliente.jsp"/>

    <div class="dashboard-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold text-primary mb-1">Mis Visitas Programadas</h2>
                <p class="text-muted mb-0">Historial y estado de tus citas con agentes inmobiliarios</p>
            </div>
            <a href="${pageContext.request.contextPath}/catalogo" class="btn btn-sora-accent">
                <i class="bi bi-plus-circle"></i> Agendar Nueva Visita
            </a>
        </div>

        <c:if test="${param.msg == 'cita_agendada'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> ¡Cita agendada con éxito! El agente inmobiliario se comunicará para confirmar.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="table-responsive">
            <table class="table-sora">
                <thead>
                    <tr>
                        <th>Propiedad</th>
                        <th>Inmobiliaria</th>
                        <th>Fecha & Hora</th>
                        <th>Estado</th>
                        <th>Notas</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="c" items="${citas}">
                        <tr>
                            <td>
                                <strong class="text-primary d-block">${c.propiedadTitulo}</strong>
                                <small class="text-muted"><i class="bi bi-geo-alt"></i> ${c.propiedadDireccion}</small>
                            </td>
                            <td>
                                <span class="badge bg-light text-dark border">
                                    <i class="bi bi-building me-1"></i> ${c.inmobiliariaNombre}
                                </span>
                            </td>
                            <td>
                                <div class="fw-semibold"><i class="bi bi-calendar-event text-primary me-1"></i> ${c.fechaHoraFormateada}</div>
                            </td>
                            <td>
                                <span class="badge-sora ${c.estado == 'confirmada' ? 'badge-sora-success' : c.estado == 'pendiente' ? 'badge-sora-warning' : c.estado == 'cancelada' ? 'badge-sora-danger' : 'badge-sora-info'}">
                                    ${c.estado}
                                </span>
                            </td>
                            <td>
                                <small class="text-muted">${not empty c.notas ? c.notas : 'Sin notas'}</small>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/propiedad?id=${c.idPropiedad}" class="btn btn-sm btn-sora-outline">
                                    Ver Ficha
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty citas}">
                        <tr>
                            <td colspan="6" class="text-center py-5 text-muted">
                                <i class="bi bi-calendar-x fs-2 d-block mb-2"></i>
                                No tienes citas agendadas actualmente.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/components/footer.jsp"/>
