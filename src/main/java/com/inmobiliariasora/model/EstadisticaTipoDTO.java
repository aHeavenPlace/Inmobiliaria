package com.inmobiliariasora.model;

import java.io.Serializable;
import java.math.BigDecimal;

public class EstadisticaTipoDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idTipo;
    private String tipo;
    private long totalPropiedades;
    private BigDecimal precioPromedio;

    public EstadisticaTipoDTO() {}

    public EstadisticaTipoDTO(int idTipo, String tipo, long totalPropiedades, BigDecimal precioPromedio) {
        this.idTipo = idTipo;
        this.tipo = tipo;
        this.totalPropiedades = totalPropiedades;
        this.precioPromedio = precioPromedio;
    }

    public int getIdTipo() { return idTipo; }
    public void setIdTipo(int idTipo) { this.idTipo = idTipo; }

    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }

    public long getTotalPropiedades() { return totalPropiedades; }
    public void setTotalPropiedades(long totalPropiedades) { this.totalPropiedades = totalPropiedades; }

    public BigDecimal getPrecioPromedio() { return precioPromedio; }
    public void setPrecioPromedio(BigDecimal precioPromedio) { this.precioPromedio = precioPromedio; }
}
