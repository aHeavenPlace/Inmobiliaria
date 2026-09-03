<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/components/header.jsp">
    <jsp:param name="pageTitle" value="Inmobiliaria Sora | Inmuebles Exclusivos en Colombia"/>
</jsp:include>

<!-- Hero Section -->
<section class="hero-section">
    <div class="container">
        <span class="badge bg-white text-dark px-3 py-2 rounded-pill fw-bold mb-3 shadow-sm">
            <i class="bi bi-stars text-warning me-1"></i> Experiencia Inmobiliaria de Alto Nivel
        </span>
        <h1 class="hero-title">Encuentra el hogar o espacio ideal<br>con total confianza y distinción</h1>
        <p class="hero-subtitle">
            Explora una cuidada selección de casas, apartamentos, locales y oficinas en las principales ciudades de Colombia.
        </p>
    </div>
</section>

<!-- Floating Search Card -->
<div class="container">
    <div class="search-card-float">
        <form action="${pageContext.request.contextPath}/catalogo" method="GET" class="row g-3 align-items-end">
            <div class="col-lg-3 col-md-6">
                <label class="form-label-sora"><i class="bi bi-geo-alt me-1 text-primary"></i> Ciudad</label>
                <select name="ciudad" class="form-select form-select-sora">
                    <option value="">Todas las ciudades</option>
                    <c:forEach var="c" items="${ciudades}">
                        <option value="${c.idCiudad}">${c.nombre} (${c.departamento})</option>
                    </c:forEach>
                </select>
            </div>

            <div class="col-lg-3 col-md-6">
                <label class="form-label-sora"><i class="bi bi-building me-1 text-primary"></i> Tipo de Inmueble</label>
                <select name="tipo" class="form-select form-select-sora">
                    <option value="">Todos los tipos</option>
                    <c:forEach var="t" items="${tiposPropiedad}">
                        <option value="${t.idTipo}">${t.nombre}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="col-lg-2 col-md-6">
                <label class="form-label-sora"><i class="bi bi-arrow-left-right me-1 text-primary"></i> Operación</label>
                <select name="operacion" class="form-select form-select-sora">
                    <option value="todos">Venta y Arriendo</option>
                    <option value="venta">Venta</option>
                    <option value="arriendo">Arriendo</option>
                </select>
            </div>

            <div class="col-lg-2 col-md-6">
                <label class="form-label-sora"><i class="bi bi-cash me-1 text-primary"></i> Precio Máx ($)</label>
                <input type="number" name="precio" class="form-control form-control-sora" placeholder="Ej: 500000000" step="10000000">
            </div>

            <div class="col-lg-2 col-md-12">
                <button type="submit" class="btn btn-sora-accent w-100 py-3 justify-content-center">
                    <i class="bi bi-search"></i> Buscar
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Propiedades Destacadas -->
<section class="py-5 mt-4">
    <div class="container">
        <div class="d-flex justify-content-between align-items-end mb-4">
            <div>
                <span class="text-uppercase fw-bold text-muted small letter-spacing-1">Portafolio Selecto</span>
                <h2 class="fw-bold text-primary mb-0">Propiedades Destacadas</h2>
            </div>
            <a href="${pageContext.request.contextPath}/catalogo" class="btn btn-sora-outline d-none d-md-inline-flex">
                Ver Todo el Catálogo <i class="bi bi-arrow-right"></i>
            </a>
        </div>

        <div class="row g-4">
            <c:forEach var="p" items="${propiedadesDestacadas}">
                <div class="col-lg-4 col-md-6">
                    <div class="property-card">
                        <div class="property-thumb-wrap">
                            <img src="${p.imagenPrincipal}" alt="${p.titulo}" class="property-thumb" loading="lazy">
                            <span class="badge-operation">${p.tipoOperacion}</span>
                            <span class="badge-type">${p.tipoNombre}</span>
                            <button class="btn-favorite-heart ${p.esFavorito ? 'is-favorite' : ''}" 
                                    data-id="${p.idPropiedad}" 
                                    data-context="${pageContext.request.contextPath}"
                                    title="Guardar en favoritos">
                                <i class="bi ${p.esFavorito ? 'bi-heart-fill' : 'bi-heart'}"></i>
                            </button>
                        </div>
                        <div class="property-body">
                            <div class="property-price">${p.precioFormateado}</div>
                            <h3 class="property-title">
                                <a href="${pageContext.request.contextPath}/propiedad?id=${p.idPropiedad}">${p.titulo}</a>
                            </h3>
                            <div class="property-location">
                                <i class="bi bi-geo-alt-fill text-danger"></i>
                                <span>${p.direccion}, ${p.ciudadNombre}</span>
                            </div>

                            <div class="property-features">
                                <div class="feature-item" title="Habitaciones">
                                    <i class="bi bi-door-open"></i>
                                    <span>${p.habitaciones} habs</span>
                                </div>
                                <div class="feature-item" title="Baños">
                                    <i class="bi bi-droplet"></i>
                                    <span>${p.banos} baños</span>
                                </div>
                                <div class="feature-item" title="Área construida">
                                    <i class="bi bi-aspect-ratio"></i>
                                    <span>${p.areaM2} m²</span>
                                </div>
                            </div>

                            <div class="pt-3 mt-2 d-flex justify-content-between align-items-center">
                                <small class="text-muted"><i class="bi bi-building"></i> ${p.inmobiliariaNombre}</small>
                                <a href="${pageContext.request.contextPath}/propiedad?id=${p.idPropiedad}" class="btn btn-sm btn-sora-outline">
                                    Ver Detalle
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="text-center mt-5 d-md-none">
            <a href="${pageContext.request.contextPath}/catalogo" class="btn btn-sora-outline w-100">
                Ver Todo el Catálogo <i class="bi bi-arrow-right ms-1"></i>
            </a>
        </div>
    </div>
