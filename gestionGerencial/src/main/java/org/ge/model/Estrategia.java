package org.ge.model;

import java.util.Date;

public class Estrategia extends ElementoMail implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4028391919555399593L;
	
	private Integer codigo;
	private String nombre;
	private Date fechaRegistro;
	private Date fechaInicio;
	private Date fechaFin;
	private Empleado responsableEstrategia;
	private Objetivo objetivoEstrategia;
	private String estado;
	private String descripcion;
	private String comentarios;
	
	public Estrategia(){		
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

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public Integer getCodigo() {
		return codigo;
	}

	public void setCodigo(Integer codigo) {
		this.codigo = codigo;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public Date getFechaRegistro() {
		return fechaRegistro;
	}

	public void setFechaRegistro(Date fechaRegistro) {
		this.fechaRegistro = fechaRegistro;
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

	public Empleado getResponsableEstrategia() {
		return responsableEstrategia;
	}

	public void setResponsableEstrategia(Empleado responsableEstrategia) {
		this.responsableEstrategia = responsableEstrategia;
	}

	public Objetivo getObjetivoEstrategia() {
		return objetivoEstrategia;
	}

	public void setObjetivoEstrategia(Objetivo objetivoEstrategia) {
		this.objetivoEstrategia = objetivoEstrategia;
	}
	
}
