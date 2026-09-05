<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/components/header.jsp">
    <jsp:param name="pageTitle" value="${propiedad.titulo} | Inmobiliaria Vesta"/>
</jsp:include>

<div class="container py-4">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-3">
        <ol class="breadcrumb small">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Inicio</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/catalogo">Catálogo</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/catalogo?ciudad=${propiedad.idCiudad}">${propiedad.ciudadNombre}</a></li>
            <li class="breadcrumb-item active" aria-current="page">${propiedad.titulo}</li>
        </ol>
    </nav>

    <!-- Header de la Propiedad -->
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
        <div>
            <div class="d-flex align-items-center gap-2 mb-2">
                <span class="badge bg-primary px-3 py-1 text-uppercase">${propiedad.tipoOperacion}</span>
                <span class="badge bg-info text-dark px-3 py-1">${propiedad.tipoNombre}</span>
                <span class="badge ${propiedad.estado == 'disponible' ? 'bg-success' : 'bg-secondary'} px-3 py-1 text-capitalize">
                    ${propiedad.estado}
                </span>
                <span class="text-muted small">Matrícula: <strong>${propiedad.matriculaInmobiliaria}</strong></span>
            </div>
            <h1 class="h2 fw-bold text-primary mb-1">${propiedad.titulo}</h1>
            <p class="text-muted mb-0">
                <i class="bi bi-geo-alt-fill text-danger me-1"></i> ${propiedad.direccion}, ${propiedad.ciudadNombre} (${propiedad.departamentoNombre})
            </p>
        </div>

        <div class="text-md-end">
            <div class="fs-2 fw-bold text-primary">${propiedad.precioFormateado}</div>
            <div class="d-flex gap-2 justify-content-md-end mt-2">
                <button class="btn btn-outline-danger btn-sm btn-favorite-heart ${propiedad.esFavorito ? 'is-favorite' : ''}"
                        data-id="${propiedad.idPropiedad}"
                        data-context="${pageContext.request.contextPath}"
                        style="position: static; width: auto; height: auto; padding: 6px 14px; border-radius: var(--radius-md);">
                    <i class="bi ${propiedad.esFavorito ? 'bi-heart-fill' : 'bi-heart'} me-1"></i>
                    <span>${propiedad.esFavorito ? 'En Favoritos' : 'Guardar'}</span>
                </button>
            </div>
        </div>
    </div>

    <!-- Galería de Imágenes -->
    <div class="row g-3 mb-4">
        <div class="col-lg-8">
            <div class="rounded-4 overflow-hidden shadow-sm" style="height: 460px; background-color: #E2E8F0;">
                <img id="mainPropertyImg" src="${propiedad.imagenPrincipal}" alt="${propiedad.titulo}" 
                     class="w-100 h-100" style="object-fit: cover;">
            </div>
        </div>
        <div class="col-lg-4">
            <div class="d-flex flex-column gap-3 h-100 justify-content-between">
                <c:forEach var="img" items="${propiedad.imagenes}" varStatus="status">
                    <c:if test="${status.index < 3}">
                        <div class="rounded-3 overflow-hidden shadow-sm flex-grow-1" style="max-height: 140px; cursor: pointer;"
                             onclick="document.getElementById('mainPropertyImg').src='${img.url}';">
                            <img src="${img.url}" alt="${img.descripcion}" class="w-100 h-100" style="object-fit: cover;">
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </div>

    <div class="row g-4">
        <!-- Detalles y Características -->
        <div class="col-lg-8">
            <!-- Métricas Clave -->
            <div class="bg-white p-4 rounded-4 border border-light shadow-sm mb-4">
                <div class="row text-center g-3">
                    <div class="col-4 border-end">
                        <i class="bi bi-aspect-ratio text-primary fs-3"></i>
                        <div class="fw-bold fs-5 mt-1">${propiedad.areaM2} m²</div>
                        <small class="text-muted text-uppercase">Área Privada</small>
                    </div>
                    <div class="col-4 border-end">
                        <i class="bi bi-door-open text-primary fs-3"></i>
                        <div class="fw-bold fs-5 mt-1">${propiedad.habitaciones}</div>
                        <small class="text-muted text-uppercase">Habitaciones</small>
                    </div>
                    <div class="col-4">
                        <i class="bi bi-droplet text-primary fs-3"></i>
                        <div class="fw-bold fs-5 mt-1">${propiedad.banos}</div>
                        <small class="text-muted text-uppercase">Baños</small>
                    </div>
                </div>
            </div>

            <!-- Descripción -->
            <div class="bg-white p-4 rounded-4 border border-light shadow-sm mb-4">
                <h4 class="fw-bold text-primary mb-3">Descripción General</h4>
                <p class="text-muted leading-relaxed" style="white-space: pre-line;">${propiedad.descripcion}</p>
            </div>

            <!-- Características / Amenidades (Relación N:M) -->
            <div class="bg-white p-4 rounded-4 border border-light shadow-sm mb-4">
                <h4 class="fw-bold text-primary mb-3"><i class="bi bi-stars text-warning me-2"></i> Características & Amenidades</h4>
                <div class="row g-3">
                    <c:forEach var="carac" items="${propiedad.caracteristicas}">
                        <div class="col-md-6 col-lg-4">
                            <div class="d-flex align-items-center gap-2 p-2 rounded-3 bg-light">
                                <i class="bi bi-check-circle-fill text-success fs-5"></i>
                                <span class="fw-semibold small">${carac.nombre}</span>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty propiedad.caracteristicas}">
                        <p class="text-muted small">No se han especificado características adicionales.</p>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Sidebar de Contacto y Agendamiento -->
        <div class="col-lg-4">
            <div class="bg-white p-4 rounded-4 border border-light shadow-sm sticky-top" style="top: 100px;">
                <div class="text-center pb-3 border-bottom mb-3">
                    <h5 class="fw-bold text-primary mb-1">Inmobiliaria Anunciante</h5>
                    <div class="badge bg-light text-dark px-3 py-1 mb-2">
                        <i class="bi bi-building me-1"></i> ${propiedad.inmobiliariaNombre}
                    </div>
                    <p class="small text-muted mb-0"><i class="bi bi-telephone"></i> ${propiedad.inmobiliariaTelefono}</p>
                </div>

                <div class="d-grid gap-2 mb-3">
                    <button class="btn btn-vesta-accent py-3 fw-bold" data-bs-toggle="modal" data-bs-target="#modalAgendarCita">
                        <i class="bi bi-calendar-check me-2"></i> Agendar Visita
                    </button>
                    <button class="btn btn-vesta-primary py-3 fw-bold" data-bs-toggle="modal" data-bs-target="#modalRadicarSolicitud">
                        <i class="bi bi-file-earmark-arrow-up me-2"></i> Radicar Solicitud
                    </button>
                </div>

                <div class="alert alert-light border small text-muted mb-0">
                    <i class="bi bi-shield-lock-fill text-success me-1"></i> Transacción respaldada y verificada bajo los estándares de Inmobiliaria Vesta.
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal Agendar Cita -->
<div class="modal fade" id="modalAgendarCita" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 border-0 shadow-lg">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold text-primary"><i class="bi bi-calendar-event me-2"></i> Agendar Visita al Inmueble</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/cliente/agendar-cita" method="POST">
                <input type="hidden" name="idPropiedad" value="${propiedad.idPropiedad}">
                <div class="modal-body py-4">
                    <c:choose>
                        <c:when test="${empty sessionScope.usuarioLogueado}">
                            <div class="alert alert-warning">
                                <i class="bi bi-exclamation-triangle-fill me-1"></i> Debes <a href="${pageContext.request.contextPath}/login" class="fw-bold text-dark text-decoration-underline">iniciar sesión como Cliente</a> para agendar una visita.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="mb-3">
                                <label class="form-label-vesta">Fecha y Hora Preferida</label>
                                <input type="datetime-local" name="fechaHora" class="form-control form-control-vesta" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label-vesta">Notas / Preguntas para el Asesor</label>
                                <textarea name="notas" rows="3" class="form-control form-control-vesta" placeholder="Indica detalles adicionales de tu disponibilidad..."></textarea>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="modal-footer border-0 pt-0">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancelar</button>
                    <c:if test="${not empty sessionScope.usuarioLogueado}">
                        <button type="submit" class="btn btn-vesta-accent">Confirmar Agendamiento</button>
                    </c:if>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal Radicar Solicitud -->
