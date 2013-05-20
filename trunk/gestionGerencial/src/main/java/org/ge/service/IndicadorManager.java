package org.ge.service;

import java.util.List;

import org.ge.model.Indicador;
import org.ge.util.IndicadorUtil;

public interface IndicadorManager {

	public List<Indicador> getListaIndicadores(String estado);
	
	public List<Indicador> getListaIndicadores(Indicador indicador);

	public Indicador getIndicadorPorCodigo(Integer codigoIndicador);
	
	public IndicadorUtil getIndicadorUtilPorCodigo(Integer codigoIndicador);

	public void guardarIndicador(Indicador indicador);
	
	public List<Indicador> getListaIndicadoresPendientes();
	
	public boolean isRepeatNombre(String descripcion,Integer codigoIndicador);
}
