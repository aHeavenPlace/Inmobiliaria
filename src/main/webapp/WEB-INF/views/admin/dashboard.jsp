<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/components/header.jsp">
    <jsp:param name="pageTitle" value="Panel Administrador | Inmobiliaria Sora"/>
</jsp:include>

<div class="dashboard-wrapper">
    <jsp:include page="/WEB-INF/views/components/sidebar_admin.jsp"/>

    <div class="dashboard-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold text-primary mb-1">Panel de Administración Global</h2>
                <p class="text-muted mb-0">Vista consolidada del sistema inmobiliario: usuarios, propiedades, actividad y auditoría</p>
            </div>
            <span class="badge bg-danger text-white px-3 py-2 rounded-pill fs-6">
                <i class="bi bi-shield-fill-exclamation me-1"></i> Acceso Super Administrador
            </span>
        </div>

        <!-- KPIs Globales del Sistema -->
        <div class="row g-4 mb-4">
            <div class="col-md-3">
                <div class="stat-card">
                    <div>
                        <span class="text-muted text-uppercase fw-bold small">Total Usuarios</span>
                        <div class="stat-number">${metricas.totalUsuarios != null ? metricas.totalUsuarios : 0}</div>
                        <small class="text-muted">Registrados en la plataforma</small>
                    </div>
                    <div class="stat-icon-wrap stat-icon-blue">
                        <i class="bi bi-people-fill"></i>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="stat-card">
                    <div>
                        <span class="text-muted text-uppercase fw-bold small">Propiedades</span>
                        <div class="stat-number">${metricas.totalPropiedades != null ? metricas.totalPropiedades : 0}</div>
                        <small class="text-success"><i class="bi bi-check-circle"></i> En catálogo</small>
                    </div>
                    <div class="stat-icon-wrap stat-icon-green">
                        <i class="bi bi-houses-fill"></i>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="stat-card">
                    <div>
                        <span class="text-muted text-uppercase fw-bold small">Citas Agendadas</span>
                        <div class="stat-number">${metricas.totalCitas != null ? metricas.totalCitas : 0}</div>
                        <small class="text-info">En el período</small>
                    </div>
                    <div class="stat-icon-wrap stat-icon-amber">
                        <i class="bi bi-calendar-event-fill"></i>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="stat-card">
                    <div>
                        <span class="text-muted text-uppercase fw-bold small">Solicitudes</span>
                        <div class="stat-number">${metricas.totalSolicitudes != null ? metricas.totalSolicitudes : 0}</div>
                        <small class="text-warning">Tramitadas en sistema</small>
                    </div>
                    <div class="stat-icon-wrap" style="background: rgba(220, 38, 38, 0.1); color: #DC2626;">
                        <i class="bi bi-file-earmark-check-fill"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <!-- Actividad de Auditoría Reciente -->
            <div class="col-lg-8">
                <div class="bg-white p-4 rounded-4 border border-light shadow-sm">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold text-primary mb-0"><i class="bi bi-journal-code me-2"></i> Auditoría Reciente del Sistema</h5>
                        <a href="${pageContext.request.contextPath}/admin/auditoria" class="small text-muted">Ver log completo</a>
                    </div>
                    <div class="d-flex flex-column gap-2">
                        <c:forEach var="log" items="${actividadReciente}">
                            <div class="d-flex align-items-center gap-3 p-3 rounded-3 bg-light border border-light">
                                <div class="text-center" style="min-width: 36px; height: 36px; display: flex; align-items: center; justify-content: center; border-radius: 50%; background: rgba(13, 148, 136, 0.12);">
                                    <i class="bi bi-activity text-primary"></i>
                                </div>
                                <div class="flex-grow-1">
                                    <div class="fw-semibold text-dark small">${log.accion} — <span class="text-muted">${log.tablaAfectada}</span></div>
                                    <small class="text-muted">
                                        <i class="bi bi-person me-1"></i> ${log.usuarioCorreo}
                                        &bull; <i class="bi bi-clock me-1"></i> ${log.fechaFormateada}
                                    </small>
                                </div>
                                <span class="badge bg-light text-dark border small">${log.tablaAfectada}</span>
                            </div>
                        </c:forEach>
                        <c:if test="${empty actividadReciente}">
                            <div class="text-center py-3 text-muted small">
                                <i class="bi bi-shield-check fs-3 d-block mb-2"></i>
                                No hay actividad registrada recientemente.
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Accesos Rápidos Admin -->
            <div class="col-lg-4">
                <div class="bg-white p-4 rounded-4 border border-light shadow-sm">
                    <h5 class="fw-bold text-primary mb-3"><i class="bi bi-grid-3x3-gap me-2"></i> Acciones Administrativas</h5>
                    <div class="d-grid gap-2">
                        <a href="${pageContext.request.contextPath}/admin/usuarios" class="btn btn-sora-outline justify-content-start">
                            <i class="bi bi-people me-2"></i> Gestionar Usuarios & Roles
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/catalogos" class="btn btn-sora-outline justify-content-start">
                            <i class="bi bi-sliders me-2"></i> Parametrización & Catálogos
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/auditoria" class="btn btn-sora-outline justify-content-start">
                            <i class="bi bi-journal-text me-2"></i> Log de Auditoría Completo
                        </a>
                        <a href="${pageContext.request.contextPath}/reportes/exportar-csv" class="btn btn-sora-primary justify-content-start">
                            <i class="bi bi-file-earmark-spreadsheet me-2"></i> Exportar Reporte CSV
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/components/footer.jsp"/>
