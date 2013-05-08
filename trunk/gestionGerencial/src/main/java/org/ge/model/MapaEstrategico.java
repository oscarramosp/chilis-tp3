package org.ge.model;

import java.util.Date;

public class MapaEstrategico extends ElementoMail implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5980042048003150021L;
	
	private Integer codigo;
	private String resumen;
	private Date fechaInicio;
	private Date fechaFin;
	private Date fechaRegistro;
	private String tipoGenera;	
	private String estado;
	private String descripcion;
	private String comentarios;
	
	public MapaEstrategico(){		
	}

	public Integer getCodigo() {
		return codigo;
	}

	public void setCodigo(Integer codigo) {
		this.codigo = codigo;
	}

	public String getResumen() {
		return resumen;
	}

	public void setResumen(String resumen) {
		this.resumen = resumen;
	}

	public Date getFechaInicio() {
		return fechaInicio;
	}

	public void setFechaInicio(Date fechaInicio) {
		this.fechaInicio = fechaInicio;
	}

	public Date getFechaFin() {
		return fechaFin;
	}

	public void setFechaFin(Date fechaFin) {
		this.fechaFin = fechaFin;
	}

	public Date getFechaRegistro() {
		return fechaRegistro;
	}

	public void setFechaRegistro(Date fechaRegistro) {
		this.fechaRegistro = fechaRegistro;
	}

	public String getTipoGenera() {
		return tipoGenera;
	}

	public void setTipoGenera(String tipoGenera) {
		this.tipoGenera = tipoGenera;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public String getComentarios() {
		return comentarios;
	}

	public void setComentarios(String comentarios) {
		this.comentarios = comentarios;
	}
	
	
	
}