<div class="modal fade" id="modalRadicarSolicitud" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 border-0 shadow-lg">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold text-primary"><i class="bi bi-file-earmark-text me-2"></i> Radicar Solicitud</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/cliente/radicar-solicitud" method="POST">
                <input type="hidden" name="idPropiedad" value="${propiedad.idPropiedad}">
                <div class="modal-body py-4">
                    <c:choose>
                        <c:when test="${empty sessionScope.usuarioLogueado}">
                            <div class="alert alert-warning">
                                <i class="bi bi-exclamation-triangle-fill me-1"></i> Debes <a href="${pageContext.request.contextPath}/login" class="fw-bold text-dark text-decoration-underline">iniciar sesión como Cliente</a> para radicar una solicitud.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="mb-3">
                                <label class="form-label-vesta">Tipo de Operación</label>
                                <select name="tipo" class="form-select form-select-vesta" required>
                                    <option value="compra" ${propiedad.tipoOperacion == 'venta' ? 'selected' : ''}>Solicitud de Compra</option>
                                    <option value="arriendo" ${propiedad.tipoOperacion == 'arriendo' ? 'selected' : ''}>Solicitud de Arrendamiento</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label-vesta">Documento de Soporte (Nombre de Archivo PDF/Doc)</label>
                                <input type="text" name="nombreDocumento" class="form-control form-control-vesta" placeholder="Ej: cedula_cliente.pdf" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label-vesta">Comentarios / Observaciones</label>
                                <textarea name="comentarios" rows="3" class="form-control form-control-vesta" placeholder="Escribe tu propuesta o información relevante para la inmobiliaria..."></textarea>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="modal-footer border-0 pt-0">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cerrar</button>
                    <c:if test="${not empty sessionScope.usuarioLogueado}">
                        <button type="submit" class="btn btn-vesta-primary">Enviar Solicitud</button>
                    </c:if>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/components/footer.jsp"/>
