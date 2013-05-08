package org.ge.service;

import java.util.List;

import org.ge.model.Estrategia;

public interface EstrategiaManager {

	public List<Estrategia> getListaEstrategias(String estado);

	public Estrategia getEstrategiaPorCodigo(Integer codigoEstrategia);

	public void guardarEstrategia(Estrategia estrategia);
	
	public List<Estrategia> getListaEstrategiasPendientes();
}
