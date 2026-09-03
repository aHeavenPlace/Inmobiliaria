<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/components/header.jsp">
    <jsp:param name="pageTitle" value="Reportes & Métricas | Inmobiliaria Sora"/>
</jsp:include>

<div class="dashboard-wrapper">
    <jsp:include page="/WEB-INF/views/components/sidebar_inmobiliaria.jsp"/>

    <div class="dashboard-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold text-primary mb-1">Métricas y Reportes Estadísticos</h2>
                <p class="text-muted mb-0">Análisis cuantitativo de oferta inmobiliaria, precios y concentración por ciudad</p>
            </div>
            <a href="${pageContext.request.contextPath}/reportes/exportar-csv" class="btn btn-sora-primary">
                <i class="bi bi-file-earmark-spreadsheet me-2"></i> Exportar a Excel / CSV
            </a>
        </div>

        <!-- Fila de Gráficos Chart.js -->
        <div class="row g-4 mb-4">
            <div class="col-lg-6">
                <div class="bg-white p-4 rounded-4 border border-light shadow-sm">
                    <h5 class="fw-bold text-primary mb-3"><i class="bi bi-bar-chart-line me-2"></i> Inmuebles Disponibles por Ciudad (GROUP BY + HAVING)</h5>
                    <canvas id="chartCiudades" height="260"></canvas>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="bg-white p-4 rounded-4 border border-light shadow-sm">
                    <h5 class="fw-bold text-primary mb-3"><i class="bi bi-pie-chart me-2"></i> Distribución por Tipo de Inmueble</h5>
                    <canvas id="chartTipos" height="260"></canvas>
                </div>
            </div>
        </div>

        <!-- Tabla Consulta GROUP BY + HAVING por Ciudad -->
        <div class="bg-white p-4 rounded-4 border border-light shadow-sm mb-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h5 class="fw-bold text-primary mb-0">
                        <i class="bi bi-table me-2"></i> Consulta SQL Obligatoria: Agrupamiento por Ciudad (GROUP BY + HAVING)
                    </h5>
                    <small class="text-muted">Filtro aplicado: <code>HAVING COUNT(p.id_propiedad) >= 1</code></small>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table-sora">
                    <thead>
                        <tr>
                            <th>Ciudad</th>
                            <th>Departamento</th>
                            <th>Total Inmuebles</th>
                            <th>Precio Promedio ($ COP)</th>
                            <th>Precio Mínimo</th>
                            <th>Precio Máximo</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="stat" items="${statsCiudades}">
                            <tr>
                                <td class="fw-bold text-primary">${stat.ciudad}</td>
                                <td>${stat.departamento}</td>
                                <td><span class="badge bg-primary px-3 py-1">${stat.totalPropiedades}</span></td>
                                <td class="fw-semibold">$ ${stat.precioPromedio}</td>
                                <td class="text-success">$ ${stat.precioMinimo}</td>
                                <td class="text-danger">$ ${stat.precioMaximo}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Tabla Consulta GROUP BY + HAVING por Tipo -->
        <div class="bg-white p-4 rounded-4 border border-light shadow-sm">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h5 class="fw-bold text-primary mb-0">
                        <i class="bi bi-table me-2"></i> Consulta SQL Obligatoria: Agrupamiento por Tipo de Inmueble
                    </h5>
                    <small class="text-muted">Filtro aplicado: <code>HAVING COUNT(p.id_propiedad) >= 1</code></small>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table-sora">
                    <thead>
                        <tr>
                            <th>Tipo de Inmueble</th>
                            <th>Total Publicados</th>
                            <th>Precio Promedio de Oferta ($ COP)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="st" items="${statsTipos}">
                            <tr>
                                <td class="fw-bold text-primary">${st.tipo}</td>
                                <td><span class="badge bg-info text-dark px-3 py-1">${st.totalPropiedades}</span></td>
                                <td class="fw-semibold">$ ${st.precioPromedio}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', async () => {
    // Inicializar Gráfico de Ciudades
    try {
        const resCiudades = await fetch('${pageContext.request.contextPath}/api/reportes/ciudades');
        const dataCiudades = await resCiudades.json();

        const labelsCiudades = dataCiudades.map(c => c.ciudad);
        const totalsCiudades = dataCiudades.map(c => c.totalPropiedades);

        new Chart(document.getElementById('chartCiudades'), {
            type: 'bar',
            data: {
                labels: labelsCiudades,
                datasets: [{
                    label: 'Propiedades Disponibles',
                    data: totalsCiudades,
                    backgroundColor: '#0D9488',
                    borderRadius: 8
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    y: { beginAtZero: true, ticks: { precision: 0 } }
                }
            }
        });
    } catch (e) {
        console.error('Error cargando gráfico de ciudades:', e);
    }

    // Inicializar Gráfico de Tipos
    try {
        const resTipos = await fetch('${pageContext.request.contextPath}/api/reportes/tipos');
        const dataTipos = await resTipos.json();

        const labelsTipos = dataTipos.map(t => t.tipo);
        const totalsTipos = dataTipos.map(t => t.totalPropiedades);

        new Chart(document.getElementById('chartTipos'), {
            type: 'doughnut',
            data: {
                labels: labelsTipos,
                datasets: [{
                    data: totalsTipos,
                    backgroundColor: ['#0F172A', '#0D9488', '#0284C7', '#D97706', '#10B981']
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { position: 'bottom' }
                }
            }
        });
    } catch (e) {
        console.error('Error cargando gráfico de tipos:', e);
    }
});
</script>

<jsp:include page="/WEB-INF/views/components/footer.jsp"/>
