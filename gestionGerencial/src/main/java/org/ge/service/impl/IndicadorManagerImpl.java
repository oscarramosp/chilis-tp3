package org.ge.service.impl;

import java.util.List;

import org.ge.dao.IndicadorDao;
import org.ge.model.Indicador;
import org.ge.service.IndicadorManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public
class IndicadorManagerImpl implements IndicadorManager {
	
	@Autowired
	private IndicadorDao indicadorDao;

	public List<Indicador> getListaIndicadores(String estado) {
		return indicadorDao.getListaIndicadores(estado);
	}

	public Indicador getIndicadorPorCodigo(Integer codigoIndicador) {
		return indicadorDao.getIndicadorPorCodigo(codigoIndicador);
	}

	public void guardarIndicador(Indicador indicador) {
		indicadorDao.guardarIndicador(indicador);
	}

	public List<Indicador> getListaIndicadoresPendientes() {
		List<Indicador> lista = getListaIndicadores("pendAprobacion");
		lista.addAll(getListaIndicadores("pendUpdate"));
		lista.addAll(getListaIndicadores("pendBaja"));
		return lista;		
	}

}