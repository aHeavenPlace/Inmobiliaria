<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/components/header.jsp">
    <jsp:param name="pageTitle" value="Iniciar Sesión | Vesta Inmobiliaria"/>
</jsp:include>

<div class="auth-page-wrapper">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-5">
                <div class="auth-card glass-effect p-4 p-md-5 rounded-4 shadow-xl">
                    <div class="text-center mb-4">
                        <div class="vesta-logo-small mb-3">
                            <span class="logo-icon">🏛️</span>
                        </div>
                        <h2 class="fw-bold text-vesta-charcoal mb-1">Bienvenido a Vesta</h2>
                        <p class="text-vesta-gray muted">Ingresa tus credenciales para acceder a tu panel</p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger-vsta alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-octagon me-1"></i> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <c:if test="${param.msg == 'sesion_cerrada'}">
                        <div class="alert alert-success-vsta alert-dismissible fade show" role="alert">
                            <i class="bi bi-check-circle me-1"></i> Sesión cerrada exitosamente.
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/login" method="POST">
                        <input type="hidden" name="redirect" value="${param.redirect}">

                        <div class="mb-3">
                            <label class="form-label-vesta">Correo Electrónico</label>
                            <div class="input-group-vsta">
                                <span class="input-icon"><i class="bi bi-envelope"></i></span>
                                <input type="email" name="correo" id="loginCorreo" class="form-control-vesta" 
                                       placeholder="usuario@ejemplo.com" value="${not empty correoPrevio ? correoPrevio : ''}" required>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label-vesta">Contraseña</label>
                            <div class="input-group-vsta">
                                <span class="input-icon"><i class="bi bi-lock"></i></span>
                                <input type="password" name="password" id="loginPassword" class="form-control-vesta" 
                                       placeholder="••••••••" required>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-vesta-primary w-100 py-3 d-flex align-items-center justify-content-center fw-semibold mb-3">
                            <i class="bi bi-box-arrow-in-right me-2"></i> Iniciar Sesión
                        </button>
                    </form>

                    <!-- Cuentas de Demostración Rápidas (1 Clic) -->
                    <div class="quick-access-panel mt-4 p-3 rounded-3 border">
                        <div class="fw-bold small text-muted text-uppercase mb-2 text-center d-flex align-items-center justify-content-center gap-2">
                            <i class="bi bi-lightning-charge-fill text-warning"></i> Accesos Rápidos de Prueba
                        </div>
                        <div class="d-grid gap-2">
                            <button class="btn btn-sm btn-outline-vesta text-start" onclick="fillLogin('admin@sora.com', 'admin123')">
                                <strong>Admin:</strong> admin@sora.com / <code>admin123</code>
                            </button>
                            <button class="btn btn-sm btn-outline-vesta text-start" onclick="fillLogin('carlos@inmobiliaria.com', 'inmobiliaria123')">
                                <strong>Inmobiliaria:</strong> carlos@inmobiliaria.com / <code>inmobiliaria123</code>
                            </button>
                            <button class="btn btn-sm btn-outline-vesta text-start" onclick="fillLogin('juan@cliente.com', 'cliente123')">
                                <strong>Cliente:</strong> juan@cliente.com / <code>cliente123</code>
                            </button>
                        </div>
                    </div>

                    <div class="text-center mt-4 pt-3 border-top">
                        <span class="text-muted">¿No tienes una cuenta aún?</span>
                        <a href="${pageContext.request.contextPath}/registro" class="fw-bold text-vesta-accent ms-1 text-decoration-none">Regístrate aquí</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
function fillLogin(email, pass) {
    document.getElementById('loginCorreo').value = email;
    document.getElementById('loginPassword').value = pass;
}
</script>

<jsp:include page="/WEB-INF/views/components/footer.jsp"/>
