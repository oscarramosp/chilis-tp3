package org.ge.service;

import java.util.List;

import org.ge.model.PlanAccion;

public interface PlanAccionManager {

	public List<PlanAccion> getListaPlanesAccion(String estado);

	public PlanAccion getPlanAccionPorCodigo(Integer codigoPlanAccion);

	public void guardarPlanAccion(PlanAccion planAccion);
	
	public List<PlanAccion> getListaPlanesAccionPendientes();
}