</section>

<!-- Sección de Servicios y Valor Agregado -->
<section class="py-5 bg-white border-top border-bottom border-light">
    <div class="container py-4">
        <div class="text-center mb-5">
            <span class="text-uppercase fw-bold text-muted small">Nuestros Servicios</span>
            <h2 class="fw-bold text-primary">¿Por qué confiar en Inmobiliaria Sora?</h2>
            <p class="text-muted max-w-lg mx-auto" style="max-width: 600px;">
                Combinamos asesoría legal rigurosa, tecnología ágil de agendamiento y la mayor visibilidad en el mercado nacional.
            </p>
        </div>

        <div class="row g-4">
            <div class="col-lg-4 col-md-6">
                <div class="p-4 rounded-4 bg-light border border-light h-100">
                    <div class="stat-icon-wrap stat-icon-blue mb-3">
                        <i class="bi bi-shield-check"></i>
                    </div>
                    <h5 class="fw-bold text-primary">Seguridad Jurídica Total</h5>
                    <p class="text-muted mb-0">
                        Validación estricta de matrículas inmobiliarias, certificados de tradición y libertad y antecedentes para transacciones 100% transparentes.
                    </p>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="p-4 rounded-4 bg-light border border-light h-100">
                    <div class="stat-icon-wrap stat-icon-green mb-3">
                        <i class="bi bi-calendar2-check"></i>
                    </div>
                    <h5 class="fw-bold text-primary">Agendamiento Inmediato</h5>
                    <p class="text-muted mb-0">
                        Programa visitas presenciales en tiempo real con agentes certificados, recibiendo confirmación y seguimiento desde tu panel personal.
                    </p>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="p-4 rounded-4 bg-light border border-light h-100">
                    <div class="stat-icon-wrap stat-icon-amber mb-3">
                        <i class="bi bi-file-earmark-lock"></i>
                    </div>
                    <h5 class="fw-bold text-primary">Radicación Digital de Documentos</h5>
                    <p class="text-muted mb-0">
                        Presenta solicitudes de arriendo o compraventa cargando tus documentos en formato digital con cifrado y seguimiento en timeline interactivo.
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Testimonios -->
<section class="py-5">
    <div class="container py-4">
        <div class="text-center mb-5">
            <span class="text-uppercase fw-bold text-muted small">Experiencias Reales</span>
            <h2 class="fw-bold text-primary">Lo que opinan nuestros clientes</h2>
        </div>

        <div class="row g-4">
            <div class="col-lg-4 col-md-6">
                <div class="p-4 rounded-4 bg-white border border-light shadow-sm h-100 d-flex flex-column">
                    <div class="text-warning mb-3">
                        <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                    </div>
                    <p class="text-muted fst-italic flex-grow-1">
                        "El proceso de arrendar mi apartamento en Cabecera fue impecable. Pude radicar mis documentos en línea y en 48 horas ya tenía la aprobación."
                    </p>
                    <div class="d-flex align-items-center gap-3 pt-3 border-top border-light">
                        <img src="https://i.pravatar.cc/150?u=juan" alt="Juan Pérez" class="rounded-circle" width="44" height="44">
                        <div>
                            <h6 class="fw-bold mb-0">Juan Pérez</h6>
                            <small class="text-muted">Comprador en Bucaramanga</small>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="p-4 rounded-4 bg-white border border-light shadow-sm h-100 d-flex flex-column">
                    <div class="text-warning mb-3">
                        <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                    </div>
                    <p class="text-muted fst-italic flex-grow-1">
                        "Excelente plataforma. La galería fotográfica es fiel a la realidad y el agente respondió todas nuestras inquietudes en la visita."
                    </p>
                    <div class="d-flex align-items-center gap-3 pt-3 border-top border-light">
                        <img src="https://i.pravatar.cc/150?u=ana" alt="Ana López" class="rounded-circle" width="44" height="44">
                        <div>
                            <h6 class="fw-bold mb-0">Ana López</h6>
                            <small class="text-muted">Inversionista en Floridablanca</small>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="p-4 rounded-4 bg-white border border-light shadow-sm h-100 d-flex flex-column">
                    <div class="text-warning mb-3">
                        <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                    </div>
                    <p class="text-muted fst-italic flex-grow-1">
                        "Como inmobiliaria aliada, la gestión de inmuebles, citas y solicitudes recibidas ha multiplicado la productividad de nuestro equipo."
                    </p>
                    <div class="d-flex align-items-center gap-3 pt-3 border-top border-light">
                        <img src="https://i.pravatar.cc/150?u=carlos" alt="Carlos Ramírez" class="rounded-circle" width="44" height="44">
                        <div>
                            <h6 class="fw-bold mb-0">Carlos Ramírez</h6>
                            <small class="text-muted">Agente Inmobiliario</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="/WEB-INF/views/components/footer.jsp"/>
