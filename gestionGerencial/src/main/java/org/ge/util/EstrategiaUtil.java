package org.ge.util;

import org.ge.model.Area;
import org.ge.model.Empleado;
import org.ge.model.Estrategia;
import org.ge.model.Objetivo;

public class EstrategiaUtil extends Estrategia{

	private static final long serialVersionUID = -3446879210103305151L;
	
	private Area area;
	private String tipoObjetivo;
	private Objetivo objetivoGeneral;
	private Empleado empleadoGeneral;
	
	public Area getArea() {
		return area;
	}
	public void setArea(Area area) {
		this.area = area;
	}
	public String getTipoObjetivo() {
		return tipoObjetivo;
	}
	public void setTipoObjetivo(String tipoObjetivo) {
		this.tipoObjetivo = tipoObjetivo;
	}
	public Objetivo getObjetivoGeneral() {
		return objetivoGeneral;
	}
	public void setObjetivoGeneral(Objetivo objetivoGeneral) {
		this.objetivoGeneral = objetivoGeneral;
	}
	public Empleado getEmpleadoGeneral() {
		return empleadoGeneral;
	}
	public void setEmpleadoGeneral(Empleado empleadoGeneral) {
		this.empleadoGeneral = empleadoGeneral;
	}
	
	
}
