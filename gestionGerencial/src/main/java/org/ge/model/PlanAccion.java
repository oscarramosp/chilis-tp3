package org.ge.model;

import java.util.Date;

public class PlanAccion extends ElementoMail implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8458309603129415039L;
	
	private Integer codigo;
	private String nombre;
	private Date fechaRegistro;
	private String estado;
	private String descripcion;
	private String comentarios;
	private Indicador indicador;
	
	public PlanAccion(){		
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

	public Indicador getIndicador() {
		return indicador;
	}

	public void setIndicador(Indicador indicador) {
		this.indicador = indicador;
	}
	
	
	
}
