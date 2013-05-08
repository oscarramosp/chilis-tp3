package org.ge.model;


public class Empleado implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7544979582447592770L;
	private Integer codigo;
	private String nombre;
	private String apellido;
	private String email;	
	private Area area;
	private Cargo cargo;

	public Empleado(){
	}
		
	public Empleado(String nombre, String apellido,
			String email, Area area, Cargo cargo) {
		this.nombre = nombre;
		this.apellido = apellido;
		this.email = email;
		this.area = area;
		this.cargo = cargo;
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

	public String getApellido() {
		return apellido;
	}

	public void setApellido(String apellido) {
		this.apellido = apellido;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}

	public Cargo getCargo() {
		return cargo;
	}

	public void setCargo(Cargo cargo) {
		this.cargo = cargo;
	}

	
}
