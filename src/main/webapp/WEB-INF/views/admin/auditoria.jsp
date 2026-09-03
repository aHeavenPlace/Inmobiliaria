<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/components/header.jsp">
    <jsp:param name="pageTitle" value="Log de Auditoría | Inmobiliaria Sora"/>
</jsp:include>

<div class="dashboard-wrapper">
    <jsp:include page="/WEB-INF/views/components/sidebar_admin.jsp"/>

    <div class="dashboard-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold text-primary mb-1">Log de Auditoría del Sistema</h2>
                <p class="text-muted mb-0">Trazabilidad completa de operaciones CRUD, accesos y cambios de estado</p>
            </div>
        </div>

        <!-- Filtros de Búsqueda -->
        <form action="${pageContext.request.contextPath}/admin/auditoria" method="GET" class="bg-white p-3 rounded-4 border border-light shadow-sm mb-4">
            <div class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label-sora">Tabla Afectada</label>
                    <select name="tabla" class="form-select form-select-sora">
                        <option value="">Todas las tablas</option>
                        <option value="usuario" ${filtroTabla == 'usuario' ? 'selected' : ''}>usuario</option>
                        <option value="propiedad" ${filtroTabla == 'propiedad' ? 'selected' : ''}>propiedad</option>
                        <option value="cita" ${filtroTabla == 'cita' ? 'selected' : ''}>cita</option>
                        <option value="solicitud" ${filtroTabla == 'solicitud' ? 'selected' : ''}>solicitud</option>
                        <option value="favorito" ${filtroTabla == 'favorito' ? 'selected' : ''}>favorito</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label-sora">Acción / Operación</label>
                    <select name="accion" class="form-select form-select-sora">
                        <option value="">Todas las acciones</option>
                        <option value="INSERT" ${filtroAccion == 'INSERT' ? 'selected' : ''}>INSERT</option>
                        <option value="UPDATE" ${filtroAccion == 'UPDATE' ? 'selected' : ''}>UPDATE</option>
                        <option value="DELETE" ${filtroAccion == 'DELETE' ? 'selected' : ''}>DELETE</option>
                        <option value="LOGIN" ${filtroAccion == 'LOGIN' ? 'selected' : ''}>LOGIN</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <button type="submit" class="btn btn-sora-primary w-100">
                        <i class="bi bi-filter"></i> Filtrar Registros
                    </button>
                </div>
            </div>
        </form>

        <div class="bg-white rounded-4 border border-light shadow-sm overflow-hidden">
            <div class="table-responsive">
                <table class="table-sora">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Usuario</th>
                            <th>Acción / Operación</th>
                            <th>Tabla Afectada</th>
                            <th>ID Registro</th>
                            <th>Descripción</th>
                            <th>Fecha & Hora</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="log" items="${auditoria}" varStatus="status">
                            <tr>
                                <td class="text-muted small">${log.idAuditoria}</td>
                                <td>
                                    <div class="fw-bold small">${log.usuarioCorreo}</div>
                                    <small class="text-muted">IP: ${log.ip}</small>
                                </td>
                                <td>
                                    <span class="badge ${log.accion == 'INSERT' ? 'bg-success' : log.accion == 'UPDATE' ? 'bg-warning text-dark' : log.accion == 'DELETE' ? 'bg-danger' : 'bg-info text-dark'} px-2">
                                        ${log.accion}
                                    </span>
                                </td>
                                <td>
                                    <code class="small bg-light px-2 py-1 rounded">${log.tablaAfectada}</code>
                                </td>
                                <td class="text-muted small">${log.idRegistroAfectado}</td>
                                <td>
                                    <small class="text-muted" title="${log.descripcion}">
                                        ${log.descripcion.length() > 60 ? log.descripcion.substring(0, 60).concat('...') : log.descripcion}
                                    </small>
                                </td>
                                <td>
                                    <small class="fw-semibold">${log.fechaFormateada}</small>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty auditoria}">
                            <tr>
                                <td colspan="7" class="text-center py-5 text-muted">
                                    <i class="bi bi-shield-check fs-2 d-block mb-2"></i>
                                    Sin registros de auditoría con los filtros aplicados.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/components/footer.jsp"/>
