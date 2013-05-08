package org.ge.service.impl;

import java.util.List;

import org.ge.dao.EstrategiaDao;
import org.ge.model.Estrategia;
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

}