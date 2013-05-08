package org.ge.model;
public class Cargo implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 9053718606509360894L;
	private Integer codigo;
	private String nombre;
	private String descripcion;

	public Cargo(){
	}
	
	public Cargo(String nombre, String descripcion) {
		this.nombre = nombre;
		this.descripcion = descripcion;
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

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
	

}
