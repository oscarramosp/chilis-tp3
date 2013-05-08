package org.ge.model;
public class Area implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7544979582447592770L;
	private Integer codigo;
	private String nombre;

	public Area(){
	}
	
	public Area(String nombre) {
		this.nombre = nombre;
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
	
	
}
