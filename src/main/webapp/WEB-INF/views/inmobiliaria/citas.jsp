<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/components/header.jsp">
    <jsp:param name="pageTitle" value="Gestión de Citas | Inmobiliaria Vesta"/>
</jsp:include>

<div class="dashboard-wrapper">
    <jsp:include page="/WEB-INF/views/components/sidebar_inmobiliaria.jsp"/>

    <div class="dashboard-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold text-primary mb-1">Citas y Visitas Recibidas</h2>
                <p class="text-muted mb-0">Atiende las solicitudes de visita de clientes interesados en tus propiedades</p>
            </div>
        </div>

        <c:if test="${param.msg == 'estado_actualizado'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> Estado de la cita actualizado correctamente.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="table-responsive">
            <table class="table-vesta">
                <thead>
                    <tr>
                        <th>Propiedad Solicitada</th>
                        <th>Cliente</th>
                        <th>Contacto</th>
                        <th>Fecha & Hora</th>
                        <th>Estado Actual</th>
                        <th>Acción Rápida</th>
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
                                <div class="fw-bold">${c.clienteNombreCompleto}</div>
                                <small class="text-muted">${c.clienteCorreo}</small>
                            </td>
                            <td>
                                <div><i class="bi bi-telephone text-primary me-1"></i> ${c.clienteTelefono}</div>
                            </td>
                            <td>
                                <div class="fw-semibold text-dark">${c.fechaHoraFormateada}</div>
                            </td>
                            <td>
                                <span class="badge-vesta ${c.estado == 'confirmada' ? 'badge-vesta-success' : c.estado == 'pendiente' ? 'badge-vesta-warning' : c.estado == 'cancelada' ? 'badge-vesta-danger' : 'badge-vesta-info'}">
                                    ${c.estado}
                                </span>
                            </td>
                            <td>
                                <div class="dropdown">
                                    <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                        Cambiar Estado
                                    </button>
                                    <ul class="dropdown-menu shadow border-0">
                                        <li>
                                            <form action="${pageContext.request.contextPath}/inmobiliaria/cita-estado" method="POST">
                                                <input type="hidden" name="idCita" value="${c.idCita}">
                                                <input type="hidden" name="nuevoEstado" value="confirmada">
                                                <button type="submit" class="dropdown-item text-success"><i class="bi bi-check-circle me-1"></i> Confirmar</button>
                                            </form>
                                        </li>
                                        <li>
                                            <form action="${pageContext.request.contextPath}/inmobiliaria/cita-estado" method="POST">
                                                <input type="hidden" name="idCita" value="${c.idCita}">
                                                <input type="hidden" name="nuevoEstado" value="realizada">
                                                <button type="submit" class="dropdown-item text-primary"><i class="bi bi-flag me-1"></i> Realizada</button>
                                            </form>
                                        </li>
                                        <li>
                                            <form action="${pageContext.request.contextPath}/inmobiliaria/cita-estado" method="POST">
                                                <input type="hidden" name="idCita" value="${c.idCita}">
                                                <input type="hidden" name="nuevoEstado" value="cancelada">
                                                <button type="submit" class="dropdown-item text-danger"><i class="bi bi-x-circle me-1"></i> Cancelar</button>
                                            </form>
                                        </li>
                                    </ul>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty citas}">
                        <tr>
                            <td colspan="6" class="text-center py-5 text-muted">
                                No se registran citas pendientes en este momento.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/components/footer.jsp"/>
