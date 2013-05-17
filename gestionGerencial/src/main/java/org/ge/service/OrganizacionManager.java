package org.ge.service;

import java.util.List;

import org.ge.model.Area;
import org.ge.model.Cargo;
import org.ge.model.Empleado;

public interface OrganizacionManager {

	public List<Area> getListaAreas();
	
	public List<Empleado> getListaEmpleados();

	public Area getAreaPorCodigo(Integer codigoArea);

	public Empleado getEmpleadoPorCodigo(Integer codigoEmpleado);
	
	public Cargo getCargoPorCodigo(Integer codigoCargo);
	
	public Cargo getCargoPorDescripcion(String descripcion);
	
	public Empleado getResponsableArea(Area area);
}
