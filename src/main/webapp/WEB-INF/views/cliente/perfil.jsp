<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/components/header.jsp">
    <jsp:param name="pageTitle" value="Mi Perfil | Inmobiliaria Vesta"/>
</jsp:include>

<div class="dashboard-wrapper">
    <jsp:include page="/WEB-INF/views/components/sidebar_cliente.jsp"/>

    <div class="dashboard-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold text-primary mb-1">Mi Perfil</h2>
                <p class="text-muted mb-0">Actualiza tus datos de contacto y foto de perfil</p>
            </div>
        </div>

        <c:if test="${param.msg == 'perfil_actualizado'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> Perfil actualizado correctamente.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${param.error != null}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-octagon-fill me-2"></i> ${param.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="row">
            <div class="col-lg-8">
                <div class="bg-white p-4 p-md-5 rounded-4 border border-light shadow-sm">
                    <form action="${pageContext.request.contextPath}/cliente/perfil" method="POST" enctype="multipart/form-data">
                        
                        <!-- Foto de Perfil -->
                        <div class="text-center mb-4">
                            <div class="position-relative d-inline-block">
                                <c:choose>
                                    <c:when test="${not empty perfil.fotoUrl and not perfil.fotoUrl.startsWith('https://i.pravatar')}">
                                        <img src="${pageContext.request.contextPath}/uploads/perfiles/${perfil.fotoUrl}" 
                                             alt="Foto de perfil" class="rounded-circle border border-3 border-primary" 
                                             style="width: 150px; height: 150px; object-fit: cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center mx-auto"
                                             style="width: 150px; height: 150px; font-size: 3rem; font-weight: bold;">
                                            ${not empty perfil.nombres ? fn:substring(perfil.nombres, 0, 1) : fn:substring(sessionScope.correoUsuario, 0, 1)}
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                
                                <label for="fotoPerfil" class="position-absolute bottom-0 end-0 btn btn-sm btn-vesta-accent rounded-circle" 
                                       style="width: 40px; height: 40px; cursor: pointer;" title="Cambiar foto">
                                    <i class="bi bi-camera-fill"></i>
                                    <input type="file" id="fotoPerfil" name="fotoPerfil" accept="image/*" style="display: none;" onchange="this.form.submit()">
                                </label>
                            </div>
                            <p class="text-muted mt-2 small">Haz clic en el ícono de cámara para cambiar tu foto de perfil</p>
                        </div>
                        
                        <hr class="my-4">

                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label-vesta">Nombres</label>
                                <input type="text" name="nombres" class="form-control form-control-vesta" value="${perfil.nombres}" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label-vesta">Apellidos</label>
                                <input type="text" name="apellidos" class="form-control form-control-vesta" value="${perfil.apellidos}" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label-vesta">Documento de Identidad</label>
                                <input type="text" name="documento" class="form-control form-control-vesta" value="${perfil.documento}">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label-vesta">Teléfono</label>
                                <input type="tel" name="telefono" class="form-control form-control-vesta" value="${perfil.telefono}">
                            </div>

                            <div class="col-12">
                                <label class="form-label-vesta">Dirección de Residencia</label>
                                <input type="text" name="direccion" class="form-control form-control-vesta" value="${perfil.direccion}">
                            </div>

                            <div class="col-12">
                                <label class="form-label-vesta">Correo Electrónico (Registrado)</label>
                                <input type="email" class="form-control form-control-vesta bg-light" value="${sessionScope.correoUsuario}" readonly>
                                <small class="text-muted">El correo electrónico identifica tu cuenta de forma única y no puede modificarse.</small>
                            </div>
                        </div>

                        <div class="mt-4 pt-3 border-top">
                            <button type="submit" class="btn btn-vesta-accent">
                                <i class="bi bi-check2-circle"></i> Guardar Cambios
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/components/footer.jsp"/>
