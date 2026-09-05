<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/components/header.jsp">
    <jsp:param name="pageTitle" value="Parametrización | Inmobiliaria Vesta"/>
</jsp:include>

<div class="dashboard-wrapper">
    <jsp:include page="/WEB-INF/views/components/sidebar_admin.jsp"/>

    <div class="dashboard-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold text-primary mb-1">Parametrización & Catálogos del Sistema</h2>
                <p class="text-muted mb-0">Administra los datos maestros: ciudades, tipos de inmueble, características y roles</p>
            </div>
        </div>

        <c:if test="${param.msg == 'guardado'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill me-1"></i> Registro guardado exitosamente en el catálogo.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="row g-4">
            <!-- Catálogo: Ciudades -->
            <div class="col-lg-6">
                <div class="bg-white p-4 rounded-4 border border-light shadow-sm h-100">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold text-primary mb-0"><i class="bi bi-geo-alt me-2"></i> Ciudades</h5>
                        <span class="badge bg-light text-dark border">${ciudades.size()} registros</span>
                    </div>

                    <form action="${pageContext.request.contextPath}/admin/catalogos/ciudad" method="POST" class="d-flex gap-2 mb-3">
                        <input type="text" name="nombre" class="form-control form-control-vesta" placeholder="Nombre de ciudad" required>
                        <input type="text" name="departamento" class="form-control form-control-vesta" placeholder="Departamento" required>
                        <button type="submit" class="btn btn-vesta-accent flex-shrink-0"><i class="bi bi-plus-lg"></i></button>
                    </form>

                    <div class="catalog-list" style="max-height: 280px; overflow-y: auto;">
                        <c:forEach var="c" items="${ciudades}">
                            <div class="d-flex justify-content-between align-items-center p-2 border-bottom">
                                <div>
                                    <span class="fw-semibold small">${c.nombre}</span>
                                    <span class="text-muted small ms-1">— ${c.departamento}</span>
                                </div>
                                <span class="badge bg-light text-muted border small">#${c.idCiudad}</span>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <!-- Catálogo: Tipos de Propiedad -->
            <div class="col-lg-6">
                <div class="bg-white p-4 rounded-4 border border-light shadow-sm h-100">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold text-primary mb-0"><i class="bi bi-house me-2"></i> Tipos de Inmueble</h5>
                        <span class="badge bg-light text-dark border">${tiposPropiedad.size()} registros</span>
                    </div>

                    <form action="${pageContext.request.contextPath}/admin/catalogos/tipo-propiedad" method="POST" class="d-flex gap-2 mb-3">
                        <input type="text" name="nombre" class="form-control form-control-vesta" placeholder="Tipo de inmueble (ej: Bodega)" required>
                        <button type="submit" class="btn btn-vesta-accent flex-shrink-0"><i class="bi bi-plus-lg"></i></button>
                    </form>

                    <div class="catalog-list" style="max-height: 280px; overflow-y: auto;">
                        <c:forEach var="t" items="${tiposPropiedad}">
                            <div class="d-flex justify-content-between align-items-center p-2 border-bottom">
                                <span class="fw-semibold small">${t.nombre}</span>
                                <span class="badge bg-light text-muted border small">#${t.idTipo}</span>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <!-- Catálogo: Características / Amenidades -->
            <div class="col-lg-6">
                <div class="bg-white p-4 rounded-4 border border-light shadow-sm h-100">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold text-primary mb-0"><i class="bi bi-stars me-2"></i> Características (Relación N:M)</h5>
                        <span class="badge bg-light text-dark border">${caracteristicas.size()} registros</span>
                    </div>

                    <form action="${pageContext.request.contextPath}/admin/catalogos/caracteristica" method="POST" class="d-flex gap-2 mb-3">
                        <input type="text" name="nombre" class="form-control form-control-vesta" placeholder="Ej: Jacuzzi, Gimnasio, Bodega..." required>
                        <button type="submit" class="btn btn-vesta-accent flex-shrink-0"><i class="bi bi-plus-lg"></i></button>
                    </form>

                    <div class="d-flex flex-wrap gap-2 mt-2" style="max-height: 220px; overflow-y: auto;">
                        <c:forEach var="carac" items="${caracteristicas}">
                            <span class="badge bg-light text-dark border p-2">
                                <i class="bi bi-check-circle-fill text-success me-1"></i> ${carac.nombre}
                            </span>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <!-- Roles del Sistema -->
            <div class="col-lg-6">
                <div class="bg-white p-4 rounded-4 border border-light shadow-sm h-100">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold text-primary mb-0"><i class="bi bi-shield me-2"></i> Roles del Sistema</h5>
                        <span class="badge bg-light text-dark border">${roles.size()} roles activos</span>
                    </div>

                    <div class="d-flex flex-column gap-2">
                        <c:forEach var="r" items="${roles}">
                            <div class="d-flex justify-content-between align-items-center p-3 rounded-3 bg-light border">
                                <div class="d-flex align-items-center gap-2">
                                    <i class="bi ${r.nombre == 'admin' ? 'bi-shield-fill-exclamation text-danger' : r.nombre == 'inmobiliaria' ? 'bi-building-fill text-info' : 'bi-person-fill text-success'}"></i>
                                    <span class="fw-bold text-capitalize">${r.nombre}</span>
                                </div>
                                <span class="badge ${r.nombre == 'admin' ? 'bg-danger' : r.nombre == 'inmobiliaria' ? 'bg-info text-dark' : 'bg-success'} px-2 py-1">
                                    Sistema
                                </span>
                            </div>
                        </c:forEach>
                        <small class="text-muted mt-2">
                            <i class="bi bi-info-circle me-1"></i> Los roles del sistema son fijos y no pueden eliminarse para mantener la integridad referencial.
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/components/footer.jsp"/>
