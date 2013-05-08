package org.ge.dao;

import java.util.List;

import org.ge.model.Estrategia;

public interface EstrategiaDao {
	
	public List<Estrategia> getListaEstrategias(String estado);

	public Estrategia getEstrategiaPorCodigo(Integer codigoEstrategia);

	public void guardarEstrategia(Estrategia estrategia);

}