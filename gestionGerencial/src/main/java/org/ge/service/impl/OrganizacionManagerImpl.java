package org.ge.service.impl;

import java.util.List;

import org.ge.dao.OrganizacionDao;
import org.ge.model.Area;
import org.ge.model.Cargo;
import org.ge.model.Empleado;
import org.ge.service.OrganizacionManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public
class OrganizacionManagerImpl implements OrganizacionManager {
	@Autowired
	private OrganizacionDao organizacionDao;

	public List<Area> getListaAreas() {
		return organizacionDao.getListaAreas();
	}

	public Area getAreaPorCodigo(Integer codigoArea) {
		return organizacionDao.getAreaPorCodigo(codigoArea);
	}

	public Empleado getEmpleadoPorCodigo(Integer codigoEmpleado) {
		return organizacionDao.getEmpleadoPorCodigo(codigoEmpleado);
	}

	public Cargo getCargoPorCodigo(Integer codigoCargo) {
		return organizacionDao.getCargoPorCodigo(codigoCargo);
	}

	public Cargo getCargoPorDescripcion(String descripcion) {
		return organizacionDao.getCargoPorDescripcion(descripcion);
	}	

	public Empleado getResponsableArea(Area area){
		return organizacionDao.getResponsableArea(area);
	}
	
}