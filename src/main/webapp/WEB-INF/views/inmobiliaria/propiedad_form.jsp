<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/components/header.jsp">
    <jsp:param name="pageTitle" value="${not empty propiedad ? 'Editar Inmueble' : 'Publicar Nuevo Inmueble'} | Inmobiliaria Vesta"/>
</jsp:include>

<div class="dashboard-wrapper">
    <jsp:include page="/WEB-INF/views/components/sidebar_inmobiliaria.jsp"/>

    <div class="dashboard-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold text-primary mb-1">${not empty propiedad ? 'Editar Inmueble' : 'Publicar Nuevo Inmueble'}</h2>
                <p class="text-muted mb-0">Completa la ficha técnica para publicar el inmueble en el portal nacional</p>
            </div>
            <a href="${pageContext.request.contextPath}/inmobiliaria/propiedades" class="btn btn-vesta-outline">
                <i class="bi bi-arrow-left"></i> Volver al Listado
            </a>
        </div>

        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-octagon me-1"></i> ${param.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="bg-white p-4 p-md-5 rounded-4 border border-light shadow-sm">
            <form action="${pageContext.request.contextPath}/inmobiliaria/${not empty propiedad ? 'propiedad-editar' : 'propiedad-nueva'}" method="POST" enctype="multipart/form-data">
                <c:if test="${not empty propiedad}">
                    <input type="hidden" name="idPropiedad" value="${propiedad.idPropiedad}">
                </c:if>

                <div class="row g-4">
                    <!-- Datos Básicos -->
                    <div class="col-12">
                        <h5 class="fw-bold text-primary pb-2 border-bottom"><i class="bi bi-info-circle me-2"></i> 1. Información General</h5>
                    </div>

                    <div class="col-md-8">
                        <label class="form-label-vesta">Título de la Publicación *</label>
                        <input type="text" name="titulo" class="form-control form-control-vesta" 
                               placeholder="Ej: Apartamento moderno con vista en Cabecera" 
                               value="${propiedad.titulo}" required>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label-vesta">Matrícula Inmobiliaria *</label>
                        <input type="text" name="matriculaInmobiliaria" class="form-control form-control-vesta" 
                               placeholder="Ej: MAT-2026-999" 
                               value="${propiedad.matriculaInmobiliaria}" required>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label-vesta">Tipo de Inmueble *</label>
                        <select name="idTipo" class="form-select form-select-vesta" required>
                            <c:forEach var="t" items="${tiposPropiedad}">
                                <option value="${t.idTipo}" ${propiedad.idTipo == t.idTipo ? 'selected' : ''}>${t.nombre}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label-vesta">Tipo de Operación *</label>
                        <select name="tipoOperacion" class="form-select form-select-vesta" required>
                            <option value="venta" ${propiedad.tipoOperacion == 'venta' ? 'selected' : ''}>Venta</option>
                            <option value="arriendo" ${propiedad.tipoOperacion == 'arriendo' ? 'selected' : ''}>Arriendo</option>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label-vesta">Estado de Disponibilidad *</label>
                        <select name="estado" class="form-select form-select-vesta" required>
                            <option value="disponible" ${propiedad.estado == 'disponible' ? 'selected' : ''}>Disponible</option>
                            <option value="vendido" ${propiedad.estado == 'vendido' ? 'selected' : ''}>Vendido</option>
                            <option value="arrendado" ${propiedad.estado == 'arrendado' ? 'selected' : ''}>Arrendado</option>
                            <option value="inactivo" ${propiedad.estado == 'inactivo' ? 'selected' : ''}>Inactivo</option>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label-vesta">Precio ($ COP) *</label>
                        <input type="number" name="precio" class="form-control form-control-vesta" 
                               placeholder="350000000" value="${propiedad.precio}" required step="100000">
                    </div>

                    <!-- Ubicación y Dimensiones -->
                    <div class="col-12 mt-4">
                        <h5 class="fw-bold text-primary pb-2 border-bottom"><i class="bi bi-geo-alt me-2"></i> 2. Ubicación & Dimensiones</h5>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label-vesta">Ciudad *</label>
                        <select name="idCiudad" class="form-select form-select-vesta" required>
                            <c:forEach var="c" items="${ciudades}">
                                <option value="${c.idCiudad}" ${propiedad.idCiudad == c.idCiudad ? 'selected' : ''}>
                                    ${c.nombre} (${c.departamento})
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-8">
                        <label class="form-label-vesta">Dirección Física *</label>
                        <input type="text" name="direccion" class="form-control form-control-vesta" 
                               placeholder="Calle 50 #25-30" value="${propiedad.direccion}" required>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label-vesta">Área Construida (m²)</label>
                        <input type="number" name="areaM2" class="form-control form-control-vesta" 
                               placeholder="85.5" value="${propiedad.areaM2}" step="0.1">
                    </div>

                    <div class="col-md-4">
                        <label class="form-label-vesta">Habitaciones</label>
                        <input type="number" name="habitaciones" class="form-control form-control-vesta" 
                               value="${not empty propiedad.habitaciones ? propiedad.habitaciones : 3}" min="0">
                    </div>

                    <div class="col-md-4">
                        <label class="form-label-vesta">Baños</label>
                        <input type="number" name="banos" class="form-control form-control-vesta" 
                               value="${not empty propiedad.banos ? propiedad.banos : 2}" min="0">
                    </div>

                    <div class="col-12">
                        <label class="form-label-vesta">Descripción Detallada</label>
                        <textarea name="descripcion" rows="4" class="form-control form-control-vesta" 
                                  placeholder="Describe las virtudes del inmueble, acabados, vías de acceso...">${propiedad.descripcion}</textarea>
                    </div>

                    <!-- Características N:M -->
                    <div class="col-12 mt-4">
                        <h5 class="fw-bold text-primary pb-2 border-bottom"><i class="bi bi-check2-square me-2"></i> 3. Amenidades y Características (N:M)</h5>
                        <div class="row g-3 mt-1">
                            <c:forEach var="carac" items="${caracteristicas}">
                                <div class="col-md-4 col-lg-3">
                                    <div class="form-check p-2 rounded-3 bg-light">
                                        <input class="form-check-input ms-1" type="checkbox" name="caracteristicas" 
                                               value="${carac.idCaracteristica}" id="carac_${carac.idCaracteristica}">
                                        <label class="form-check-label fw-semibold small ms-2" for="carac_${carac.idCaracteristica}">
                                            ${carac.nombre}
                                        </label>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Galería de Fotos -->
                    <div class="col-12 mt-4">
                        <h5 class="fw-bold text-primary pb-2 border-bottom"><i class="bi bi-images me-2"></i> 4. Galería de Imágenes</h5>
                        
                        <div class="mb-3">
                            <label class="form-label-vesta">Subir imágenes desde tu computador</label>
                            <input type="file" name="imagenesFiles" class="form-control form-control-vesta" 
                                   accept="image/*" multiple onchange="previewImages(this)">
                            <small class="text-muted">Puedes seleccionar múltiples archivos (JPG, PNG, GIF, WEBP). Máximo 10MB por archivo.</small>
                            
                            <div id="imagePreview" class="row g-2 mt-2"></div>
                        </div>
                        
                        <div class="mt-3">
                            <label class="form-label-vesta">O URLs de imágenes (una por línea o separadas por coma)</label>
                            <textarea name="imagenesUrls" rows="3" class="form-control form-control-vesta" 
                                      placeholder="https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800&#10;https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800">${propiedad != null and not empty propiedad.imagenes ? propiedad.imagenes : ''}</textarea>
                            <small class="text-muted">Si no subes imágenes ni pones URLs, el sistema asignará fotos arquitectónicas por defecto.</small>
                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-end gap-3 mt-5 pt-3 border-top">
                    <a href="${pageContext.request.contextPath}/inmobiliaria/propiedades" class="btn btn-light">Cancelar</a>
                    <button type="submit" class="btn btn-vesta-accent px-4 py-2">
                        <i class="bi bi-check-lg me-1"></i> ${not empty propiedad ? 'Guardar Cambios' : 'Publicar Inmueble'}
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
function previewImages(input) {
    const preview = document.getElementById('imagePreview');
    preview.innerHTML = '';
    
    if (input.files) {
        Array.from(input.files).forEach((file, index) => {
            if (!file.type.startsWith('image/')) return;
            
            const reader = new FileReader();
            reader.onload = function(e) {
                const col = document.createElement('div');
                col.className = 'col-3';
                col.innerHTML = `
                    <div class="position-relative">
                        <img src="${e.target.result}" class="img-fluid rounded border" style="height: 80px; width: 100%; object-fit: cover;">
                        <span class="badge bg-primary position-absolute top-0 start-0">${index + 1}</span>
                    </div>
                `;
                preview.appendChild(col);
            };
            reader.readAsDataURL(file);
        });
    }
}
</script>

<jsp:include page="/WEB-INF/views/components/footer.jsp"/>
