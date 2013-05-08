package org.ge.dao;

import java.util.List;

import org.ge.model.MapaEstrategico;

public interface MapaEstrategicoDao {
	
	public List<MapaEstrategico> getListaMapasEstrategicos(String estado);

	public MapaEstrategico getMapaEstrategicoPorCodigo(Integer codigoMapaEstrategico);

	public void guardarMapaEstrategico(MapaEstrategico mapaEstrategico);

}