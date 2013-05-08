package org.ge.model;

import java.util.Date;


public class Objetivo extends ElementoMail implements java.io.Serializable {

	/**
	 * 
	 */
	protected static final long serialVersionUID = 7544979582447592770L;
	protected Integer codigo;
	protected String descripcion;
	protected Date fechaRegistro;
	protected String comentarios;	
	protected String estado;
	protected String tipoObjetivo;

	public Objetivo(){
	}
	
	public Objetivo(String descripcion, String comentarios) {
		this.descripcion = descripcion;
		this.fechaRegistro = new Date();
		this.comentarios = comentarios;
		this.estado = "pendAprobacion";
	}

	public Integer getCodigo() {
		return codigo;
	}

	public void setCodigo(Integer codigo) {
		this.codigo = codigo;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public Date getFechaRegistro() {
		return fechaRegistro;
	}

	public void setFechaRegistro(Date fechaRegistro) {
		this.fechaRegistro = fechaRegistro;
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
	
	public String getTipoObjetivo() {
		return tipoObjetivo;
	}

	public void setTipoObjetivo(String tipoObjetivo) {
		this.tipoObjetivo = tipoObjetivo;
	}

}
