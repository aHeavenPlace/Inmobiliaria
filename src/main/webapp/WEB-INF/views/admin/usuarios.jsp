<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/components/header.jsp">
    <jsp:param name="pageTitle" value="Usuarios & Roles | Inmobiliaria Vesta"/>
</jsp:include>

<div class="dashboard-wrapper">
    <jsp:include page="/WEB-INF/views/components/sidebar_admin.jsp"/>

    <div class="dashboard-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold text-primary mb-1">Gestión de Usuarios & Roles</h2>
                <p class="text-muted mb-0">Consulta N:M de roles asignados a cada cuenta de usuario en el sistema</p>
            </div>
        </div>

        <c:if test="${param.msg == 'usuario_desactivado'}">
            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle me-1"></i> Usuario desactivado correctamente del sistema.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${param.msg == 'rol_asignado'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill me-1"></i> Rol asignado/modificado correctamente.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="bg-white rounded-4 border border-light shadow-sm overflow-hidden">
            <div class="p-3 border-bottom bg-light d-flex gap-2 align-items-center flex-wrap">
                <i class="bi bi-funnel text-muted"></i>
                <span class="small fw-bold text-muted">Filtrar por rol:</span>
                <a href="${pageContext.request.contextPath}/admin/usuarios" class="badge ${empty filtroRol ? 'bg-primary' : 'bg-light text-dark border'} px-3 py-2 text-decoration-none">Todos</a>
                <c:forEach var="r" items="${roles}">
                    <a href="${pageContext.request.contextPath}/admin/usuarios?rol=${r.nombre}" 
                       class="badge ${filtroRol == r.nombre ? 'bg-primary' : 'bg-light text-dark border'} px-3 py-2 text-decoration-none">
                        ${r.nombre}
                    </a>
                </c:forEach>
            </div>

            <div class="table-responsive">
                <table class="table-vesta">
                    <thead>
                        <tr>
                            <th>Usuario</th>
                            <th>Correo</th>
                            <th>Roles Asignados (Relación N:M)</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${usuarios}">
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center gap-2">
                                        <img src="https://i.pravatar.cc/36?u=${u.idUsuario}" class="rounded-circle" width="36" height="36">
                                        <div>
                                            <strong class="text-dark d-block">
                                                <c:choose>
                                                    <c:when test="${not empty u.perfil}">
                                                        ${u.perfil.nombres} ${u.perfil.apellidos}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Usuario sin perfil
                                                    </c:otherwise>
                                                </c:choose>
                                            </strong>
                                            <small class="text-muted">ID: ${u.idUsuario}</small>
                                        </div>
                                    </div>
                                </td>
                                <td>${u.correo}</td>
                                <td>
                                    <div class="d-flex flex-wrap gap-1">
                                        <c:forEach var="r" items="${u.roles}">
                                            <span class="badge ${r.nombre == 'admin' ? 'bg-danger' : r.nombre == 'inmobiliaria' ? 'bg-info text-dark' : 'bg-success'} px-2">
                                                ${r.nombre}
                                            </span>
                                        </c:forEach>
                                    </div>
                                </td>
                                <td>
                                    <span class="badge-vesta ${u.activo ? 'badge-vesta-success' : 'badge-vesta-danger'}">
                                        ${u.activo ? 'Activo' : 'Inactivo'}
                                    </span>
                                </td>
                                <td>
                                    <div class="d-flex gap-1">
                                        <div class="dropdown">
                                            <button class="btn btn-sm btn-outline-primary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                                <i class="bi bi-shield-plus"></i> Roles
                                            </button>
                                            <ul class="dropdown-menu shadow border-0">
                                                <c:forEach var="rol" items="${roles}">
                                                    <li>
                                                        <form action="${pageContext.request.contextPath}/admin/asignar-rol" method="POST">
                                                            <input type="hidden" name="idUsuario" value="${u.idUsuario}">
                                                            <input type="hidden" name="idRol" value="${rol.idRol}">
                                                            <button type="submit" class="dropdown-item small">
                                                                <i class="bi bi-check-lg me-1"></i> Asignar rol: ${rol.nombre}
                                                            </button>
                                                        </form>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </div>

                                        <c:if test="${u.activo && u.correo != sessionScope.correoUsuario}">
                                            <form action="${pageContext.request.contextPath}/admin/desactivar-usuario" method="POST" onsubmit="return confirm('¿Desactivar esta cuenta?');">
                                                <input type="hidden" name="idUsuario" value="${u.idUsuario}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger" title="Desactivar cuenta">
                                                    <i class="bi bi-person-slash"></i>
                                                </button>
                                            </form>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty usuarios}">
                            <tr>
                                <td colspan="5" class="text-center py-5 text-muted">No se encontraron usuarios.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/components/footer.jsp"/>
