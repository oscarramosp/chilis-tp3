package org.ge.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.ge.dao.EstrategiaDao;
import org.ge.model.Area;
import org.ge.model.Estrategia;
import org.ge.model.Objetivo;
import org.ge.model.ObjetivoFuncional;
import org.ge.service.EstrategiaManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public
class EstrategiaManagerImpl implements EstrategiaManager {
	
	@Autowired
	private EstrategiaDao estrategiaDao;

	public List<Estrategia> getListaEstrategias(String estado) {
		return estrategiaDao.getListaEstrategias(estado);
	}

	public List<Estrategia> getListaEstrategias(
			Estrategia estrategia) {
		return estrategiaDao.getListaEstrategias(estrategia);
	}
	
	public List<Estrategia> getListaEstrategiasPorFechas(Estrategia estrategia){
		List<Estrategia> lista = estrategiaDao.getListaEstrategias(estrategia);
		List<Estrategia> aux = new ArrayList<Estrategia>();
		for(Estrategia est : lista){
			if((est.getFechaInicio().after(estrategia.getFechaInicio()) || estrategia.getFechaInicio().equals(est.getFechaInicio()))
					&& (est.getFechaFin().before(estrategia.getFechaFin())|| estrategia.getFechaFin().equals(est.getFechaFin()))){
				aux.add(est);
			}
		}
		return aux;
	}
	
	public Estrategia getEstrategiaPorCodigo(Integer codigoEstrategia) {
		return estrategiaDao.getEstrategiaPorCodigo(codigoEstrategia);
	}

	public void guardarEstrategia(Estrategia estrategia) {
		estrategiaDao.guardarEstrategia(estrategia);
	}

	public List<Estrategia> getListaEstrategiasPendientes() {
		List<Estrategia> lista = getListaEstrategias("pendAprobacion");
		lista.addAll(getListaEstrategias("pendUpdate"));
		lista.addAll(getListaEstrategias("pendBaja"));
		return lista;		
	}
	
	public boolean isRepeatNombre(String nombre,
			Integer codigoEstrategia) {
		return estrategiaDao.isRepeatDescription(nombre, codigoEstrategia);
	}
	
	public List<Estrategia> getListaEstrategiasPendientesPorArea(Area area) {
		List<Estrategia> lista = getListaEstrategiasPendientes();
		List<Estrategia> aux = new ArrayList<>();
		if (area.getCodigo().equals(5)) {
			for (Estrategia estrategia : lista) {
				if (estrategia.getObjetivoEstrategia().getTipoObjetivo().equals("General")) {aux.add(estrategia);
				}
			}
		}
			for (Estrategia estrategia : lista) {
				if (estrategia.getObjetivoEstrategia().getTipoObjetivo().equals("Funcional")) {
					if (estrategia.getObjetivoEstrategia().getTipoObjetivo().equals("Funcional")&& (((ObjetivoFuncional) estrategia.getObjetivoEstrategia()).getArea().getCodigo().equals(area.getCodigo()))) {
						aux.add(estrategia);
					}
				}
			}
		return aux;
	}
	
	public List<Estrategia> getListaEstrategiasPendientesAprobacionPorArea(Area area) {
		List<Estrategia> lista = getListaEstrategias("pendAprobacion");
		List<Estrategia> aux = new ArrayList<>();
		if (area.getCodigo().equals(5)) {
			for (Estrategia estrategia : lista) {
				if (estrategia.getObjetivoEstrategia().getTipoObjetivo().equals("General")) {aux.add(estrategia);
				}
			}
		}
			for (Estrategia estrategia : lista) {
				if (estrategia.getObjetivoEstrategia().getTipoObjetivo().equals("Funcional")) {
					if (estrategia.getObjetivoEstrategia().getTipoObjetivo().equals("Funcional")&& (((ObjetivoFuncional) estrategia.getObjetivoEstrategia()).getArea().getCodigo().equals(area.getCodigo()))) {
						aux.add(estrategia);
					}
				}
			}
		return aux;
	}
	
	public List<Estrategia> getListaEstrategiasPendientesActualizacionPorArea(Area area) {
		List<Estrategia> lista = getListaEstrategias("pendUpdate");
		List<Estrategia> aux = new ArrayList<>();
		if (area.getCodigo().equals(5)) {
			for (Estrategia estrategia : lista) {
				if (estrategia.getObjetivoEstrategia().getTipoObjetivo().equals("General")) {aux.add(estrategia);
				}
			}
		}
			for (Estrategia estrategia : lista) {
				if (estrategia.getObjetivoEstrategia().getTipoObjetivo().equals("Funcional")) {
					if (estrategia.getObjetivoEstrategia().getTipoObjetivo().equals("Funcional")&& (((ObjetivoFuncional) estrategia.getObjetivoEstrategia()).getArea().getCodigo().equals(area.getCodigo()))) {
						aux.add(estrategia);
					}
				}
			}
		return aux;
	}
	
	public List<Estrategia> getListaEstrategiasPendientesBajaPorArea(Area area) {
		List<Estrategia> lista = getListaEstrategias("pendBaja");
		List<Estrategia> aux = new ArrayList<>();
		if (area.getCodigo().equals(5)) {
			for (Estrategia estrategia : lista) {
				if (estrategia.getObjetivoEstrategia().getTipoObjetivo().equals("General")) {aux.add(estrategia);
				}
			}
		}
			for (Estrategia estrategia : lista) {
				if (estrategia.getObjetivoEstrategia().getTipoObjetivo().equals("Funcional")) {
					if (estrategia.getObjetivoEstrategia().getTipoObjetivo().equals("Funcional")&& (((ObjetivoFuncional) estrategia.getObjetivoEstrategia()).getArea().getCodigo().equals(area.getCodigo()))) {
						aux.add(estrategia);
					}
				}
			}
		return aux;
	}
}