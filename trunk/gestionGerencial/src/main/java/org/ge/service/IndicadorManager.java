package org.ge.service;

import java.util.List;

import org.ge.model.Indicador;

public interface IndicadorManager {

	public List<Indicador> getListaIndicadores(String estado);
	
	public List<Indicador> getListaIndicadores(Indicador indicador);

	public Indicador getIndicadorPorCodigo(Integer codigoIndicador);

	public void guardarIndicador(Indicador indicador);
	
	public List<Indicador> getListaIndicadoresPendientes();
}
