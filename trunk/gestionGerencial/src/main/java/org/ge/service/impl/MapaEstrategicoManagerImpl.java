package org.ge.service.impl;

import java.util.List;

import org.ge.dao.MapaEstrategicoDao;
import org.ge.model.MapaEstrategico;
import org.ge.service.MapaEstrategicoManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public
class MapaEstrategicoManagerImpl implements MapaEstrategicoManager {
	
	@Autowired
	private MapaEstrategicoDao mapaEstrategicoDao;

	public List<MapaEstrategico> getListaMapasEstrategicos(String estado) {
		return mapaEstrategicoDao.getListaMapasEstrategicos(estado);
	}

	public MapaEstrategico getMapaEstrategicoPorCodigo(Integer codigoMapaEstrategico) {
		return mapaEstrategicoDao.getMapaEstrategicoPorCodigo(codigoMapaEstrategico);
	}

	public void guardarMapaEstrategico(MapaEstrategico mapaEstrategico) {
		mapaEstrategicoDao.guardarMapaEstrategico(mapaEstrategico);
	}

	public List<MapaEstrategico> getListaMapasEstrategicosPendientes() {
		List<MapaEstrategico> lista = getListaMapasEstrategicos("pendAprobacion");
		lista.addAll(getListaMapasEstrategicos("pendUpdate"));
		lista.addAll(getListaMapasEstrategicos("pendBaja"));
		return lista;		
	}

}