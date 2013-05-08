package org.ge.dao;

import java.util.List;

import org.ge.model.PlanAccion;

public interface PlanAccionDao {
	
	public List<PlanAccion> getListaPlanesAccion(String estado);

	public PlanAccion getPlanAccionPorCodigo(Integer codigoPlanAccion);

	public void guardarPlanAccion(PlanAccion planAccion);

}