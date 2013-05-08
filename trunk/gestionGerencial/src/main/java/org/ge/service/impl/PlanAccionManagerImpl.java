package org.ge.service.impl;

import java.util.List;

import org.ge.dao.PlanAccionDao;
import org.ge.model.PlanAccion;
import org.ge.service.PlanAccionManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public
class PlanAccionManagerImpl implements PlanAccionManager {
	
	@Autowired
	private PlanAccionDao planAccionDao;

	public List<PlanAccion> getListaPlanesAccion(String estado) {
		return planAccionDao.getListaPlanesAccion(estado);
	}

	public PlanAccion getPlanAccionPorCodigo(Integer codigoPlanAccion) {
		return planAccionDao.getPlanAccionPorCodigo(codigoPlanAccion);
	}

	public void guardarPlanAccion(PlanAccion planAccion) {
		planAccionDao.guardarPlanAccion(planAccion);
	}

	public List<PlanAccion> getListaPlanesAccionPendientes() {
		List<PlanAccion> lista = getListaPlanesAccion("pendAprobacion");
		lista.addAll(getListaPlanesAccion("pendUpdate"));
		lista.addAll(getListaPlanesAccion("pendBaja"));
		return lista;		
	}

}