package org.ge.service;

import java.util.List;

import org.ge.model.MapaEstrategico;

public interface MapaEstrategicoManager {

	public List<MapaEstrategico> getListaMapasEstrategicos(String estado);

	public MapaEstrategico getMapaEstrategicoPorCodigo(Integer codigoMapaEstrategico);

	public void guardarMapaEstrategico(MapaEstrategico mapaEstrategico);
	
	public List<MapaEstrategico> getListaMapasEstrategicosPendientes();
}
