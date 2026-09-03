package com.inmobiliariasora.model;

import java.io.Serializable;
import java.math.BigDecimal;

public class EstadisticaCiudadDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idCiudad;
    private String ciudad;
    private String departamento;
    private long totalPropiedades;
    private BigDecimal precioPromedio;
    private BigDecimal precioMinimo;
    private BigDecimal precioMaximo;

    public EstadisticaCiudadDTO() {}

    public EstadisticaCiudadDTO(int idCiudad, String ciudad, String departamento, long totalPropiedades, BigDecimal precioPromedio, BigDecimal precioMinimo, BigDecimal precioMaximo) {
        this.idCiudad = idCiudad;
        this.ciudad = ciudad;
        this.departamento = departamento;
        this.totalPropiedades = totalPropiedades;
        this.precioPromedio = precioPromedio;
        this.precioMinimo = precioMinimo;
        this.precioMaximo = precioMaximo;
    }

    public int getIdCiudad() { return idCiudad; }
    public void setIdCiudad(int idCiudad) { this.idCiudad = idCiudad; }

    public String getCiudad() { return ciudad; }
    public void setCiudad(String ciudad) { this.ciudad = ciudad; }

    public String getDepartamento() { return departamento; }
    public void setDepartamento(String departamento) { this.departamento = departamento; }

    public long getTotalPropiedades() { return totalPropiedades; }
    public void setTotalPropiedades(long totalPropiedades) { this.totalPropiedades = totalPropiedades; }

    public BigDecimal getPrecioPromedio() { return precioPromedio; }
    public void setPrecioPromedio(BigDecimal precioPromedio) { this.precioPromedio = precioPromedio; }

    public BigDecimal getPrecioMinimo() { return precioMinimo; }
    public void setPrecioMinimo(BigDecimal precioMinimo) { this.precioMinimo = precioMinimo; }

    public BigDecimal getPrecioMaximo() { return precioMaximo; }
    public void setPrecioMaximo(BigDecimal precioMaximo) { this.precioMaximo = precioMaximo; }
}
