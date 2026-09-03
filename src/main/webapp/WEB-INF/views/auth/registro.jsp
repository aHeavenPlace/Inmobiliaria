<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/components/header.jsp">
    <jsp:param name="pageTitle" value="Crear Cuenta | Inmobiliaria Sora"/>
</jsp:include>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-10 col-lg-7">
            <div class="bg-white p-4 p-md-5 rounded-4 border border-light shadow-lg">
                <div class="text-center mb-4">
                    <div class="d-inline-flex p-3 rounded-circle bg-light text-primary mb-2">
                        <i class="bi bi-person-plus-fill fs-2"></i>
                    </div>
                    <h2 class="fw-bold text-primary mb-1">Crea tu Cuenta</h2>
                    <p class="text-muted small">Únete a Inmobiliaria Sora para guardar favoritos, agendar citas y radicar solicitudes</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-octagon me-1"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/registro" method="POST">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label-sora">Nombres *</label>
                            <input type="text" name="nombres" class="form-control form-control-sora" placeholder="Juan" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label-sora">Apellidos *</label>
                            <input type="text" name="apellidos" class="form-control form-control-sora" placeholder="Pérez" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label-sora">Correo Electrónico *</label>
                            <input type="email" name="correo" class="form-control form-control-sora" placeholder="correo@ejemplo.com" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label-sora">Documento de Identidad</label>
                            <input type="text" name="documento" class="form-control form-control-sora" placeholder="C.C. o NIT">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label-sora">Teléfono de Contacto</label>
                            <input type="tel" name="telefono" class="form-control form-control-sora" placeholder="3001234567">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label-sora">Dirección</label>
                            <input type="text" name="direccion" class="form-control form-control-sora" placeholder="Calle 50 #10-20">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label-sora">Contraseña *</label>
                            <input type="password" name="password" class="form-control form-control-sora" placeholder="Mínimo 6 caracteres" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label-sora">Confirmar Contraseña *</label>
                            <input type="password" name="confirmPassword" class="form-control form-control-sora" placeholder="Repite la contraseña" required>
                        </div>

                        <div class="col-12">
                            <label class="form-label-sora">Tipo de Perfil</label>
                            <select name="tipoCuenta" class="form-select form-select-sora">
                                <option value="cliente" selected>Cliente (Comprador o Arrendatario)</option>
                                <option value="inmobiliaria">Agente / Inmobiliaria (Publicar inmuebles)</option>
                            </select>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-sora-accent w-100 py-3 justify-content-center fw-bold mt-4">
                        <i class="bi bi-check2-circle"></i> Completar Registro
                    </button>
                </form>

                <div class="text-center mt-4 pt-3 border-top small">
                    <span class="text-muted">¿Ya tienes una cuenta?</span>
                    <a href="${pageContext.request.contextPath}/login" class="fw-bold text-primary ms-1">Inicia sesión</a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/components/footer.jsp"/>
