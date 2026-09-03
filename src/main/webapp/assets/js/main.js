/**
 * INMOBILIARIA SORA - JAVASCRIPT PRINCIPAL
 * Interactividad moderna, favoritos AJAX, notificaciones y carga de gráficos
 */

document.addEventListener('DOMContentLoaded', () => {
    initFavoritosToggle();
    initAlertDismissal();
});

/**
 * Gestión reactiva de favoritos con AJAX (sin recargar la página)
 */
function initFavoritosToggle() {
    document.querySelectorAll('.btn-favorite-heart').forEach(btn => {
        btn.addEventListener('click', async (e) => {
            e.preventDefault();
            e.stopPropagation();

            const idPropiedad = btn.getAttribute('data-id');
            const contextPath = btn.getAttribute('data-context') || '';

            try {
                const response = await fetch(`${contextPath}/cliente/favorito-toggle`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: `idPropiedad=${encodeURIComponent(idPropiedad)}`
                });

                if (response.redirected || response.status === 401 || response.status === 403) {
                    window.location.href = `${contextPath}/login?msg=inicia_sesion_favorito`;
                    return;
                }

                const data = await response.json();
                if (data.success) {
                    const icon = btn.querySelector('i');
                    if (data.esFavorito) {
                        btn.classList.add('is-favorite');
                        icon.classList.remove('bi-heart');
                        icon.classList.add('bi-heart-fill');
                        mostrarToast('Agregada a favoritos', 'success');
                    } else {
                        btn.classList.remove('is-favorite');
                        icon.classList.remove('bi-heart-fill');
                        icon.classList.add('bi-heart');
                        mostrarToast('Removida de favoritos', 'info');
                    }
                } else {
                    mostrarToast(data.error || 'Error al actualizar favoritos', 'error');
                }
            } catch (err) {
                console.error('Error en favorito toggle:', err);
                mostrarToast('Inicia sesión como cliente para guardar favoritos', 'warning');
            }
        });
    });
}

/**
 * Auto-dismiss suave de alertas
 */
function initAlertDismissal() {
    const alerts = document.querySelectorAll('.alert-dismissible');
    alerts.forEach(al => {
        setTimeout(() => {
            al.classList.add('fade');
            setTimeout(() => al.remove(), 400);
        }, 5000);
    });
}

/**
 * Toast flotante no invasivo
 */
function mostrarToast(mensaje, tipo = 'info') {
    let container = document.getElementById('sora-toast-container');
    if (!container) {
        container = document.createElement('div');
        container.id = 'sora-toast-container';
        container.style.cssText = 'position:fixed;bottom:24px;right:24px;z-index:9999;display:flex;flex-direction:column;gap:10px;';
        document.body.appendChild(container);
    }

    const toast = document.createElement('div');
    const colorBg = tipo === 'success' ? '#10B981' : tipo === 'error' ? '#EF4444' : tipo === 'warning' ? '#F59E0B' : '#0D9488';
    
    toast.style.cssText = `
        background-color: ${colorBg};
        color: #FFFFFF;
        padding: 12px 20px;
        border-radius: 10px;
        font-weight: 600;
        font-size: 0.9rem;
        box-shadow: 0 10px 25px -5px rgba(0,0,0,0.2);
        display: flex;
        align-items: center;
        gap: 10px;
        opacity: 0;
        transform: translateY(10px);
        transition: all 250ms ease;
    `;
    
    const iconClass = tipo === 'success' ? 'bi-check-circle-fill' : tipo === 'error' ? 'bi-x-circle-fill' : 'bi-info-circle-fill';
    toast.innerHTML = `<i class="bi ${iconClass}"></i><span>${mensaje}</span>`;

    container.appendChild(toast);

    requestAnimationFrame(() => {
        toast.style.opacity = '1';
        toast.style.transform = 'translateY(0)';
    });

    setTimeout(() => {
        toast.style.opacity = '0';
        toast.style.transform = 'translateY(10px)';
        setTimeout(() => toast.remove(), 300);
    }, 4000);
}
