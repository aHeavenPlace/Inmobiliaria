<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/components/header.jsp">
    <jsp:param name="pageTitle" value="Iniciar Sesión | Inmobiliaria Sora"/>
</jsp:include>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-5">
            <div class="bg-white p-4 p-md-5 rounded-4 border border-light shadow-lg">
                <div class="text-center mb-4">
                    <div class="d-inline-flex p-3 rounded-circle bg-light text-primary mb-2">
                        <i class="bi bi-shield-lock-fill fs-2"></i>
                    </div>
                    <h2 class="fw-bold text-primary mb-1">Bienvenido a Sora</h2>
                    <p class="text-muted small">Ingresa tus credenciales para acceder a tu panel</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-octagon me-1"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${param.msg == 'sesion_cerrada'}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="bi bi-check-circle me-1"></i> Sesión cerrada exitosamente.
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="POST">
                    <input type="hidden" name="redirect" value="${param.redirect}">

                    <div class="mb-3">
                        <label class="form-label-sora">Correo Electrónico</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0"><i class="bi bi-envelope text-muted"></i></span>
                            <input type="email" name="correo" id="loginCorreo" class="form-control form-control-sora border-start-0" 
                                   placeholder="usuario@ejemplo.com" value="${not empty correoPrevio ? correoPrevio : ''}" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label-sora">Contraseña</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0"><i class="bi bi-lock text-muted"></i></span>
                            <input type="password" name="password" id="loginPassword" class="form-control form-control-sora border-start-0" 
                                   placeholder="••••••••" required>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-sora-accent w-100 py-3 justify-content-center fw-bold mb-3">
                        <i class="bi bi-box-arrow-in-right"></i> Iniciar Sesión
                    </button>
                </form>

                <!-- Cuentas de Demostración Rápidas (1 Clic) -->
                <div class="p-3 bg-light rounded-3 mt-4 border border-light">
                    <div class="fw-bold small text-muted text-uppercase mb-2 text-center">
                        <i class="bi bi-lightning-charge-fill text-warning me-1"></i> Accesos Rápidos de Prueba
                    </div>
                    <div class="d-grid gap-2">
                        <button class="btn btn-sm btn-outline-dark text-start" onclick="fillLogin('admin@sora.com', 'admin123')">
                            <strong>Admin:</strong> admin@sora.com / <code>admin123</code>
                        </button>
                        <button class="btn btn-sm btn-outline-primary text-start" onclick="fillLogin('carlos@inmobiliaria.com', 'inmobiliaria123')">
                            <strong>Inmobiliaria:</strong> carlos@inmobiliaria.com / <code>inmobiliaria123</code>
                        </button>
                        <button class="btn btn-sm btn-outline-success text-start" onclick="fillLogin('juan@cliente.com', 'cliente123')">
                            <strong>Cliente:</strong> juan@cliente.com / <code>cliente123</code>
                        </button>
                    </div>
                </div>

                <div class="text-center mt-4 pt-3 border-top small">
                    <span class="text-muted">¿No tienes una cuenta aún?</span>
                    <a href="${pageContext.request.contextPath}/registro" class="fw-bold text-primary ms-1">Regístrate aquí</a>
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
