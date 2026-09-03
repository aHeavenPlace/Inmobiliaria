<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Footer Vesta -->
<footer class="footer-sora">
    <div class="container">
        <div class="row g-4 pb-4 border-bottom border-secondary border-opacity-25">
            <div class="col-lg-4 col-md-6">
                <div class="d-flex align-items-center gap-2 mb-3">
                    <i class="bi bi-buildings-fill" style="color: var(--color-accent); font-size: 1.75rem;"></i>
                    <span class="fs-4 fw-bold text-white">VESTA</span>
                </div>
                <p class="small text-secondary mb-4">
                    Plataforma premium para la compra, venta y arrendamiento de bienes raíces exclusivos en Colombia. 
                    Conectamos tus sueños con espacios que inspiran.
                </p>
                <div class="d-flex gap-3 fs-5">
                    <a href="#" class="text-secondary"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="text-secondary"><i class="bi bi-instagram"></i></a>
                    <a href="#" class="text-secondary"><i class="bi bi-whatsapp"></i></a>
                    <a href="#" class="text-secondary"><i class="bi bi-linkedin"></i></a>
                </div>
            </div>

            <div class="col-lg-2 col-md-6">
                <h5>Navegación</h5>
                <ul class="list-unstyled small d-flex flex-column gap-2">
                    <li><a href="${pageContext.request.contextPath}/home">Inicio</a></li>
                    <li><a href="${pageContext.request.contextPath}/catalogo">Catálogo Completo</a></li>
                    <li><a href="${pageContext.request.contextPath}/catalogo?operacion=venta">Inmuebles en Venta</a></li>
                    <li><a href="${pageContext.request.contextPath}/catalogo?operacion=arriendo">Inmuebles en Arriendo</a></li>
                </ul>
            </div>

            <div class="col-lg-3 col-md-6">
                <h5>Ciudades Principales</h5>
                <ul class="list-unstyled small d-flex flex-column gap-2">
                    <li><a href="${pageContext.request.contextPath}/catalogo?ciudad=1">Bucaramanga</a></li>
                    <li><a href="${pageContext.request.contextPath}/catalogo?ciudad=2">Floridablanca</a></li>
                    <li><a href="${pageContext.request.contextPath}/catalogo?ciudad=5">Bogotá D.C.</a></li>
                    <li><a href="${pageContext.request.contextPath}/catalogo?ciudad=6">Medellín</a></li>
                </ul>
            </div>

            <div class="col-lg-3 col-md-6">
                <h5>Contacto & Soporte</h5>
                <ul class="list-unstyled small text-secondary d-flex flex-column gap-2">
                    <li><i class="bi bi-geo-alt me-2" style="color: var(--color-accent);"></i> Carrera 15 #27-30, Bucaramanga</li>
                    <li><i class="bi bi-telephone me-2" style="color: var(--color-accent);"></i> +57 (607) 123-4567</li>
                    <li><i class="bi bi-envelope me-2" style="color: var(--color-accent);"></i> contacto@vesta.com</li>
                    <li><i class="bi bi-clock me-2" style="color: var(--color-accent);"></i> Lun - Sáb: 8:00 AM - 6:00 PM</li>
                </ul>
            </div>
        </div>

        <div class="d-flex flex-column flex-md-row justify-content-between align-items-center pt-4 small text-secondary">
            <div>
                &copy; 2026 Vesta Inmobiliaria SAS. Proyecto Universitario Java EE + Tomcat 10 + PostgreSQL.
            </div>
            <div class="d-flex gap-3 mt-2 mt-md-0">
                <a href="#">Términos y Condiciones</a>
                <span>&bull;</span>
                <a href="#">Política de Privacidad</a>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Chart.js para gráficas estadísticas interactivas -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.2/dist/chart.umd.min.js"></script>
<!-- Vesta Main JS -->
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>

</body>
</html>
